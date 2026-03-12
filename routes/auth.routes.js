const express = require('express');
const router = express.Router();
const { login, logout } = require('../controllers/auth.controller');
const { verifyToken } = require('../middlewares/auth.middleware'); // ต้องมีตัวนี้

router.post('/login', login);

// ตอน Logout ต้องใส่ verifyToken คั่นไว้ เพื่อให้ controller อ่าน req.user ได้
router.post('/logout', verifyToken, logout); 

module.exports = router;