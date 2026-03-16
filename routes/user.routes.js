const express = require('express');
const router = express.Router();
const { verifyToken } = require('../middlewares/auth.middleware');
const { getUsers, changePassword, resetPassword, deleteUser, createUser, checkUsername } = require('../controllers/user.controller');

router.get('/', verifyToken, getUsers);
router.put('/change-password', verifyToken, changePassword);
router.put('/:id/reset-password', verifyToken, resetPassword);
router.delete('/:id', verifyToken, deleteUser);
router.post('/', verifyToken, createUser);

// [เพิ่ม] Route สำหรับตรวจสอบ Username ซ้ำ
router.post('/check-username', verifyToken, checkUsername);

module.exports = router;