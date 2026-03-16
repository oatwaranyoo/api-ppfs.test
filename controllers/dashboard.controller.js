const db = require('../config/db');

const getSummary = async (req, res) => {
    try {
        // 1. ดึงสรุปยอดรวม สปสช. (จำนวนบรรทัด และ จำนวนเงินรวม)
        const [[nhsoSummary]] = await db.execute(`
            SELECT COUNT(id) as total_rows, SUM(amount) as total_money 
            FROM trn_data_nhso
        `);

        // 2. ดึง 5 อันดับ 'กิจกรรมหลัก' ที่ทำเงินสูงสุด (สำหรับทำกราฟ)
        // หมายเหตุ: Highcharts ต้องการ key 'name' (ชื่อ) และ 'y' (ค่าตัวเลข)
        const [chartData] = await db.execute(`
            SELECT main_activity as name, SUM(amount) as y 
            FROM trn_data_nhso 
            WHERE main_activity IS NOT NULL AND main_activity != ''
            GROUP BY main_activity 
            ORDER BY y DESC 
            LIMIT 5
        `);

        // 3. ดึงจำนวน User ที่เปิดใช้งานอยู่
        const [[usersSummary]] = await db.execute(`
            SELECT COUNT(id) as total_users 
            FROM sys_users 
            WHERE is_active = 1
        `);

        res.status(200).json({
            status: 'success',
            data: {
                nhso_total_rows: parseInt(nhsoSummary.total_rows || 0),
                nhso_total_money: parseFloat(nhsoSummary.total_money || 0),
                total_users: parseInt(usersSummary.total_users || 0),
                chart_data: chartData.map(item => ({
                    name: item.name,
                    y: parseFloat(item.y)
                }))
            }
        });
    } catch (error) {
        console.error("Dashboard Summary Error:", error);
        res.status(500).json({ error: error.message });
    }
};

module.exports = { getSummary };