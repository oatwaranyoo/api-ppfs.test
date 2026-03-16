const db = require('../config/db');
const bcrypt = require('bcryptjs');

// 1. ดึงข้อมูลผู้ใช้งานทั้งหมด (โชว์ในหน้า Users)
const getUsers = async (req, res) => {
    try {
        const [users] = await db.query(`
            SELECT 
                u.id, 
                u.username, 
                u.first_name, 
                u.last_name, 
                u.role, 
                u.status, 
                u.department_id,
                d.department_name
            FROM sys_users u
            LEFT JOIN mst_departments d ON u.department_id = d.department_id
            WHERE u.role != 'admin'
            ORDER BY u.created_at DESC
        `);
        res.status(200).json(users);
    } catch (error) {
        console.error('Error fetching users:', error);
        res.status(500).json({ message: 'เกิดข้อผิดพลาดในการดึงข้อมูลผู้ใช้งาน', error: error.message });
    }
};

// 2. ผู้ใช้งานเปลี่ยนรหัสผ่านตัวเอง (หน้า Profile)
const changePassword = async (req, res) => {
    try {
        const userId = req.user.id; // ดึง ID จาก Token ที่ล็อกอินอยู่
        const { oldPassword, newPassword } = req.body;

        // ดึงข้อมูลรหัสผ่านเดิมจาก DB
        const [users] = await db.query('SELECT password_hash FROM sys_users WHERE id = ?', [userId]);
        if (users.length === 0) return res.status(404).json({ message: 'ไม่พบข้อมูลผู้ใช้งาน' });

        // ตรวจสอบว่ารหัสเดิมตรงไหม
        const isMatch = await bcrypt.compare(oldPassword, users[0].password_hash);
        if (!isMatch) {
            return res.status(400).json({ message: 'รหัสผ่านปัจจุบันไม่ถูกต้อง' });
        }

        // เข้ารหัสผ่านใหม่ (Hash)
        const salt = await bcrypt.genSalt(10);
        const newHash = await bcrypt.hash(newPassword, salt);

        // อัปเดตลง DB (พร้อมกับเพิ่ม token_version เพื่อบังคับให้ทุกเครื่องที่ล็อกอินค้างไว้ออกจากระบบทันทีเพื่อความปลอดภัย)
        await db.query('UPDATE sys_users SET password_hash = ?, token_version = token_version + 1 WHERE id = ?', [newHash, userId]);

        res.status(200).json({ message: 'เปลี่ยนรหัสผ่านสำเร็จ กรุณาเข้าสู่ระบบใหม่' });
    } catch (error) {
        console.error('Change Password Error:', error);
        res.status(500).json({ message: 'เกิดข้อผิดพลาดในการเปลี่ยนรหัสผ่าน', error: error.message });
    }
};

// 3. แอดมินรีเซ็ตรหัสผ่านให้ผู้ใช้คนอื่น (หน้า Users)
const resetPassword = async (req, res) => {
    try {
        // [SRS] ตรวจสอบสิทธิ์ ต้องเป็น admin เท่านั้น
        if (req.user.role !== 'admin') {
            return res.status(403).json({ message: 'ไม่มีสิทธิ์ทำรายการนี้ เฉพาะผู้ดูแลระบบเท่านั้น' });
        }

        const targetId = req.params.id;
        const defaultPassword = 'password123'; // กำหนดรหัสผ่านเริ่มต้น
        
        const salt = await bcrypt.genSalt(10);
        const newHash = await bcrypt.hash(defaultPassword, salt);

        await db.query('UPDATE sys_users SET password_hash = ?, token_version = token_version + 1 WHERE id = ?', [newHash, targetId]);

        res.status(200).json({ message: 'รีเซ็ตรหัสผ่านสำเร็จ (รหัสผ่านเริ่มต้นคือ: password123)' });
    } catch (error) {
        console.error('Reset Password Error:', error);
        res.status(500).json({ message: 'เกิดข้อผิดพลาดในการรีเซ็ตรหัสผ่าน', error: error.message });
    }
};

// 4. แอดมินลบผู้ใช้งาน (หน้า Users)
const deleteUser = async (req, res) => {
    try {
        if (req.user.role !== 'admin') {
            return res.status(403).json({ message: 'ไม่มีสิทธิ์ทำรายการนี้ เฉพาะผู้ดูแลระบบเท่านั้น' });
        }

        const targetId = req.params.id;
        
        // ป้องกันแอดมินลบตัวเอง
        if (targetId == req.user.id) {
            return res.status(400).json({ message: 'ไม่สามารถลบบัญชีของตัวเองได้' });
        }

        await db.query('DELETE FROM sys_users WHERE id = ?', [targetId]);

        res.status(200).json({ message: 'ลบผู้ใช้งานสำเร็จ' });
    } catch (error) {
        console.error('Delete User Error:', error);
        res.status(500).json({ message: 'เกิดข้อผิดพลาดในการลบผู้ใช้งาน', error: error.message });
    }
};

// [เพิ่มใหม่] ตรวจสอบ Username ซ้ำแบบ Real-time
const checkUsername = async (req, res) => {
    try {
        const { username } = req.body;
        if (!username) return res.status(400).json({ message: 'กรุณาระบุ Username' });

        const [existing] = await db.query('SELECT id FROM sys_users WHERE username = ?', [username]);
        
        // ถ้า length เป็น 0 แสดงว่า Available (ใช้ได้)
        res.status(200).json({ isAvailable: existing.length === 0 });
    } catch (error) {
        console.error('Check Username Error:', error);
        res.status(500).json({ message: 'เกิดข้อผิดพลาดในการตรวจสอบ Username' });
    }
};

// [อัปเดต] เพิ่มฟิลด์ position, phone, email ในการบันทึกลงฐานข้อมูล
const createUser = async (req, res) => {
    try {
        if (req.user.role !== 'admin') {
            return res.status(403).json({ message: 'ไม่มีสิทธิ์ทำรายการนี้ เฉพาะผู้ดูแลระบบเท่านั้น' });
        }

        const { username, password, first_name, last_name, position, phone, email, role, department_id } = req.body;

        // 1. ตรวจสอบว่ามี Username นี้ในระบบหรือยัง (กันเหนียวอีกรอบ)
        const [existing] = await db.query('SELECT id FROM sys_users WHERE username = ?', [username]);
        if (existing.length > 0) {
            return res.status(400).json({ message: 'Username นี้ถูกใช้งานแล้ว กรุณาใช้ชื่ออื่น' });
        }

        // 2. เข้ารหัสผ่าน
        const salt = await bcrypt.genSalt(10);
        const password_hash = await bcrypt.hash(password, salt);

        // 3. บันทึกลงฐานข้อมูล (status เป็น 'active' เสมอ)
        await db.query(
            `INSERT INTO sys_users 
            (username, password_hash, first_name, last_name, position, phone, email, role, department_id, status)
             VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, 'active')`,
            [username, password_hash, first_name, last_name, position || null, phone || null, email || null, role, department_id || null]
        );

        res.status(201).json({ message: 'เพิ่มผู้ใช้งานสำเร็จ' });
    } catch (error) {
        console.error('Create User Error:', error);
        res.status(500).json({ message: 'เกิดข้อผิดพลาดในการเพิ่มผู้ใช้งาน', error: error.message });
    }
};

module.exports = { getUsers, changePassword, resetPassword, deleteUser, createUser, checkUsername };