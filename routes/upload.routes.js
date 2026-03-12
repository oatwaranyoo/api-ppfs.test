const express = require('express');
const router = express.Router();
const { uploadHdcTarget, uploadHdcResult, finalizeHdc } = require('../controllers/upload.controller');
const { verifyToken } = require('../middlewares/auth.middleware');

router.post('/hdc-target', verifyToken, uploadHdcTarget);
router.post('/hdc-result', verifyToken, uploadHdcResult);
router.post('/hdc-finalize', verifyToken, finalizeHdc);

module.exports = router;