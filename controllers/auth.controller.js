const db = require('../config/db');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const { logAction } = require('../utils/auditLogger');
require('dotenv').config();

const login = async (req, res) => {
    try {
        const { username, password } = req.body;

        if (!username || !password) {
            return res.status(400).json({ error: 'Please provide username and password' });
        }

        // แก้ไขเป็นตาราง sys_users ตามโครงสร้างฐานข้อมูลจริง
        const [rows] = await db.execute('SELECT * FROM sys_users WHERE username = ? LIMIT 1', [username]);

        if (rows.length === 0) {
            return res.status(401).json({ error: 'Invalid username or password' });
        }

        const user = rows[0];

        // ตรวจสอบสถานะการใช้งาน (เผื่อกรณีโดนระงับ)
        if (user.status !== 'active') {
            return res.status(403).json({ error: 'บัญชีผู้ใช้งานนี้ถูกระงับการใช้งาน' });
        }

        // ตรวจสอบรหัสผ่านเทียบกับ password_hash (bcrypt รองรับ Hash ที่มาจาก PHP ($2y$))
        let isMatch = false;
        try {
             isMatch = await bcrypt.compare(password, user.password_hash);
        } catch (err) {
             isMatch = false;
        }

        // Fallback สำหรับกรณีที่รหัสผ่านใน DB ยังไม่ได้เข้ารหัส
        if (!isMatch && password === user.password_hash) {
             isMatch = true;
        }

        if (!isMatch) {
            return res.status(401).json({ error: 'Invalid username or password' });
        }

        // สร้าง Payload สำหรับฝังใน Token
        const payload = {
            id: user.id,
            username: user.username,
            role: user.role,
            firstName: user.first_name,
            lastName: user.last_name,
            departmentId: user.department_id,
        };

        // สร้าง JWT Token อายุ 8 ชั่วโมง
        const token = jwt.sign(payload, process.env.JWT_SECRET, { expiresIn: '8h' });

        await logAction(
            'UPDATE',
            'sys_users',
            user.id,
            null, // ไม่ต้องเก็บค่าเก่า
            { action: 'login_success', ip: req.ip },
            user.id
        );

        res.status(200).json({
            message: 'Login successful',
            token,
            user: payload
        });

    } catch (error) {
        console.error('Login Error:', error);
        res.status(500).json({ error: 'Internal server error' });
    }
};

const logout = async (req, res) => {
    try {
        // --- ส่วนที่เพิ่มเข้ามา ---
        // เช็คก่อนว่ามี req.user ไหม (กรณีแนบ Token มาตอนกด Logout)
        if (req.user) {
            await logAction(
                'UPDATE', 
                'sys_users', 
                req.user.id, 
                null, 
                { action: 'logout_success' }, 
                req.user.id
            );
        }
        // -----------------------

        // เคลียร์ Cookie
        res.clearCookie('token', {
            httpOnly: true,
            secure: process.env.NODE_ENV === 'production',
            sameSite: 'strict',
            path: '/'
        });
        res.status(200).json({ message: 'Logged out successfully' });
    } catch (error) {
        console.error('Logout Error:', error);
        res.status(500).json({ error: 'Internal server error' });
    }
};

module.exports = { login, logout };