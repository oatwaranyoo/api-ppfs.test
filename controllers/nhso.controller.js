const db = require('../config/db');

const getNhsoData = async (req, res) => {
    try {
        // [SRS Critical] ป้องกัน Lock ค้างเวลามีการดึงข้อมูลจำนวนหลายแสนบรรทัด
        await db.query(`SET SESSION TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;`);

        // รับค่าจาก Query Params สำหรับ Pagination และ Filter
        const page = parseInt(req.query.page) || 1;
        const limit = parseInt(req.query.limit) || 10;
        const offset = (page - 1) * limit;
        const search = req.query.search || '';
        const year = req.query.year || '';

        // [SRS Critical] ต้องดึงเฉพาะข้อมูลที่ is_valid = 1 เสมอ
        let whereClause = 't.is_valid = 1'; 
        const queryParams = [];

        // ตัวกรองปีงบประมาณ
        if (year) {
            whereClause += ' AND t.fiscal_year = ?';
            queryParams.push(year);
        }

        // ตัวกรองค้นหา (รหัส รพ., ชื่อกิจกรรม, รหัสกิจกรรม)
        if (search) {
            whereClause += ' AND (t.hoscode LIKE ? OR m.mapping_desc LIKE ? OR t.sub_activity_id LIKE ?)';
            queryParams.push(`%${search}%`, `%${search}%`, `%${search}%`);
        }

        // 1. นับจำนวนข้อมูลทั้งหมด (เพื่อให้ React Data Table ทำหน้า Pagination ได้ถูก)
        const countQuery = `
            SELECT COUNT(*) as total
            FROM trn_budget_allocation t
            LEFT JOIN map_nhso_activities m ON t.sub_activity_id = m.sub_activity_id AND t.fiscal_year = m.fiscal_year
            WHERE ${whereClause}
        `;
        const [[{ total }]] = await db.query(countQuery, queryParams);

        // 2. ดึงข้อมูลจริงแบบจำกัดจำนวน (LIMIT / OFFSET) 
        // [SRS Critical] บังคับใช้ LEFT JOIN กับตาราง map_nhso_activities
        const dataQuery = `
            SELECT 
                t.fiscal_year, 
                t.hoscode, 
                m.mapping_desc as main_activity, 
                t.sub_activity_id as sub_id, 
                t.month_count as people_count, 
                t.visit_count, 
                t.allocated_budget as amount
            FROM trn_budget_allocation t
            LEFT JOIN map_nhso_activities m ON t.sub_activity_id = m.sub_activity_id AND t.fiscal_year = m.fiscal_year
            WHERE ${whereClause}
            ORDER BY t.fiscal_year DESC, t.hoscode ASC
            LIMIT ? OFFSET ?
        `;
        const [data] = await db.query(dataQuery, [...queryParams, limit, offset]);

        res.status(200).json({
            status: 'success',
            total,
            data
        });

    } catch (error) {
        console.error('Error fetching NHSO data:', error);
        res.status(500).json({ message: 'เกิดข้อผิดพลาดในการดึงข้อมูลจากฐานข้อมูล' });
    }
};

module.exports = { getNhsoData };