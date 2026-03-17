const express = require('express');
const router = express.Router();

// นำเข้า Middleware สำหรับเช็คสิทธิ์การเข้าถึง
const { verifyToken } = require('../middlewares/auth.middleware');

// นำเข้าฟังก์ชันทั้งหมดจาก Controller
const { 
    initUpload, 
    unlockUpload, 
    forceUnlock,
    uploadNhsoChunk, 
    finalizeNhso, 
    uploadHdcTargetChunk,
    uploadHdcResultChunk,
    finalizeHdc
} = require('../controllers/upload.controller');

// ==========================================
// Routes สำหรับการล็อค/ปลดล็อคระบบ
// ==========================================
router.post('/init', verifyToken, initUpload);
router.post('/unlock', unlockUpload); 
router.post('/force-unlock', verifyToken, forceUnlock);
// ==========================================
// Routes สำหรับรับข้อมูล สปสช. (NHSO)
// ==========================================
router.post('/nhso-chunk', verifyToken, uploadNhsoChunk);
router.post('/finalize-nhso', verifyToken, finalizeNhso);

// ==========================================
// Routes สำหรับรับข้อมูล HDC
// ==========================================
router.post('/hdc-target-chunk', verifyToken, uploadHdcTargetChunk);
router.post('/hdc-result-chunk', verifyToken, uploadHdcResultChunk);
router.post('/finalize-hdc', verifyToken, finalizeHdc);

module.exports = router;