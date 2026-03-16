const db = require('../config/db');
const { logAction } = require('../utils/auditLogger');
const { v4: uuidv4 } = require('uuid');

// ==========================================
// [SRS Critical] 1. ระบบจัดการ Lock และ Batch
// ==========================================

const clearOrphanLocks = async () => {
    try {
        // [SRS] กลไก Orphan Sweeper 15 นาที และล้างข้อมูลค้างท่อ
        const [expiredLocks] = await db.query(`SELECT batch_id FROM sys_upload_locks WHERE locked_at < NOW() - INTERVAL 15 MINUTE`);
        if (expiredLocks.length > 0) {
            const batchIds = expiredLocks.map(l => l.batch_id);
            // ลบข้อมูลขยะของ batch ที่หลุดออกจากตาราง Transaction
            await db.query(`DELETE FROM trn_budget_allocation WHERE batch_id IN (?) AND is_valid = 0`, [batchIds]);
            await db.query(`DELETE FROM sys_upload_locks WHERE batch_id IN (?)`, [batchIds]);
        }
    } catch (err) {
        console.error("Orphan Sweeper Error:", err.message);
    }
};

const initUpload = async (req, res) => {
    try {
        const { scope } = req.body; 
        const userId = req.user.id;
        
        await clearOrphanLocks();

        const scopeKey = (scope && scope[0]) ? scope[0] : 'general_upload';

        // [SRS] TOCTOU Prevention: ตรวจสอบ global_master Lock ก่อน
        const [globalLock] = await db.query(`SELECT 1 FROM sys_upload_locks WHERE scope_key = 'global_master'`);
        if (globalLock.length > 0) {
             return res.status(423).json({ message: "ระบบกำลังอัปเดต Master Data กรุณารอสักครู่" });
        }

        const [existingLock] = await db.query(`SELECT * FROM sys_upload_locks WHERE scope_key = ?`, [scopeKey]);
        if (existingLock.length > 0) {
            return res.status(423).json({ message: "ระบบกำลังถูกใช้งานใน Scope นี้ กรุณารอสักครู่" });
        }

        const batchId = uuidv4();

        await db.query(`INSERT INTO sys_upload_locks (scope_key, batch_id, locked_by) VALUES (?, ?, ?)`, [scopeKey, batchId, userId]);

        res.status(200).json({ status: 'success', batch_id: batchId });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};

const unlockUpload = async (req, res) => {
    try {
        const { batch_id } = req.body;
        if (batch_id) {
            await db.query(`DELETE FROM sys_upload_locks WHERE batch_id = ?`, [batch_id]);
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

        // ตรวจสอบ Lock
        const [lockCheck] = await db.query(`SELECT 1 FROM sys_upload_locks WHERE batch_id = ?`, [batch_id]);
        if (lockCheck.length === 0) {
             return res.status(403).json({ message: "หมดเวลาการอัปโหลด หรือเซสชันไม่ถูกต้อง กรุณาเริ่มใหม่" });
        }

        // [SRS] Lock Heartbeat ต่ออายุ Lock
        await db.query(`UPDATE sys_upload_locks SET locked_at = CURRENT_TIMESTAMP WHERE batch_id = ?`, [batch_id]);

        let mapDict = {};
        const [mappings] = await db.query('SELECT fiscal_year, mapping_desc, sub_activity_id FROM map_nhso_activities');
        mappings.forEach(m => {
            if (m.fiscal_year && m.mapping_desc) {
                mapDict[`${m.fiscal_year}-${String(m.mapping_desc).trim().toLowerCase()}`] = m.sub_activity_id;
            }
        });

        data.forEach((row, index) => {
            const fYear = parseInt(row.fiscal_year || row['ปีงบ'] || row['ปีงบประมาณ'] || fiscal_year);
            const hCode = String(row.hoscode || row['รหัสหน่วยบริการ'] || '').trim().padStart(5, '0');
            
            let subActId = row.sub_activity_id || row['รหัสกิจกรรมย่อย'];
            const nhsoActivityName = row['กิจกรรมย่อย'];

            if (!subActId && nhsoActivityName) {
                subActId = mapDict[`${fYear}-${String(nhsoActivityName).trim().toLowerCase()}`];
            }

            const monthCount = parseInt(row.month_count || row['จำนวนเดือน']) || 12;
            const visitCount = parseInt(row.visit_count || row['จำนวนครั้ง']) || 0;
            const allocatedBudget = row.allocated_budget || row['จำนวนเงินจ่าย'] || row['จำนวนเงินจัดสรร'];
            // [SRS] IEEE 754 Float Safety: ไม่ Cast เป็น Float ใน Backend ให้เก็บเป็น String ก่อนลง DB
            const safeBudgetStr = String(allocatedBudget || 0).replace(/,/g, '');

            if (!subActId) {
                errorRows.push({ row_index: index + 1, data: row, reason: `ไม่มีการจับคู่ (Mapping) ของกิจกรรม: "${nhsoActivityName}" สำหรับปี ${fYear}` });
            } else {
                validRows.push([ fYear, monthCount, hCode, subActId, visitCount, safeBudgetStr, batch_id, 0, userId ]);
            }
        });

        if (validRows.length > 0) {
            // [SRS] MySQL UPSERT Force Update แทน REPLACE
            await db.query(`
                INSERT INTO trn_budget_allocation 
                (fiscal_year, month_count, hoscode, sub_activity_id, visit_count, allocated_budget, batch_id, is_valid, updated_by) 
                VALUES ? 
                ON DUPLICATE KEY UPDATE 
                month_count = VALUES(month_count),
                visit_count = VALUES(visit_count),
                allocated_budget = VALUES(allocated_budget),
                batch_id = VALUES(batch_id),
                is_valid = VALUES(is_valid),
                updated_by = VALUES(updated_by)
            `, [validRows]);
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

        // [SRS Replay Guard] ตรวจสอบว่า batch_id ยังอยู่ในระบบ
        const [lockCheck] = await connection.query(`SELECT 1 FROM sys_upload_locks WHERE batch_id = ?`, [batch_id]);
        if (lockCheck.length === 0) {
            await connection.rollback();
            return res.status(400).json({ error: 'ไม่พบเซสชันการอัปโหลดนี้ หรือถูก Finalize ไปแล้ว (Replay Guard)' });
        }

        const [newInfo] = await connection.query(`SELECT COUNT(*) as row_count, fiscal_year FROM trn_budget_allocation WHERE batch_id = ? GROUP BY fiscal_year`, [batch_id]);

        if (newInfo.length > 0) {
            const years = newInfo.map(n => n.fiscal_year);
            const [oldInfo] = await connection.query(`SELECT batch_id, COUNT(*) as row_count, fiscal_year FROM trn_budget_allocation WHERE is_valid = 1 AND fiscal_year IN (?) GROUP BY batch_id, fiscal_year`, [years]);

            // [SRS Critical] Zero-Downtime Swap & ลบของเก่าทิ้ง
            await connection.query(`UPDATE trn_budget_allocation SET is_valid = 1 WHERE batch_id = ?`, [batch_id]);
            
            // ลบข้อมูลปีงบที่ถูกเขียนทับ (ที่ไม่ใช่ batch ใหม่)
            if (years.length > 0) {
                await connection.query(`DELETE FROM trn_budget_allocation WHERE fiscal_year IN (?) AND batch_id != ?`, [years, batch_id]);
            }

            await logAction('UPDATE', 'trn_budget_allocation', batch_id, 
                { desc: 'ข้อมูลถูกลบ/ทับ', data: oldInfo }, 
                { desc: 'ข้อมูลใหม่ที่แสดงผล', data: newInfo }, 
                userId
            );

            // ปลด Lock
            await connection.query(`DELETE FROM sys_upload_locks WHERE batch_id = ?`, [batch_id]);

            await connection.commit();
            res.status(200).json({ message: 'Success', updated_years: years });
        } else {
            await connection.rollback();
            res.status(404).json({ error: 'ไม่พบข้อมูลใน Batch นี้ หรือข้อมูลว่างเปล่า' });
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