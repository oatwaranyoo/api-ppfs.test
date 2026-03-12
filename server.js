const express = require('express');
const cors = require('cors');
const helmet = require('helmet');
const cookieParser = require('cookie-parser');
const swaggerUi = require('swagger-ui-express');
const swaggerSpec = require('./swagger');
require('dotenv').config();

const app = express();

// Security Headers
app.use(helmet());
app.use(cookieParser());

// Strict CORS Whitelist [cite: 37, 38]
app.use(cors({
    origin: process.env.CORS_ORIGIN || 'http://localhost:5173',
    credentials: true,
    methods: ['GET', 'POST', 'PUT', 'DELETE'],
    allowedHeaders: ['Content-Type', 'Authorization']
}));

// HTTP Method, Pre-Flight Memory & Stack Overflow Protection (Limit 2MB) [cite: 36]
app.use(express.json({ limit: '2mb' }));
app.use(express.urlencoded({ extended: true, limit: '2mb' }));

// -------------------------------------------------------------------
// Swagger API Docs
// -------------------------------------------------------------------
app.use('/api-docs', swaggerUi.serve, swaggerUi.setup(swaggerSpec));

// -------------------------------------------------------------------
// Routes
// -------------------------------------------------------------------
/**
 * @swagger
 * /health:
 * get:
 * summary: Check API Health
 * tags: [System]
 * responses:
 * 200:
 * description: System is running normally
 */
app.get('/health', (req, res) => {
    res.status(200).json({ status: 'OK', message: 'PPFS Backend API is running' });
});

// Handle 404
app.use((req, res) => {
    res.status(404).json({ error: 'Route not found' });
});

const PORT = process.env.PORT || 5000;
app.listen(PORT, () => {
    console.log(`=================================`);
    console.log(`Server running on port: ${PORT}`);
    console.log(`Swagger Docs: http://localhost:${PORT}/api-docs`);
    console.log(`=================================`);
});