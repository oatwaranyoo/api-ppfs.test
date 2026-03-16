const db = require('../config/db');
const bcrypt = require('bcryptjs'); // หากรหัสผ่านใน DB ของคุณยังไม่ได้เข้ารหัส อาจจะต้องปรับส่วน bcrypt.compare ครับ
const jwt = require('jsonwebtoken');

const login = async (req, res) => {
    try {
        const { username, password } = req.body;
        
        // 1. ตรวจสอบผู้ใช้งานและระบบ Brute Force (locked_until)
        const [users] = await db.query(`SELECT * FROM sys_users WHERE username = ?`, [username]);
        if (users.length === 0) return res.status(401).json({ message: 'ชื่อผู้ใช้งานหรือรหัสผ่านไม่ถูกต้อง' });
        
        const user = users[0];

        // เช็คว่าบัญชีถูกล็อกอยู่หรือไม่
        if (user.locked_until && new Date() < new Date(user.locked_until)) {
            return res.status(403).json({ message: 'บัญชีถูกระงับชั่วคราวเนื่องจากใส่รหัสผิดเกินกำหนด กรุณารอ 15 นาที' });
        }

        // 2. ตรวจสอบ Password (สมมติว่าใน DB เข้ารหัสด้วย bcrypt ไว้)
        // [หมายเหตุ]: หากในฐานข้อมูลของคุณยังใช้รหัสแบบ Plain Text ให้เปลี่ยนเป็น -> if (password !== user.password) {
        const isMatch = await bcrypt.compare(password, user.password);
        
        if (!isMatch) {
            // [SRS Critical] เพิ่มจำนวนครั้งที่ใส่รหัสผิด
            const failedAttempts = (user.failed_attempts || 0) + 1;
            let lockedUntil = null;
            if (failedAttempts >= 5) {
                lockedUntil = new Date(Date.now() + 15 * 60000); // ล็อก 15 นาที
            }
            // หากเกิด Error ว่าไม่มีฟิลด์ failed_attempts ในตาราง ให้ไป ALTER TABLE ในฐานข้อมูลเพิ่มนะครับ
            await db.query(`UPDATE sys_users SET failed_attempts = ?, locked_until = ? WHERE id = ?`, [failedAttempts, lockedUntil, user.id]);
            
            return res.status(401).json({ message: 'ชื่อผู้ใช้งานหรือรหัสผ่านไม่ถูกต้อง' });
        }

        // รีเซ็ตจำนวนครั้งที่ผิด เมื่อ Login สำเร็จ
        await db.query(`UPDATE sys_users SET failed_attempts = 0, locked_until = NULL WHERE id = ?`, [user.id]);

        // 3. [SRS Critical] JWT Split-Token
        const token = jwt.sign(
            { id: user.id, username: user.username, role: user.role, hoscode: user.hoscode }, 
            process.env.JWT_SECRET || 'your_super_secret_key', 
            { expiresIn: '8h' }
        );

        // แยกร่าง Token (Header.Payload.Signature)
        const tokenParts = token.split('.');
        const payloadPart = `${tokenParts[0]}.${tokenParts[1]}`; // ส่วนที่ 1: Header + Payload
        const signaturePart = tokenParts[2]; // ส่วนที่ 2: Signature

        // ส่ง Signature กลับไปในรูปแบบ HttpOnly Cookie (ดึงขโมยผ่าน JavaScript ไม่ได้)
        res.cookie('token_signature', signaturePart, {
            httpOnly: true,
            secure: process.env.NODE_ENV === 'production', 
            sameSite: 'strict',
            maxAge: 8 * 60 * 60 * 1000 // 8 ชั่วโมง
        });

        // ส่ง Payload กลับไปให้ Frontend เก็บลง SessionStorage
        res.status(200).json({
            message: 'เข้าสู่ระบบสำเร็จ',
            user: { id: user.id, username: user.username, role: user.role, hoscode: user.hoscode },
            token_payload: payloadPart
        });

    } catch (error) {
        console.error('Login Error:', error);
        res.status(500).json({ message: 'เกิดข้อผิดพลาดในระบบ' });
    }
};

const logout = (req, res) => {
    // ล้าง Cookie ทิ้ง
    res.clearCookie('token_signature');
    res.status(200).json({ message: 'ออกจากระบบสำเร็จ' });
};

module.exports = { login, logout };