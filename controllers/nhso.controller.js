const db = require('../config/db');

const getNhsoData = async (req, res) => {
    try {
        // [SRS Critical] Valid Data Query & Soft-Delete JOIN
        // ดึงเฉพาะข้อมูลที่ is_valid = 1 และใช้ LEFT JOIN เสมอ
        const [rows] = await db.query(`
            SELECT 
                t.id, 
                t.fiscal_year, 
                t.hoscode, 
                COALESCE(h.hosname, 'ไม่ระบุชื่อหน่วยบริการ') as hosname, 
                COALESCE(s.sub_activity_name, 'ไม่ระบุกิจกรรม') as activity, 
                t.allocated_budget as budget, 
                DATE_FORMAT(t.updated_at, '%Y-%m-%d %H:%i') as updated_at
            FROM trn_budget_allocation t
            LEFT JOIN mst_hospitals h ON t.hoscode = h.hoscode
            LEFT JOIN mst_sub_activities s ON t.sub_activity_id = s.sub_activity_id AND t.fiscal_year = s.fiscal_year
            WHERE t.is_valid = 1
            ORDER BY t.fiscal_year DESC, t.updated_at DESC
            LIMIT 2000
        `);

        res.status(200).json(rows);
    } catch (error) {
        console.error('Error fetching NHSO data:', error);
        res.status(500).json({ message: 'เกิดข้อผิดพลาดในการดึงข้อมูล สปสช.', error: error.message });
    }
};

module.exports = { getNhsoData };