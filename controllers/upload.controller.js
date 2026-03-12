const db = require('../config/db');
const { logAction } = require('../utils/auditLogger');

// 1. นำเข้าเป้าหมาย (HDC Target)
const uploadHdcTarget = async (req, res) => {
    try {
        const { data, batch_id, fiscal_year } = req.body;
        const userId = req.user.id;
        const validRows = [];
        const errorRows = [];

        data.forEach((row, index) => {
            const fYear = row.fiscal_year || fiscal_year;
            const activityYear = String(row.sub_activity_id).substring(0, 4);

            // เช็คว่า 4 หลักแรกของกิจกรรม ตรงกับปีงบประมาณหรือไม่
            if (activityYear !== String(fYear)) {
                errorRows.push({
                    row_index: index + 1,
                    data: row,
                    reason: `รหัสกิจกรรม (${activityYear}) ไม่ตรงกับปีงบ (${fYear})`
                });
            } else {
                validRows.push([
                    fYear,
                    String(row.hoscode).padStart(5, '0'),
                    row.sub_activity_id,
                    row.target_people || 0,
                    batch_id,
                    0, 
                    userId
                ]);
            }
        });

        if (validRows.length > 0) {
            await db.query(`REPLACE INTO trn_hdc_targets (fiscal_year, hoscode, sub_activity_id, target_people, batch_id, is_valid, updated_by) VALUES ?`, [validRows]);
        }

        res.status(200).json({ successCount: validRows.length, errorCount: errorRows.length, errors: errorRows });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};

// 2. นำเข้าผลงาน (HDC Performance)
const uploadHdcResult = async (req, res) => {
    try {
        const { data, batch_id, fiscal_year } = req.body;
        const userId = req.user.id;
        const validRows = [];
        const errorRows = [];

        data.forEach((row, index) => {
            const aYear = parseInt(row.actual_year);
            const aMonth = parseInt(row.actual_month);
            // แปลงเดือน/ปีจริง เป็นปีงบประมาณ
            const mapped_fYear = aMonth >= 10 ? aYear + 1 : aYear;
            const month_no = aMonth >= 10 ? aMonth - 9 : aMonth + 3;
            
            const activityYear = String(row.sub_activity_id).substring(0, 4);

            // เช็คว่า 4 หลักแรกของกิจกรรม ตรงกับปีงบประมาณที่คำนวณได้หรือไม่
            if (activityYear !== String(mapped_fYear)) {
                errorRows.push({
                    row_index: index + 1,
                    data: row,
                    reason: `รหัสกิจกรรม (${activityYear}) ไม่ตรงกับปีงบที่คำนวณได้ (${mapped_fYear})`
                });
            } else {
                validRows.push([
                    mapped_fYear,
                    month_no,
                    String(row.hoscode).padStart(5, '0'),
                    row.sub_activity_id,
                    row.actual_people || 0,
                    row.actual_visit || 0,
                    batch_id,
                    0, 
                    userId
                ]);
            }
        });

        if (validRows.length > 0) {
            await db.query(`REPLACE INTO trn_hdc_performance (fiscal_year, month_no, hoscode, sub_activity_id, actual_people, actual_visit, batch_id, is_valid, updated_by) VALUES ?`, [validRows]);
        }

        res.status(200).json({ successCount: validRows.length, errorCount: errorRows.length, errors: errorRows });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};

// 3. Finalize
const finalizeHdc = async (req, res) => {
    const connection = await db.getConnection();
    try {
        const { batch_id, type } = req.body;
        const userId = req.user.id;
        await connection.beginTransaction();
        const table = type === 'target' ? 'trn_hdc_targets' : 'trn_hdc_performance';

        // 🟢 แก้ไขตรงนี้: เปลี่ยนจาก as rows เป็น as row_count
        const [newInfo] = await connection.query(`SELECT COUNT(*) as row_count, fiscal_year FROM ${table} WHERE batch_id = ? GROUP BY fiscal_year`, [batch_id]);

        if (newInfo.length > 0) {
            const years = newInfo.map(n => n.fiscal_year);
            
            // 🟢 แก้ไขตรงนี้: เปลี่ยนจาก as rows เป็น as row_count
            const [oldInfo] = await connection.query(`SELECT batch_id, COUNT(*) as row_count, fiscal_year FROM ${table} WHERE is_valid = 1 AND fiscal_year IN (?) GROUP BY batch_id, fiscal_year`, [years]);

            // สลับสถานะ
            await connection.query(`UPDATE ${table} SET is_valid = 0 WHERE fiscal_year IN (?)`, [years]);
            await connection.query(`UPDATE ${table} SET is_valid = 1 WHERE batch_id = ?`, [batch_id]);

            // บันทึกประวัติการแก้ไข
            await logAction('UPDATE', table, batch_id, 
                { desc: 'ข้อมูลชุดเดิมที่ถูกปลด', data: oldInfo }, 
                { desc: 'ข้อมูลชุดใหม่ที่ถูกเปิดใช้งาน', data: newInfo }, 
                userId
            );

            await connection.commit();
            res.status(200).json({ message: 'Success' });
        } else {
            await connection.rollback();
            res.status(404).json({ error: 'ไม่พบข้อมูลใน Batch นี้' });
        }
    } catch (error) {
        await connection.rollback();
        console.error('Finalize Error:', error);
        res.status(500).json({ error: error.message });
    } finally {
        connection.release();
    }
};

module.exports = { uploadHdcTarget, uploadHdcResult, finalizeHdc };