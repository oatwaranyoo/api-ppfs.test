const db = require('../config/db');

const getSummary = async (req, res) => {
    try {
        // ----------------------------------------------------------------
        // [SRS MUST] DB Lock Prevention
        // อ่านข้อมูลโดยไม่รอ Lock ป้องกัน Query ค้างเมื่อมีคนอัปโหลดไฟล์ขนาดใหญ่
        // ----------------------------------------------------------------
        await db.execute(`SET SESSION TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;`);

        // ----------------------------------------------------------------
        // [SRS Critical] Dashboard Maintenance Sync Guard
        // ตรวจสอบว่าระบบกำลังประมวลผลย้อนหลังอยู่หรือไม่ (ตรวจสอบจากตารางระบบ)
        // ----------------------------------------------------------------
        let isRecalculating = false;
        try {
            // หมายเหตุ: ปรับชื่อตารางและฟิลด์ให้ตรงกับ DB ของคุณ (สมมติใช้ชื่อตาราง sys_locks)
            const [[lockStatus]] = await db.execute(`
                SELECT 1 
                FROM sys_locks 
                WHERE scope_key = 'sys_cascade_recalc' AND is_locked = 1 
                LIMIT 1
            `);
            if (lockStatus) {
                isRecalculating = true;
            }
        } catch (err) {
            // ดัก Error ไว้กรณีที่ตารางนี้ยังไม่ได้ถูกสร้างใน DB ระบบจะได้ไม่พัง แต่ให้ข้ามการเช็คไปก่อน
            console.warn("Maintenance Sync Guard check skipped (table might not exist yet).");
        }

        // 1. ดึงสรุปยอดรวม สปสช. (จำนวนบรรทัด และ จำนวนเงินรวม)
        // [SRS Critical] เพิ่มเงื่อนไข WHERE is_valid = 1 เสมอ
        const [[nhsoSummary]] = await db.execute(`
            SELECT COUNT(id) as total_rows, SUM(amount) as total_money 
            FROM trn_data_nhso
            WHERE is_valid = 1
        `);

        // 2. ดึง 5 อันดับ 'กิจกรรมหลัก' ที่ทำเงินสูงสุด (สำหรับทำกราฟ)
        // [SRS Critical] เพิ่มเงื่อนไข AND is_valid = 1
        const [chartData] = await db.execute(`
            SELECT main_activity as name, SUM(amount) as y 
            FROM trn_data_nhso 
            WHERE main_activity IS NOT NULL 
              AND main_activity != ''
              AND is_valid = 1
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
            // ส่ง Flag แจ้งเตือนกลับไปให้ Frontend
            is_recalculating: isRecalculating,
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