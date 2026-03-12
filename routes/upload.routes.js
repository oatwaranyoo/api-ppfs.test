const express = require('express');
const router = express.Router();
const { 
    uploadHdcTarget, 
    uploadHdcResult, 
    finalizeHdc, 
    uploadNhso, 
    finalizeNhso 
} = require('../controllers/upload.controller');
const { verifyToken } = require('../middlewares/auth.middleware');

// HDC Routes
router.post('/hdc-target', verifyToken, uploadHdcTarget);
router.post('/hdc-result', verifyToken, uploadHdcResult);
router.post('/hdc-finalize', verifyToken, finalizeHdc);

// NHSO (Budget Allocation) Routes
router.post('/nhso', verifyToken, uploadNhso);
router.post('/nhso-finalize', verifyToken, finalizeNhso);

module.exports = router;