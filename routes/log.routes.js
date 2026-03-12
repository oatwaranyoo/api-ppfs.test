const express = require('express');
const router = express.Router();
const { getAuditLogs } = require('../controllers/log.controller');
const { verifyToken } = require('../middlewares/auth.middleware');

// สังเกตว่าใช้ / ไม่ใช่ /logs เพราะเราจะไปกำหนด prefix ที่ server.js
router.get('/', verifyToken, getAuditLogs);

module.exports = router;