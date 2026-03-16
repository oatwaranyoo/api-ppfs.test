const db = require('../config/db');

// ==========================================
// 1. ระบบ Lock / Unlock (ป้องกันการอัปโหลดซ้อนทับ)
// ==========================================

const initUpload = async (req, res) => {
    try {
        const { scope } = req.body; // เช่น ['nhso_data'] หรือ ['hdc_target_data']
        const batch_id = `BATCH_${Date.now()}_${Math.random().toString(36).substr(2, 5).toUpperCase()}`;

        // บันทึกสถานะการล็อคลงฐานข้อมูล
        await db.query(
            `INSERT INTO sys_upload_locks (batch_id, locked_by, scope, created_at) VALUES (?, ?, ?, NOW())`,
            [batch_id, req.user.id, JSON.stringify(scope)]
        );

        res.status(200).json({ batch_id, message: 'ระบบพร้อมรับข้อมูล' });
    } catch (error) {
        if (error.code === 'ER_DUP_ENTRY' || error.message.includes('Duplicate')) {
            return res.status(423).json({ message: 'ระบบกำลังถูกใช้งานโดยผู้ใช้อื่น กรุณารอสักครู่' });
        }
        console.error('Init Upload Error:', error);
        res.status(500).json({ message: 'เกิดข้อผิดพลาดในการเริ่มต้นระบบอัปโหลด', error: error.message });
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
        // ล้างการล็อคทั้งหมดในระบบ (กรณีระบบค้าง)
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
    try {
        const { batch_id, data } = req.body;
        if (!batch_id || !data || data.length === 0) {
            return res.status(400).json({ message: 'ข้อมูลไม่ครบถ้วน' });
        }

        // จัดเตรียมข้อมูลเพื่อ Insert ลงตาราง Temp ของ สปสช.
        const values = data.map(row => [
            batch_id,
            row.fiscal_year,
            row['รหัสหน่วยบริการ'] || row.hoscode,
            row['กิจกรรมย่อย'] || row.sub_activity_name || null,
            row['จำนวนครั้ง'] || row.visit_count || 0,
            row['จำนวนเงินจ่าย'] || row.budget || row.allocated_budget || 0,
            row.month_count || 12
        ]);

        await db.query(
            `INSERT INTO tmp_nhso_data 
            (batch_id, fiscal_year, hoscode, sub_activity_name, visit_count, allocated_budget, month_count) 
            VALUES ?`,
            [values]
        );

        res.status(200).json({ message: `รับข้อมูล สปสช. จำนวน ${data.length} แถว เรียบร้อย` });
    } catch (error) {
        console.error('Upload NHSO Chunk Error:', error);
        res.status(500).json({ message: 'เกิดข้อผิดพลาดในการรับข้อมูล สปสช.', error: error.message });
    }
};

const finalizeNhso = async (req, res) => {
    try {
        const { batch_id } = req.body;
        if (!batch_id) return res.status(400).json({ message: 'ไม่พบ Batch ID' });

        // เรียกใช้งาน Stored Procedure เพื่อย้ายข้อมูลจาก Temp ไปตารางจริง
        await db.query(`CALL sp_finalize_nhso_data(?)`, [batch_id]);
        
        // ลบ Lock ออกเมื่อทำงานเสร็จสมบูรณ์
        await db.query(`DELETE FROM sys_upload_locks WHERE batch_id = ?`, [batch_id]);

        res.status(200).json({ message: 'ประมวลผลข้อมูล สปสช. เสร็จสมบูรณ์' });
    } catch (error) {
        console.error('Finalize NHSO Error:', error);
        res.status(500).json({ message: 'เกิดข้อผิดพลาดในการประมวลผลข้อมูล สปสช.', error: error.message });
    }
};

// ==========================================
// 3. ระบบนำเข้าข้อมูล HDC (เป้าหมาย & ผลงาน)
// ==========================================

const uploadHdcTargetChunk = async (req, res) => {
    try {
        const { batch_id, data } = req.body;
        if (!batch_id || !data || data.length === 0) {
            return res.status(400).json({ message: 'ข้อมูลไม่ครบถ้วน' });
        }

        // ตัวอย่างโครงสร้างการ Insert ข้อมูลเป้าหมาย (Target)
        const values = data.map(row => [
            batch_id,
            row['ปีงบ'] || row['fiscal_year'] || null,
            row['รหัสพยาบาล'] || row['hcode'] || row['hoscode'] || null,
            JSON.stringify(row) // หาก Schema ยังไม่นิ่ง ให้เก็บเป็น JSON ชั่วคราวไปก่อน
        ]);

        /* เปิดใช้งานเมื่อสร้างตาราง tmp_hdc_target แล้ว
        await db.query(
            `INSERT INTO tmp_hdc_target (batch_id, fiscal_year, hoscode, raw_data) VALUES ?`,
            [values]
        );
        */

        res.status(200).json({ message: `รับข้อมูล Target จำนวน ${data.length} แถว เรียบร้อย` });
    } catch (error) {
        console.error('Upload HDC Target Chunk Error:', error);
        res.status(500).json({ message: 'เกิดข้อผิดพลาดในการรับข้อมูล HDC Target', error: error.message });
    }
};

const uploadHdcResultChunk = async (req, res) => {
    try {
        const { batch_id, data } = req.body;
        if (!batch_id || !data || data.length === 0) {
            return res.status(400).json({ message: 'ข้อมูลไม่ครบถ้วน' });
        }

        // ตัวอย่างโครงสร้างการ Insert ข้อมูลผลงาน (Result)
        const values = data.map(row => [
            batch_id,
            row['ปีงบ'] || row['fiscal_year'] || null,
            row['รหัสพยาบาล'] || row['hcode'] || row['hoscode'] || null,
            JSON.stringify(row)
        ]);

        /* เปิดใช้งานเมื่อสร้างตาราง tmp_hdc_result แล้ว
        await db.query(
            `INSERT INTO tmp_hdc_result (batch_id, fiscal_year, hoscode, raw_data) VALUES ?`,
            [values]
        );
        */

        res.status(200).json({ message: `รับข้อมูล Result จำนวน ${data.length} แถว เรียบร้อย` });
    } catch (error) {
        console.error('Upload HDC Result Chunk Error:', error);
        res.status(500).json({ message: 'เกิดข้อผิดพลาดในการรับข้อมูล HDC Result', error: error.message });
    }
};

const finalizeHdc = async (req, res) => {
    try {
        const { batch_id, type } = req.body; // type จะเป็น 'target' หรือ 'result'
        if (!batch_id) return res.status(400).json({ message: 'ไม่พบ Batch ID' });

        if (type === 'target') {
            // await db.query('CALL sp_finalize_hdc_target(?)', [batch_id]);
        } else if (type === 'result') {
            // await db.query('CALL sp_finalize_hdc_result(?)', [batch_id]);
        }

        // ลบ Lock ออกเมื่อทำงานเสร็จสมบูรณ์
        await db.query(`DELETE FROM sys_upload_locks WHERE batch_id = ?`, [batch_id]);

        res.status(200).json({ message: 'ประมวลผลข้อมูล HDC เสร็จสมบูรณ์' });
    } catch (error) {
        console.error('Finalize HDC Error:', error);
        res.status(500).json({ message: 'เกิดข้อผิดพลาดในการประมวลผลข้อมูล HDC', error: error.message });
    }
};

// ==========================================
// ส่งออกฟังก์ชันทั้งหมด
// ==========================================
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