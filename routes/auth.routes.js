const express = require('express');
const router = express.Router();
const { login } = require('../controllers/auth.controller');

/**
 * @swagger
 * tags:
 * name: Auth
 * description: Authentication API
 */

/**
 * @swagger
 * /api/auth/login:
 * post:
 * summary: Login to the system
 * tags: [Auth]
 * requestBody:
 * required: true
 * content:
 * application/json:
 * schema:
 * type: object
 * required:
 * - username
 * - password
 * properties:
 * username:
 * type: string
 * example: admin
 * password:
 * type: string
 * example: 123456
 * responses:
 * 200:
 * description: Login successful
 * 400:
 * description: Missing credentials
 * 401:
 * description: Invalid credentials
 * 500:
 * description: Server error
 */
router.post('/login', login);

module.exports = router;