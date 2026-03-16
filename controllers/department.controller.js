const db = require('../config/db');

const getDepartments = async (req, res) => {
    try {
        // ดึงข้อมูลกลุ่มงานเฉพาะที่เปิดใช้งานอยู่ และเรียงตามลำดับ ID
        const [departments] = await db.query(
            'SELECT * FROM mst_departments WHERE is_active = 1 ORDER BY department_id ASC'
        );
        res.status(200).json(departments);
    } catch (error) {
        console.error('Error fetching departments:', error);
        res.status(500).json({ message: 'เกิดข้อผิดพลาดในการดึงข้อมูลกลุ่มงาน', error: error.message });
    }
};

module.exports = { getDepartments };