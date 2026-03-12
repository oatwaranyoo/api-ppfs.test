const db = require('../config/db');

const getAuditLogs = async (req, res) => {
    try {
        const [rows] = await db.execute(`
            SELECT 
                l.*, 
                l.acted_at AS acted_at, 
                u.first_name, 
                u.last_name 
            FROM sys_audit_logs l
            LEFT JOIN sys_users u ON l.acted_by = u.id
            ORDER BY l.acted_at DESC
            LIMIT 100
        `);
        res.status(200).json(rows);
    } catch (error) {
        console.error('Fetch Logs Error:', error);
        res.status(500).json({ error: error.message });
    }
};

module.exports = { getAuditLogs };