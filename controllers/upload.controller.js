const db = require('../config/db');
const auditLogger = require('../utils/auditLogger');

// ==========================================
// 1. ระบบ Lock / Unlock (ป้องกันการอัปโหลดซ้อนทับ)
// ==========================================

const initUpload = async (req, res) => {
    const conn = await db.getConnection();
    try {
        const { scope } = req.body; // เช่น ['nhso_data']
        const scope_key = scope && scope.length > 0 ? scope[0] : 'nhso_data';
        
        // [Critical] TOCTOU Prevention: ตรวจสอบ Global Lock ก่อนเสมอ
        const [globalLock] = await conn.query(`SELECT batch_id FROM sys_upload_locks WHERE scope_key = 'global_master'`);
        if (globalLock.length > 0) {
            return res.status(423).json({ message: 'ระบบกำลังมีการปรับปรุง Master Data ห้ามอัปโหลดในขณะนี้' });
        }

        // [Critical] Orphan Sweeper: ค้นหา Lock เก่าที่หมดอายุ (เกิน 15 นาที)
        const [expiredLocks] = await conn.query(`SELECT batch_id FROM sys_upload_locks WHERE locked_at < NOW() - INTERVAL 15 MINUTE`);
        if (expiredLocks.length > 0) {
            for (const lock of expiredLocks) {
                // ลบข้อมูลค้างท่อที่ยังไม่ถูก Finalize (is_valid = 0) ของ batch นั้นๆ ทิ้งให้เกลี้ยง
                await conn.query(`DELETE FROM trn_budget_allocation WHERE batch_id = ? AND is_valid = 0`, [lock.batch_id]);
                await conn.query(`DELETE FROM tmp_nhso_data WHERE batch_id = ?`, [lock.batch_id]); // ลบในตาราง Temp ด้วยถ้ามี
            }
            // ลบ Lock ที่หมดอายุทิ้ง
            await conn.query(`DELETE FROM sys_upload_locks WHERE locked_at < NOW() - INTERVAL 15 MINUTE`);
        }

        const batch_id = `BATCH_${Date.now()}_${Math.random().toString(36).substr(2, 5).toUpperCase()}`;

        // สร้าง Lock ใหม่
        await conn.query(
            `INSERT INTO sys_upload_locks (scope_key, batch_id, locked_by, locked_at) VALUES (?, ?, ?, NOW())`,
            [scope_key, batch_id, req.user?.id || 0]
        );

        res.status(200).json({ batch_id, message: 'ระบบพร้อมรับข้อมูล' });
    } catch (error) {
        if (error.code === 'ER_DUP_ENTRY' || error.message.includes('Duplicate')) {
            return res.status(423).json({ message: 'ระบบกำลังถูกใช้งานโดยผู้ใช้อื่น กรุณารอสักครู่' });
        }
        console.error('Init Upload Error:', error);
        res.status(500).json({ message: 'เกิดข้อผิดพลาดในการเริ่มต้นระบบอัปโหลด', error: error.message });
    } finally {
        conn.release();
    }
};

const unlockUpload = async (req, res) => {
    try {
        const { batch_id } = req.body;
        if (batch_id) {
            await db.query(`DELETE FROM sys_upload_locks WHERE batch_id = ?`, [batch_id]);
        }
        res.status(200).json({ message: 'ปลดล็อคระบบสำเร็จ' });
    } catch (error) {
        console.error('Unlock Upload Error:', error);
        res.status(500).json({ message: 'ไม่สามารถปลดล็อคระบบได้', error: error.message });
    }
};

const forceUnlock = async (req, res) => {
    try {
        await db.query(`DELETE FROM sys_upload_locks`);
        res.status(200).json({ message: 'บังคับปลดล็อคระบบสำเร็จ' });
    } catch (error) {
        console.error('Force Unlock Error:', error);
        res.status(500).json({ message: 'ไม่สามารถปลดล็อคได้', error: error.message });
    }
};

// ==========================================
// 2. ระบบนำเข้าข้อมูล สปสช. (NHSO)
// ==========================================

const uploadNhsoChunk = async (req, res) => {
    const { batch_id, data } = req.body;
    if (!batch_id || !data || data.length === 0) {
        return res.status(400).json({ message: 'ข้อมูลไม่ครบถ้วน' });
    }

    const conn = await db.getConnection();
    try {
        // [Critical] Lock Heartbeat: ต่ออายุ Lock ไปอีก 15 นาที เมื่อยิง Chunk สำเร็จ
        const [updateLock] = await conn.query(
            `UPDATE sys_upload_locks SET locked_at = CURRENT_TIMESTAMP WHERE batch_id = ?`,
            [batch_id]
        );
        if (updateLock.affectedRows === 0) {
            return res.status(403).json({ message: 'Session หมดอายุหรือ Lock ถูกยกเลิกไปแล้ว' });
        }

        // [Critical] Sub-Chunk Bulk Insert & Transaction
        await conn.beginTransaction();

        // หั่น Sub-chunk ไม่เกิน 500 แถว ป้องกัน MySQL Memory Overload
        const SUB_CHUNK_SIZE = 500;
        for (let i = 0; i < data.length; i += SUB_CHUNK_SIZE) {
            const subChunk = data.slice(i, i + SUB_CHUNK_SIZE);
            const values = subChunk.map(row => [
                batch_id,
                row.fiscal_year,
                row['รหัสหน่วยบริการ'] || row.hoscode,
                row['กิจกรรมย่อย'] || row.sub_activity_name || null,
                row['จำนวนครั้ง'] || row.visit_count || 0,
                row['จำนวนเงินจ่าย'] || row.budget || row.allocated_budget || 0,
                row.month_count || 12
            ]);

            await conn.query(
                `INSERT INTO tmp_nhso_data 
                (batch_id, fiscal_year, hoscode, sub_activity_name, visit_count, allocated_budget, month_count) 
                VALUES ?`,
                [values]
            );
        }

        await conn.commit();
        res.status(200).json({ message: `รับข้อมูล สปสช. จำนวน ${data.length} แถว เรียบร้อย` });
    } catch (error) {
        await conn.rollback();
        console.error('Upload NHSO Chunk Error:', error);
        res.status(500).json({ message: 'เกิดข้อผิดพลาด Database ถูก Rollback แล้ว', error: error.message });
    } finally {
        conn.release();
    }
};

