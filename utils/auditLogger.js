const db = require('../config/db');

/**
 * ฟังก์ชันสำหรับบันทึก Log ลงตาราง sys_audit_logs
 */
const logAction = async (req, actionType, tableName, recordId, oldValues, description) => {
    try {
        // ดึงข้อมูลผู้ใช้จาก Token (ถ้ามี)
        const actedBy = req.user?.id || 0;
        
        // 1. ตรวจสอบและแปลง action_type ให้อยู่ในกลุ่ม ENUM ของฐานข้อมูล
        let validAction = actionType;
        if (!['INSERT', 'UPDATE', 'DELETE'].includes(actionType)) {
            // ถ้าเป็นคำอื่น เช่น 'IMPORT' ให้ใช้ 'INSERT' แทน
            validAction = 'INSERT';
        }

        // 2. record_id ในตารางบังคับ NOT NULL ดังนั้นถ้าไม่มีค่าให้ใช้ User ID ของผู้ที่ Login
        const validRecordId = recordId ? String(recordId) : String(actedBy);

        // 3. new_values ในตารางเป็นชนิดข้อมูล JSON ต้องทำการ Stringify Object ให้ถูกต้อง
        const newValues = description ? JSON.stringify({ message: description }) : null;

        await db.query(
            `INSERT INTO sys_audit_logs 
            (action_type, table_name, record_id, old_values, new_values, acted_by) 
            VALUES (?, ?, ?, ?, ?, ?)`,
            [
                validAction,
                tableName,
                validRecordId,
                oldValues ? JSON.stringify(oldValues) : null,
                newValues, 
                actedBy
            ]
        );
    } catch (error) {
        // หาก Insert ไม่สำเร็จ Error จะมาโผล่ที่ Terminal Backend ตรงนี้
        console.error('❌ Audit Log Error:', error.message);
    }
};

module.exports = { logAction };