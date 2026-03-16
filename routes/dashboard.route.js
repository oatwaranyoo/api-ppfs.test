const express = require('express');
const router = express.Router();
const { getSummary } = require('../controllers/dashboard.controller');
const { verifyToken } = require('../middlewares/auth.middleware'); // นำเข้า middleware ตรวจสอบ Token ของคุณ

// GET /api/dashboard/summary
router.get('/summary', verifyToken, getSummary);

module.exports = router;