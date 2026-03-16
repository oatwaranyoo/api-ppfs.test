const express = require('express');
const router = express.Router();
const { getNhsoData } = require('../controllers/nhso.controller');
const { verifyToken } = require('../middlewares/auth.middleware');

// GET /api/nhso
router.get('/', verifyToken, getNhsoData);

module.exports = router;