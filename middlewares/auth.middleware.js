const jwt = require('jsonwebtoken');
const crypto = require('crypto');
require('dotenv').config();

const verifyToken = (req, res, next) => {
    // [SRS] JWT Secret Integrity
    if (!process.env.JWT_SECRET || process.env.JWT_SECRET.length < 32) {
        return res.status(500).json({ message: 'Server Configuration Error (JWT Secret invalid)' });
    }

    const authHeader = req.headers.authorization;
    if (!authHeader || !authHeader.startsWith('Bearer ')) {
        return res.status(401).json({ message: 'Access denied. No token payload provided.' });
    }

    // 1. ดึง Header.Payload มาจาก Authorization Header
    const payloadPart = authHeader.split(' ')[1]; 
    
    // 2. ดึง Signature มาจาก HttpOnly Cookie ที่ชื่อ token_signature
    const signaturePart = req.cookies.token_signature; 

    if (!signaturePart) {
        return res.status(401).json({ message: 'Access denied. Token signature missing.' });
    }

    // 3. [SRS Critical] ประกอบร่าง Token คืนสภาพเดิม (Header.Payload.Signature)
    const token = `${payloadPart}.${signaturePart}`;

    try {
        const decoded = jwt.verify(token, process.env.JWT_SECRET);
        
        // [SRS] Dynamic Fingerprinting (เช็ค User-Agent Hash) ป้องกันการขโมย Token ข้ามเครื่อง
        const currentUserAgent = req.headers['user-agent'] || 'unknown-device';
        const userAgentHash = crypto.createHash('sha256').update(currentUserAgent).digest('hex');
        
        if (decoded.ua_hash && decoded.ua_hash !== userAgentHash) {
             return res.status(403).json({ message: 'เซสชันไม่ปลอดภัย (ตรวจพบการเปลี่ยนอุปกรณ์/เบราว์เซอร์)' });
        }

        req.user = decoded; 
        next(); 
    } catch (error) {
        if (error.name === 'TokenExpiredError') {
            return res.status(403).json({ message: 'เซสชันหมดอายุ กรุณาเข้าสู่ระบบใหม่' });
        }
        return res.status(403).json({ message: 'Token ไม่ถูกต้อง หรือถูกแก้ไข' });
    }
};

module.exports = { verifyToken };