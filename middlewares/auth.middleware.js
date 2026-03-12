const jwt = require('jsonwebtoken');
require('dotenv').config();

const verifyToken = (req, res, next) => {
    // รับ Token จาก Header (รูปแบบ: Bearer <token>)
    const authHeader = req.headers.authorization;
    if (!authHeader || !authHeader.startsWith('Bearer ')) {
        return res.status(401).json({ error: 'Access denied. No token provided.' });
    }

    const token = authHeader.split(' ')[1];

    try {
        // ถอดรหัส Token
        const decoded = jwt.verify(token, process.env.JWT_SECRET);
        req.user = decoded; // แนบข้อมูล User (เช่น id, role) ไปกับ request
        next(); // ให้ไปทำงานใน Route ถัดไป
    } catch (error) {
        return res.status(403).json({ error: 'Invalid or expired token.' });
    }
};

module.exports = { verifyToken };