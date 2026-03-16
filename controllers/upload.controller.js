const db = require('../config/db');
const { logAction } = require('../utils/auditLogger');
const { v4: uuidv4 } = require('uuid'); // อย่าลืม npm install uuid หากยังไม่มี

// ==========================================
// [SRS Critical] 1. ระบบจัดการ Lock และ Batch
// ==========================================

// ฟังก์ชันเคลียร์ข้อมูลขยะ (Orphan Sweeper) หากมี Lock ค้างเกิน 30 นาที
const clearOrphanLocks = async () => {
    try {
        await db.query(`DELETE FROM sys_upload_locks WHERE locked_at < NOW() - INTERVAL 30 MINUTE`);
    } catch (err) {
        console.error("Orphan Sweeper Error:", err.message);
    }
};

const initUpload = async (req, res) => {
    try {
        const { scope } = req.body; // เช่น ['nhso_data']
        const userId = req.user.id;
        
        await clearOrphanLocks();

        const scopeKey = scope[0] || 'general_upload';

        // เช็คว่ามีคนล็อกอยู่หรือไม่
        const [existingLock] = await db.query(`SELECT * FROM sys_upload_locks WHERE scope_key = ?`, [scopeKey]);
        if (existingLock.length > 0) {
            return res.status(423).json({ message: "ระบบกำลังถูกใช้งานโดยผู้ใช้อื่น กรุณารอสักครู่" });
        }

        // สร้าง Batch ID ใหม่จากฝั่ง Server
        const batchId = uuidv4();

        // สร้าง Lock
        await db.query(`INSERT INTO sys_upload_locks (scope_key, batch_id, locked_by) VALUES (?, ?, ?)`, [scopeKey, batchId, userId]);

        res.status(200).json({ status: 'success', batch_id: batchId });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};

const unlockUpload = async (req, res) => {
    try {
        const { batch_id } = req.body;
        // กรณีปลดล็อกผ่าน Beacon API อาจจะไม่มี Token ส่งมาครบ 
        // เราจึงอ้างอิงจาก batch_id เป็นหลักในการปลดล็อก
        if (batch_id) {
            await db.query(`DELETE FROM sys_upload_locks WHERE batch_id = ?`, [batch_id]);
            // ลบข้อมูลขยะที่อัปโหลดค้างไว้ (is_valid = 0) ของ batch นี้
            await db.query(`DELETE FROM trn_budget_allocation WHERE batch_id = ? AND is_valid = 0`, [batch_id]);
        }
        res.status(200).json({ message: "Unlocked successfully" });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};


// ==========================================
// [SRS] 2. นำเข้าข้อมูล สปสช. (Chunking)
// ==========================================
const uploadNhsoChunk = async (req, res) => {
    try {
        const { data, batch_id, fiscal_year } = req.body;
        const userId = req.user.id;
        const validRows = [];
        const errorRows = [];

        // ตรวจสอบ Lock ป้องกันคนนอกยิง API แทรก
        const [lockCheck] = await db.query(`SELECT 1 FROM sys_upload_locks WHERE batch_id = ?`, [batch_id]);
        if (lockCheck.length === 0) {
             return res.status(403).json({ message: "หมดเวลาการอัปโหลด หรือเซสชันไม่ถูกต้อง กรุณาเริ่มใหม่" });
        }

        // โหลดตาราง Mapping
        let mapDict = {};
        const [mappings] = await db.query('SELECT fiscal_year, mapping_desc, sub_activity_id FROM map_nhso_activities');
        mappings.forEach(m => {
            if (m.fiscal_year && m.mapping_desc) {
                mapDict[`${m.fiscal_year}-${m.mapping_desc.trim()}`] = m.sub_activity_id;
            }
        });

        // ลูปประมวลผล Chunk
        data.forEach((row, index) => {
            const fYear = row.fiscal_year || row['ปีงบ'] || row['ปีงบประมาณ'] || fiscal_year;
            const hCode = String(row.hoscode || row['รหัสหน่วยบริการ'] || '').padStart(5, '0');
            
            let subActId = row.sub_activity_id || row['รหัสกิจกรรมย่อย'];
            const nhsoActivityName = row['กิจกรรมย่อย'];

            if (!subActId && nhsoActivityName) {
                subActId = mapDict[`${fYear}-${String(nhsoActivityName).trim()}`];
            }

            const monthCount = parseInt(row.month_count || row['จำนวนเดือน']) || 12;
            const visitCount = parseInt(row.visit_count || row['จำนวนครั้ง']) || 0;
            const allocatedBudget = parseFloat(row.allocated_budget || row['จำนวนเงินจ่าย'] || row['จำนวนเงินจัดสรร'] || row['งบประมาณจัดสรร']) || 0;

            if (!subActId) {
                errorRows.push({ row_index: index + 1, data: row, reason: `ไม่มีการจับคู่ (Mapping) ของกิจกรรม: "${nhsoActivityName}" สำหรับปี ${fYear}` });
            } else {
                const activityYear = String(subActId).substring(0, 4);
                if (activityYear !== String(fYear)) {
                    errorRows.push({ row_index: index + 1, data: row, reason: `รหัสกิจกรรมที่ได้ (${subActId}) ไม่ตรงกับปีงบประมาณ (${fYear})` });
                } else {
                    // ส่งเข้าตารางรอ (is_valid = 0)
                    validRows.push([ fYear, monthCount, hCode, subActId, visitCount, allocatedBudget, batch_id, 0, userId ]);
                }
            }
        });

        if (validRows.length > 0) {
            await db.query(`REPLACE INTO trn_budget_allocation (fiscal_year, month_count, hoscode, sub_activity_id, visit_count, allocated_budget, batch_id, is_valid, updated_by) VALUES ?`, [validRows]);
        }

        res.status(200).json({ successCount: validRows.length, errorCount: errorRows.length, errors: errorRows });
    } catch (error) {
        console.error('Chunk Upload Error:', error);
        res.status(500).json({ error: error.message });
    }
};

const finalizeNhso = async (req, res) => {
    const connection = await db.getConnection();
    try {
        const { batch_id, scope } = req.body;
        const userId = req.user.id;
        await connection.beginTransaction();

        // นับจำนวนบรรทัดใหม่ที่เพิ่งส่งเข้ามา
        const [newInfo] = await connection.query(`SELECT COUNT(*) as row_count, fiscal_year FROM trn_budget_allocation WHERE batch_id = ? GROUP BY fiscal_year`, [batch_id]);

        if (newInfo.length > 0) {
            const years = newInfo.map(n => n.fiscal_year);
            
            // ดึงสรุปข้อมูลเก่าเพื่อลง Log
            const [oldInfo] = await connection.query(`SELECT batch_id, COUNT(*) as row_count, fiscal_year FROM trn_budget_allocation WHERE is_valid = 1 AND fiscal_year IN (?) GROUP BY batch_id, fiscal_year`, [years]);

            // [SRS Critical] Zero-Downtime Swap
            await connection.query(`UPDATE trn_budget_allocation SET is_valid = 0 WHERE fiscal_year IN (?)`, [years]);
            await connection.query(`UPDATE trn_budget_allocation SET is_valid = 1 WHERE batch_id = ?`, [batch_id]);

            await logAction('UPDATE', 'trn_budget_allocation', batch_id, 
                { desc: 'ข้อมูลจัดสรรงบเดิมที่ถูกปลด', data: oldInfo }, 
                { desc: 'ข้อมูลจัดสรรงบใหม่ที่ใช้งาน', data: newInfo }, 
                userId
            );

            // ปลด Lock หลังจากจบกระบวนการ
            const scopeKey = (scope && scope[0]) ? scope[0] : 'nhso_data';
            await connection.query(`DELETE FROM sys_upload_locks WHERE scope_key = ?`, [scopeKey]);

            await connection.commit();
            res.status(200).json({ message: 'Success', updated_years: years });
        } else {
            await connection.rollback();
            res.status(404).json({ error: 'ไม่พบข้อมูลใน Batch นี้ หรือข้อมูลไม่ถูกต้องทั้งหมด' });
        }
    } catch (error) {
        await connection.rollback();
        console.error('Finalize Error:', error);
        res.status(500).json({ error: error.message });
    } finally {
        connection.release();
    }
};

// ==========================================
// ส่วนประกอบเดิมของ HDC
// ==========================================
const uploadHdcTarget = async (req, res) => { /* โค้ดเดิม... */ };
const uploadHdcResult = async (req, res) => { /* โค้ดเดิม... */ };
const finalizeHdc = async (req, res) => { /* โค้ดเดิม... */ };

module.exports = { 
    initUpload,
    unlockUpload,
    uploadNhsoChunk,
    finalizeNhso,
    uploadHdcTarget, 
    uploadHdcResult, 
    finalizeHdc
};