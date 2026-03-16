const db = require('../config/db');

const getSummary = async (req, res) => {
    // [SRS MUST] ดึง Connection เดี่ยวออกมาจาก Pool เพื่อกำหนดระดับ Isolation ของ Session นี้เท่านั้น
    const connection = await db.getConnection();
    
    try {
        // [SRS MUST] DB Lock Prevention (Dirty Read อนุญาตสำหรับ Dashboard)
        await connection.query(`SET SESSION TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;`);

        // [SRS Critical] Dashboard Maintenance Sync Guard
        let isRecalculating = false;
        try {
            const [locks] = await connection.query(`
                SELECT 1 
                FROM sys_upload_locks 
                WHERE scope_key = 'sys_cascade_recalc' 
                LIMIT 1
            `);
            if (locks.length > 0) {
                isRecalculating = true;
            }
        } catch (err) {
            console.warn("Maintenance Sync Guard check skipped:", err.message);
        }

        // 1. ดึงสรุปยอดรวม สปสช. 
        const [nhsoRows] = await connection.query(`
            SELECT COUNT(*) as total_rows, SUM(allocated_budget) as total_money 
            FROM trn_budget_allocation
            WHERE is_valid = 1
        `);
        const nhsoSummary = nhsoRows[0];

        // 2. ดึง 5 อันดับ 'กิจกรรมหลัก'
        const [chartData] = await connection.query(`
            SELECT 
                m.main_activity_name as name, 
                SUM(t.allocated_budget) as y 
            FROM trn_budget_allocation t
            LEFT JOIN mst_sub_activities s ON t.sub_activity_id = s.sub_activity_id AND t.fiscal_year = s.fiscal_year
            LEFT JOIN mst_main_activities m ON s.main_activity_id = m.main_activity_id AND s.fiscal_year = m.fiscal_year
            WHERE t.is_valid = 1 
              AND m.main_activity_name IS NOT NULL
            GROUP BY m.main_activity_name 
            ORDER BY y DESC 
            LIMIT 5
        `);

        // 3. ดึงจำนวน User ที่เปิดใช้งานอยู่ (แก้ไขตรงนี้: ใช้ status = 'active' แทน is_active)
        const [usersRows] = await connection.query(`
            SELECT COUNT(id) as total_users 
            FROM sys_users 
            WHERE status = 'active'
        `);
        const usersSummary = usersRows[0];

        res.status(200).json({
            status: 'success',
            is_recalculating: isRecalculating,
            data: {
                nhso_total_rows: parseInt(nhsoSummary.total_rows || 0),
                nhso_total_money: parseFloat(nhsoSummary.total_money || 0),
                total_users: parseInt(usersSummary.total_users || 0),
                chart_data: chartData.map(item => ({
                    name: item.name,
                    y: parseFloat(item.y || 0)
                }))
            }
        });
    } catch (error) {
        console.error("Dashboard Summary Error:", error);
        res.status(500).json({ error: error.message });
    } finally {
        // [Critical] คืนค่าระดับ Isolation กลับเป็นปกติก่อนคืน Connection กลับเข้า Pool
        await connection.query(`SET SESSION TRANSACTION ISOLATION LEVEL REPEATABLE READ;`);
        connection.release();
    }
};

module.exports = { getSummary };