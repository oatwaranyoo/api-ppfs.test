const jwt = require('jsonwebtoken');
const crypto = require('crypto');
require('dotenv').config();

const verifyToken = (req, res, next) => {
    // [SRS] JWT Secret Integrity
    if (!process.env.JWT_SECRET || process.env.JWT_SECRET.length < 32) {
        return res.status(500).json({ error: 'Server Configuration Error (JWT Secret invalid)' });
    }

    const authHeader = req.headers.authorization;
    if (!authHeader || !authHeader.startsWith('Bearer ')) {
        return res.status(401).json({ error: 'Access denied. No token provided.' });
    }

    const token = authHeader.split(' ')[1];

    try {
        const decoded = jwt.verify(token, process.env.JWT_SECRET);
        
        // [SRS] Dynamic Fingerprinting (เช็ค User-Agent Hash)
        const currentUserAgent = req.headers['user-agent'] || '';
        const userAgentHash = crypto.createHash('sha256').update(currentUserAgent).digest('hex');
        
        if (decoded.ua_hash && decoded.ua_hash !== userAgentHash) {
             return res.status(403).json({ error: 'Invalid token fingerprinting. (User-Agent changed)' });
        }

        req.user = decoded; 
        next(); 
    } catch (error) {
        if (error.name === 'TokenExpiredError') {
            return res.status(403).json({ error: 'Token expired.' });
        }
        return res.status(403).json({ error: 'Invalid token.' });
    }
};

module.exports = { verifyToken };