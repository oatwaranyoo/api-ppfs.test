const express = require('express');
const router = express.Router();
const { 
    initUpload,
    uploadNhsoChunk, 
    finalizeNhso,
    unlockUpload,
    // HDC คงไว้เหมือนเดิมก่อน
    uploadHdcTarget, 
    uploadHdcResult, 
    finalizeHdc
} = require('../controllers/upload.controller');
const { verifyToken } = require('../middlewares/auth.middleware');

// ==========================================
// [SRS] ระบบ Upload แบบ Batch & Chunking
// ==========================================
router.post('/init', verifyToken, initUpload); // ขอ Batch ID และ Lock ระบบ
router.post('/unlock', verifyToken, unlockUpload); // ปลด Lock กรณีเกิด Error หรือผู้ใช้ปิดแท็บ

// NHSO (สปสช.) Routes
router.post('/nhso-chunk', verifyToken, uploadNhsoChunk); // ส่งข้อมูลทีละ Chunk
router.post('/finalize', verifyToken, finalizeNhso); // สลับข้อมูล Zero-Downtime และปลด Lock

// HDC Routes (รออัปเกรดใน Phase ถัดไป)
router.post('/hdc-target', verifyToken, uploadHdcTarget);
router.post('/hdc-result', verifyToken, uploadHdcResult);
router.post('/hdc-finalize', verifyToken, finalizeHdc);

module.exports = router;