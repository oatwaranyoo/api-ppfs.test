const express = require('express');
const router = express.Router();
const { getNhsoData } = require('../controllers/nhso.controller');
const { verifyToken } = require('../middlewares/auth.middleware');

// GET /api/nhso -> ดึงข้อมูล สปสช. (ต้อง Login ก่อน)
router.get('/', verifyToken, getNhsoData);

module.exports = router;