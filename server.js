const express = require('express');
const cors = require('cors');
const helmet = require('helmet');
const cookieParser = require('cookie-parser');
const swaggerUi = require('swagger-ui-express');
const swaggerSpec = require('./swagger');
require('dotenv').config();

const app = express();

app.use(helmet());
app.use(cookieParser());

app.use(cors({
    origin: process.env.CORS_ORIGIN || 'http://localhost:5173',
    credentials: true,
    methods: ['GET', 'POST', 'PUT', 'DELETE'],
    allowedHeaders: ['Content-Type', 'Authorization']
}));

app.use(express.json({ limit: '10mb' }));
app.use(express.urlencoded({ extended: true, limit: '10mb' }));

app.use('/api-docs', swaggerUi.serve, swaggerUi.setup(swaggerSpec));

// -------------------------------------------------------------------
// Routes Imports
// -------------------------------------------------------------------
const authRoutes = require('./routes/auth.routes');
const uploadRoutes = require('./routes/upload.routes');
const logRoutes = require('./routes/log.routes'); // 1. นำเข้าไฟล์ Log Route
const dashboardRoutes = require('./routes/dashboard.route');
const nhsoRoutes = require('./routes/nhso.route');

// -------------------------------------------------------------------
// API Routes Registration
// -------------------------------------------------------------------
app.use('/api/auth', authRoutes);
app.use('/api/upload', uploadRoutes);
app.use('/api/logs', logRoutes); // 2. ลงทะเบียนใช้งานเส้นทาง /api/logs
app.use('/api/dashboard', dashboardRoutes);
app.use('/api/nhso', nhsoRoutes);

app.get('/health', (req, res) => {
    res.status(200).json({ status: 'OK', message: 'PPFS Backend API is running' });
});

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