const express = require('express');
const router = express.Router();
const { verifyToken } = require('../middlewares/auth.middleware');
const { getDepartments } = require('../controllers/department.controller');

// ต้องเข้าสู่ระบบก่อนถึงจะดึงได้
router.get('/', verifyToken, getDepartments);

module.exports = router;