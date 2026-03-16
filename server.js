const express = require('express');
const cors = require('cors');
const helmet = require('helmet');
const cookieParser = require('cookie-parser');
const swaggerUi = require('swagger-ui-express');
const swaggerSpec = require('./swagger');
require('dotenv').config();

// [SRS] Absolute Timezone
process.env.TZ = 'Asia/Bangkok';

const app = express();

app.use(helmet());
app.use(cookieParser());

// [SRS] Strict CORS Whitelist
const allowedOrigins = (process.env.CORS_ORIGIN || 'http://localhost:5173').split(',');
app.use(cors({
    origin: function(origin, callback) {
        if (!origin || allowedOrigins.indexOf(origin) !== -1) {
            callback(null, true);
        } else {
            callback(new Error('Not allowed by CORS'));
        }
    },
    credentials: true,
    methods: ['GET', 'POST', 'PUT', 'DELETE'],
    allowedHeaders: ['Content-Type', 'Authorization']
}));

// [SRS] Pre-Flight Memory & Stack Overflow Protection (Limit 2MB)
app.use(express.json({ limit: '2mb' }));
app.use(express.urlencoded({ extended: true, limit: '2mb' }));

// [SRS] ดักจับ JSON Parse Error (Bad Request)
app.use((err, req, res, next) => {
    if (err instanceof SyntaxError && err.status === 400 && 'body' in err) {
        return res.status(400).json({ error: 'Invalid JSON Payload' });
    }
    next();
});

app.use('/api-docs', swaggerUi.serve, swaggerUi.setup(swaggerSpec));

// -------------------------------------------------------------------
// Routes Imports
// -------------------------------------------------------------------
const authRoutes = require('./routes/auth.routes');
const uploadRoutes = require('./routes/upload.routes');
const logRoutes = require('./routes/log.routes');
const dashboardRoutes = require('./routes/dashboard.route');
const nhsoRoutes = require('./routes/nhso.route');

// -------------------------------------------------------------------
// API Routes Registration
// -------------------------------------------------------------------
app.use('/api/auth', authRoutes);
app.use('/api/upload', uploadRoutes);
app.use('/api/logs', logRoutes);
app.use('/api/dashboard', dashboardRoutes);
app.use('/api/nhso', nhsoRoutes);

app.get('/health', (req, res) => {
    res.status(200).json({ status: 'OK', message: 'PPFS Backend API is running' });
});

app.use((req, res) => {
    res.status(404).json({ error: 'Route not found or Method not allowed' });
});

const PORT = process.env.PORT || 5001;
const server = app.listen(PORT, () => {
    console.log(`=================================`);
    console.log(`Server running on port: ${PORT}`);
    console.log(`Swagger Docs: http://localhost:${PORT}/api-docs`);
    console.log(`=================================`);
});

// [SRS] Timeout Override 120 วินาที
server.setTimeout(120000);