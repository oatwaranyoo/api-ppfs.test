const db = require('../config/db');

const getAuditLogs = async (req, res) => {
    try {
        // ⭐ ไม่ใช้ l.* เด็ดขาด เพื่อไม่ให้ MySQL ดึง JSON ก้อนใหญ่มาใส่ Memory
        const sql = `
            SELECT 
                l.id,
                l.action_type,
                l.table_name,
                l.record_id,
                l.acted_at,
                u.first_name, 
                u.last_name 
            FROM sys_audit_logs l
            LEFT JOIN sys_users u ON l.acted_by = u.id
            ORDER BY l.acted_at DESC
            LIMIT 100
        `;
        
        const [rows] = await db.execute(sql);
        res.status(200).json(rows);
    } catch (error) {
        console.error('Fetch Logs Error:', error);
        res.status(500).json({ error: error.message });
    }
};

module.exports = { getAuditLogs };