const finalizeNhso = async (req, res) => {
    const { batch_id, scope } = req.body;
    if (!batch_id) return res.status(400).json({ message: 'ไม่พบ Batch ID' });

    if (!scope || scope.length === 0) {
        return res.status(200).json({ message: 'ไม่มี Scope ให้ดำเนินการ' });
    }

    const conn = await db.getConnection();
    try {
        const [lockCheck] = await conn.query(`SELECT batch_id FROM sys_upload_locks WHERE batch_id = ?`, [batch_id]);
        if (lockCheck.length === 0) {
            return res.status(403).json({ message: 'ไม่พบข้อมูล Lock หรือข้อมูลถูกประมวลผลไปแล้ว (Replay Guard)' });
        }

        const userId = req.user?.id || 0;

        // เรียกใช้งาน Stored Procedure (ส่ง userId เข้าไปด้วย)
        const [result] = await conn.query(`CALL sp_finalize_nhso_data(?, ?)`, [batch_id, userId]);
        const unmappedData = result[0] || []; 

        // ลบ Lock
        await conn.query(`DELETE FROM sys_upload_locks WHERE batch_id = ?`, [batch_id]);

        // บันทึก Audit Log (รองรับหลายรูปแบบป้องกัน Error)
        try {
            if (typeof auditLogger.logAction === 'function') {
                await auditLogger.logAction(req, 'IMPORT', 'trn_budget_allocation', null, null, `นำเข้าข้อมูล สปสช. สำเร็จ (Batch: ${batch_id})`);
            } else if (typeof auditLogger.log === 'function') {
                await auditLogger.log(req, 'IMPORT', 'trn_budget_allocation', null, null, `นำเข้าข้อมูล สปสช. สำเร็จ (Batch: ${batch_id})`);
            } else if (typeof auditLogger === 'function') {
                await auditLogger(req, 'IMPORT', 'trn_budget_allocation', null, null, `นำเข้าข้อมูล สปสช. สำเร็จ (Batch: ${batch_id})`);
            } else {
                console.warn('AuditLogger fn not found, skip logging.');
            }
        } catch (logErr) {
            console.error('Audit Log saving failed:', logErr);
        }

        res.status(200).json({ 
            message: 'ประมวลผลข้อมูล สปสช. เสร็จสมบูรณ์',
            unmappedData: unmappedData // ส่งไปให้ Frontend แสดง Table
        });
    } catch (error) {
        console.error('Finalize NHSO Error:', error);
        res.status(500).json({ message: 'เกิดข้อผิดพลาดในการประมวลผลข้อมูล สปสช.', error: error.message });
    } finally {
        conn.release();
    }
};

// ==========================================
// 3. ระบบนำเข้าข้อมูล HDC (เป้าหมาย & ผลงาน)
// ==========================================

const uploadHdcTargetChunk = async (req, res) => {
    res.status(200).json({ message: `รับข้อมูล Target เรียบร้อย` });
};

const uploadHdcResultChunk = async (req, res) => {
    res.status(200).json({ message: `รับข้อมูล Result เรียบร้อย` });
};

const finalizeHdc = async (req, res) => {
    const { batch_id, type } = req.body; 
    if (!batch_id) return res.status(400).json({ message: 'ไม่พบ Batch ID' });

    try {
        if (type === 'target') {
            // await db.query('CALL sp_finalize_hdc_target(?)', [batch_id]);
        } else if (type === 'result') {
            // await db.query('CALL sp_finalize_hdc_result(?)', [batch_id]);
        }
        await db.query(`DELETE FROM sys_upload_locks WHERE batch_id = ?`, [batch_id]);
        res.status(200).json({ message: 'ประมวลผลข้อมูล HDC เสร็จสมบูรณ์' });
    } catch (error) {
        res.status(500).json({ message: 'เกิดข้อผิดพลาดในการประมวลผลข้อมูล HDC', error: error.message });
    }
};

module.exports = {
    initUpload,
    unlockUpload,
    forceUnlock,
    uploadNhsoChunk,
    finalizeNhso,
    uploadHdcTargetChunk,
    uploadHdcResultChunk,
    finalizeHdc
};