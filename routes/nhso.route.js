const express = require('express');
const router = express.Router();
const { verifyToken } = require('../middlewares/auth.middleware');
const { getNhsoData } = require('../controllers/nhso.controller');

// ต้องล็อคอินก่อนถึงจะดึงข้อมูลได้
router.get('/data', verifyToken, getNhsoData);

module.exports = router;