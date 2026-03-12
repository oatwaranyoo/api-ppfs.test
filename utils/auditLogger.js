const db = require('../config/db');

/**
 * ฟังก์ชันสำหรับบันทึก Log ลงตาราง sys_audit_logs
 */
const logAction = async (actionType, tableName, recordId, oldValues, newValues, actedBy) => {
    try {
        await db.query(
            `INSERT INTO sys_audit_logs 
            (action_type, table_name, record_id, old_values, new_values, acted_by) 
            VALUES (?, ?, ?, ?, ?, ?)`,
            [
                actionType,
                tableName,
                recordId,
                oldValues ? JSON.stringify(oldValues) : null,
                newValues ? JSON.stringify(newValues) : null,
                actedBy
            ]
        );
    } catch (error) {
        console.error('Audit Log Error:', error.message);
    }
};

module.exports = { logAction };