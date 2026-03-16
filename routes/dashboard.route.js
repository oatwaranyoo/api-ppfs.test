const express = require('express');
const router = express.Router();
const { getSummary } = require('../controllers/dashboard.controller');
// ไม่ต้องใช้ verifyToken แล้วสำหรับหน้านี้
// const { verifyToken } = require('../middlewares/auth.middleware'); 

// GET /api/dashboard/summary
// ลบ verifyToken ออกเพื่อให้เข้าถึงข้อมูลสรุปได้โดยไม่ต้อง Login
router.get('/summary', getSummary);

module.exports = router;