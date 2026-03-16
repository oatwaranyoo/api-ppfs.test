const db = require('../config/db');

const getNhsoData = async (req, res) => {
    try {
        // รับค่าพารามิเตอร์จาก React (ค่าเริ่มต้น หน้า 1, แสดง 10 รายการ)
        const page = parseInt(req.query.page) || 1;
        const limit = parseInt(req.query.limit) || 10;
        const search = req.query.search || '';
        const year = req.query.year || '';
        const offset = (page - 1) * limit;

        let whereConditions = [];
        let params = [];
        let countParams = [];

        // ถ้ามีการเลือกปีงบประมาณ
        if (year) {
            whereConditions.push('fiscal_year = ?');
            params.push(year);
            countParams.push(year);
        }

        // ถ้ามีการพิมพ์ค้นหา (รหัสหน่วยบริการ, กิจกรรมหลัก, กิจกรรมย่อย)
        if (search) {
            whereConditions.push('(hoscode LIKE ? OR main_activity LIKE ? OR sub_id LIKE ?)');
            const searchStr = `%${search}%`;
            params.push(searchStr, searchStr, searchStr);
            countParams.push(searchStr, searchStr, searchStr);
        }

        const whereClause = whereConditions.length > 0 ? 'WHERE ' + whereConditions.join(' AND ') : '';

        // 1. นับจำนวนข้อมูลทั้งหมด (สำหรับการทำ Pagination ใน React)
        const countSql = `SELECT COUNT(id) as total FROM trn_data_nhso ${whereClause}`;
        const [[{ total }]] = await db.execute(countSql, countParams);

        // 2. ดึงข้อมูลตามหน้า (Pagination: LIMIT & OFFSET)
        const sql = `
            SELECT * FROM trn_data_nhso 
            ${whereClause} 
            ORDER BY fiscal_year DESC, id DESC 
            LIMIT ? OFFSET ?
        `;
        params.push(limit, offset);

        const [rows] = await db.execute(sql, params);

        res.status(200).json({
            data: rows,
            total: total,
            page: page,
            limit: limit
        });

    } catch (error) {
        console.error("Get NHSO Data Error:", error);
        res.status(500).json({ error: error.message });
    }
};

module.exports = { getNhsoData };