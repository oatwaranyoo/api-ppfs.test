const db = require('../config/db');
const { logAction } = require('../utils/auditLogger');

// ==========================================
// 1. นำเข้าข้อมูล HDC (Targets & Performance)
// ==========================================
const uploadHdcTarget = async (req, res) => {
    try {
        const { data, batch_id, fiscal_year } = req.body;
        const userId = req.user.id;
        const validRows = [];
        const errorRows = [];

        data.forEach((row, index) => {
            const fYear = row.fiscal_year || fiscal_year;
            const activityYear = String(row.sub_activity_id).substring(0, 4);

            if (activityYear !== String(fYear)) {
                errorRows.push({ row_index: index + 1, data: row, reason: `รหัสกิจกรรม (${activityYear}) ไม่ตรงกับปีงบ (${fYear})` });
            } else {
                validRows.push([ fYear, String(row.hoscode).padStart(5, '0'), row.sub_activity_id, row.target_people || 0, batch_id, 0, userId ]);
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

const uploadHdcResult = async (req, res) => {
    try {
        const { data, batch_id, fiscal_year } = req.body;
        const userId = req.user.id;
        const validRows = [];
        const errorRows = [];

        data.forEach((row, index) => {
            const aYear = parseInt(row.actual_year);
            const aMonth = parseInt(row.actual_month);
            const mapped_fYear = aMonth >= 10 ? aYear + 1 : aYear;
            const month_no = aMonth >= 10 ? aMonth - 9 : aMonth + 3;
            const activityYear = String(row.sub_activity_id).substring(0, 4);

            if (activityYear !== String(mapped_fYear)) {
                errorRows.push({ row_index: index + 1, data: row, reason: `รหัสกิจกรรม (${activityYear}) ไม่ตรงกับปีงบที่คำนวณได้ (${mapped_fYear})` });
            } else {
                validRows.push([ mapped_fYear, month_no, String(row.hoscode).padStart(5, '0'), row.sub_activity_id, row.actual_people || 0, row.actual_visit || 0, batch_id, 0, userId ]);
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

const finalizeHdc = async (req, res) => {
    const connection = await db.getConnection();
    try {
        const { batch_id, type } = req.body;
        const userId = req.user.id;
        await connection.beginTransaction();
        const table = type === 'target' ? 'trn_hdc_targets' : 'trn_hdc_performance';

        const [newInfo] = await connection.query(`SELECT COUNT(*) as row_count, fiscal_year FROM ${table} WHERE batch_id = ? GROUP BY fiscal_year`, [batch_id]);

        if (newInfo.length > 0) {
            const years = newInfo.map(n => n.fiscal_year);
            const [oldInfo] = await connection.query(`SELECT batch_id, COUNT(*) as row_count, fiscal_year FROM ${table} WHERE is_valid = 1 AND fiscal_year IN (?) GROUP BY batch_id, fiscal_year`, [years]);

            await connection.query(`UPDATE ${table} SET is_valid = 0 WHERE fiscal_year IN (?)`, [years]);
            await connection.query(`UPDATE ${table} SET is_valid = 1 WHERE batch_id = ?`, [batch_id]);

            await logAction('UPDATE', table, batch_id, { desc: 'ข้อมูลเดิม', data: oldInfo }, { desc: 'ข้อมูลใหม่', data: newInfo }, userId);
            await connection.commit();
            res.status(200).json({ message: 'Success' });
        } else {
            await connection.rollback();
            res.status(404).json({ error: 'ไม่พบข้อมูลใน Batch นี้' });
        }
    } catch (error) {
        await connection.rollback();
        res.status(500).json({ error: error.message });
    } finally {
        connection.release();
    }
};

// ==========================================
// 2. นำเข้าข้อมูล สปสช. (NHSO -> trn_budget_allocation)
// ==========================================
const uploadNhso = async (req, res) => {
    try {
        const { data, batch_id, fiscal_year } = req.body;
        const userId = req.user.id;
        const validRows = [];
        const errorRows = [];

        // 1. โหลดตาราง map_nhso_activities ทั้งหมดมาสร้างเป็น Dictionary ค้นหาแบบรวดเร็ว
        let mapDict = {};
        try {
            // ดึงฟิลด์ fiscal_year, mapping_desc, sub_activity_id ตามโครงสร้างจริง
            const [mappings] = await db.query('SELECT fiscal_year, mapping_desc, sub_activity_id FROM map_nhso_activities');
            mappings.forEach(m => {
                // สร้างคีย์ด้วย "ปีงบ-ชื่อกิจกรรม" (เช่น "2568-01_การตรวจหลังคลอด")
                if (m.fiscal_year && m.mapping_desc) {
                    mapDict[`${m.fiscal_year}-${m.mapping_desc.trim()}`] = m.sub_activity_id;
                }
            });
        } catch (err) {
            console.warn("Error loading map_nhso_activities:", err.message);
        }

        // 2. ลูปข้อมูล Excel เพื่อแปลงค่าและตรวจสอบ
        data.forEach((row, index) => {
            const fYear = row.fiscal_year || row['ปีงบ'] || row['ปีงบประมาณ'] || fiscal_year;
            const hCode = String(row.hoscode || row['รหัสหน่วยบริการ'] || '').padStart(5, '0');
            
            let subActId = row.sub_activity_id || row['รหัสกิจกรรมย่อย'];
            const nhsoActivityName = row['กิจกรรมย่อย'];

            // ถ้าไฟล์ให้ชื่อกิจกรรมมา (ไม่มีรหัส) ให้ใช้ Dictionary หาจับคู่ให้
            if (!subActId && nhsoActivityName) {
                subActId = mapDict[`${fYear}-${String(nhsoActivityName).trim()}`];
            }

            const monthCount = parseInt(row.month_count || row['จำนวนเดือน']) || 12;
            const visitCount = parseInt(row.visit_count || row['จำนวนครั้ง']) || 0;
            const allocatedBudget = parseFloat(row.allocated_budget || row['จำนวนเงินจ่าย'] || row['จำนวนเงินจัดสรร'] || row['งบประมาณจัดสรร']) || 0;

            // ตรวจสอบความถูกต้อง
            if (!subActId) {
                errorRows.push({
                    row_index: index + 1,
                    data: row,
                    reason: nhsoActivityName ? `ไม่มีการจับคู่ (Mapping) ของกิจกรรม: "${nhsoActivityName}" สำหรับปี ${fYear}` : `ไม่พบรหัสหรือชื่อกิจกรรมในแถวนี้`
                });
            } else {
                const activityYear = String(subActId).substring(0, 4);
                // เช็ค 4 หลักแรกของ sub_activity_id ต้องตรงกับปีงบประมาณ
                if (activityYear !== String(fYear)) {
                    errorRows.push({
                        row_index: index + 1,
                        data: row,
                        reason: `รหัสกิจกรรมที่ได้ (${subActId}) ไม่ตรงกับปีงบประมาณ (${fYear})`
                    });
                } else {
                    validRows.push([
                        fYear, monthCount, hCode, subActId, visitCount, allocatedBudget, batch_id, 0, userId
                    ]);
                }
            }
        });

        // 3. Insert ข้อมูลที่ถูกต้อง
        if (validRows.length > 0) {
            await db.query(`REPLACE INTO trn_budget_allocation 
                (fiscal_year, month_count, hoscode, sub_activity_id, visit_count, allocated_budget, batch_id, is_valid, updated_by) 
                VALUES ?`, [validRows]);
        }

        // 4. บันทึก Log การนำเข้าพร้อมรายการ Error
        await logAction('INSERT', 'trn_budget_allocation', batch_id, null, {
            status: 'upload_chunk_nhso_budget',
            success: validRows.length,
            errors: errorRows,
            sample: validRows.slice(0, 2)
        }, userId);

        res.status(200).json({ successCount: validRows.length, errorCount: errorRows.length, errors: errorRows });
    } catch (error) {
        console.error('NHSO Upload Error:', error);
        res.status(500).json({ error: error.message });
    }
};

const finalizeNhso = async (req, res) => {
    const connection = await db.getConnection();
    try {
        const { batch_id } = req.body;
        const userId = req.user.id;
        await connection.beginTransaction();

        const [newInfo] = await connection.query(`SELECT COUNT(*) as row_count, fiscal_year FROM trn_budget_allocation WHERE batch_id = ? GROUP BY fiscal_year`, [batch_id]);

        if (newInfo.length > 0) {
            const years = newInfo.map(n => n.fiscal_year);
            const [oldInfo] = await connection.query(`SELECT batch_id, COUNT(*) as row_count, fiscal_year FROM trn_budget_allocation WHERE is_valid = 1 AND fiscal_year IN (?) GROUP BY batch_id, fiscal_year`, [years]);

            await connection.query(`UPDATE trn_budget_allocation SET is_valid = 0 WHERE fiscal_year IN (?)`, [years]);
            await connection.query(`UPDATE trn_budget_allocation SET is_valid = 1 WHERE batch_id = ?`, [batch_id]);

            await logAction('UPDATE', 'trn_budget_allocation', batch_id, 
                { desc: 'ข้อมูลจัดสรรงบเดิมที่ถูกปลด', data: oldInfo }, 
                { desc: 'ข้อมูลจัดสรรงบใหม่ที่ใช้งาน', data: newInfo }, 
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
        console.error('Finalize NHSO Error:', error);
        res.status(500).json({ error: error.message });
    } finally {
        connection.release();
    }
};

module.exports = { 
    uploadHdcTarget, 
    uploadHdcResult, 
    finalizeHdc,
    uploadNhso,
    finalizeNhso
};