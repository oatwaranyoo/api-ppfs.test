const db = require('../config/db');
const bcrypt = require('bcryptjs'); 
const jwt = require('jsonwebtoken');
const crypto = require('crypto'); // [SRS] เพิ่ม crypto สำหรับทำ Fingerprinting

const login = async (req, res) => {
    try {
        const { username, password } = req.body;
        
        // 1. ตรวจสอบผู้ใช้งานและระบบ Brute Force (locked_until)
        // [แก้ไข] เช็คสถานะ status = 'active' ตาม DB
        const [users] = await db.query(`SELECT * FROM sys_users WHERE username = ? AND status = 'active'`, [username]);
        if (users.length === 0) return res.status(401).json({ message: 'ชื่อผู้ใช้งานหรือรหัสผ่านไม่ถูกต้อง หรือบัญชีถูกระงับ' });
        
        const user = users[0];

        if (user.locked_until && new Date() < new Date(user.locked_until)) {
            return res.status(403).json({ message: 'บัญชีถูกระงับชั่วคราวเนื่องจากใส่รหัสผิดเกินกำหนด กรุณารอ 15 นาที' });
        }

        // 2. ตรวจสอบ Password 
        // [แก้ไข] เปลี่ยนจาก user.password เป็น user.password_hash ตาม SQL
        const isMatch = await bcrypt.compare(password, user.password_hash);
        
        if (!isMatch) {
            const failedAttempts = (user.failed_attempts || 0) + 1;
            let lockedUntil = null;
            if (failedAttempts >= 5) {
                lockedUntil = new Date(Date.now() + 15 * 60000); // ล็อก 15 นาที
            }
            await db.query(`UPDATE sys_users SET failed_attempts = ?, locked_until = ? WHERE id = ?`, [failedAttempts, lockedUntil, user.id]);
            
            return res.status(401).json({ message: 'ชื่อผู้ใช้งานหรือรหัสผ่านไม่ถูกต้อง' });
        }

        // รีเซ็ตจำนวนครั้งที่ผิด เมื่อ Login สำเร็จ
        await db.query(`UPDATE sys_users SET failed_attempts = 0, locked_until = NULL WHERE id = ?`, [user.id]);

        // [SRS Critical] Dynamic Fingerprinting สร้าง Hash จาก User-Agent ป้องกันการขโมย Token ข้ามเครื่อง
        const currentUserAgent = req.headers['user-agent'] || 'unknown-device';
        const userAgentHash = crypto.createHash('sha256').update(currentUserAgent).digest('hex');

        // 3. [SRS Critical] JWT Split-Token
        // [แก้ไข] เปลี่ยน hoscode เป็น department_id เพราะใน sys_users ไม่มี hoscode
        const token = jwt.sign(
            { 
                id: user.id, 
                username: user.username, 
                role: user.role, 
                department_id: user.department_id, 
                token_version: user.token_version || 1, 
                ua_hash: userAgentHash 
            }, 
            process.env.JWT_SECRET || 'your_super_secret_key', 
            { expiresIn: '8h' }
        );

        // แยกร่าง Token (Header.Payload.Signature)
        const tokenParts = token.split('.');
        const payloadPart = `${tokenParts[0]}.${tokenParts[1]}`; 
        const signaturePart = tokenParts[2]; 

        // ส่ง Signature กลับไปในรูปแบบ HttpOnly Cookie
        res.cookie('token_signature', signaturePart, {
            httpOnly: true,
            secure: process.env.NODE_ENV === 'production', 
            sameSite: 'strict',
            maxAge: 8 * 60 * 60 * 1000 // 8 ชั่วโมง
        });

        // ส่ง Payload กลับไปให้ Frontend เก็บลง SessionStorage
        // [แก้ไข] เปลี่ยน hoscode เป็น department_id ในก้อน user เช่นกัน
        res.status(200).json({
            message: 'เข้าสู่ระบบสำเร็จ',
            user: { 
                id: user.id, 
                username: user.username, 
                role: user.role, 
                department_id: user.department_id,
                first_name: user.first_name,
                last_name: user.last_name
            },
            token_payload: payloadPart
        });

    } catch (error) {
        console.error('Login Error:', error);
        res.status(500).json({ message: 'เกิดข้อผิดพลาดในระบบ' });
    }
};

const logout = async (req, res) => {
    try {
        // [SRS Critical] True Server-Side Logout: อัปเดต token_version ใน DB เพื่อให้ Token ปัจจุบันใช้งานไม่ได้อีกต่อไป
        if (req.user && req.user.id) {
            await db.query(`UPDATE sys_users SET token_version = token_version + 1 WHERE id = ?`, [req.user.id]);
        }
    } catch (err) {
        console.error("Logout Token Update Error:", err);
    }
    
    // ล้าง Cookie ทิ้ง
    res.clearCookie('token_signature');
    res.status(200).json({ message: 'ออกจากระบบสำเร็จ' });
};

module.exports = { login, logout };