const swaggerJSDoc = require('swagger-jsdoc');

const options = {
  definition: {
    openapi: '3.0.0',
    info: {
      title: 'PPFS Estimator & Audit System API',
      version: '1.0.0',
      description: 'API documentation for PPFS System (Node.js)',
    },
    servers: [
      {
        url: 'http://localhost:5000',
        description: 'Development server',
      },
    ],
    components: {
      securitySchemes: {
        bearerAuth: {
          type: 'http',
          scheme: 'bearer',
          bearerFormat: 'JWT',
        }
      }
    }
  },
  apis: ['./server.js', './routes/*.js'], // กำหนดพาร์ทให้สแกนหา JSDoc
};

const swaggerSpec = swaggerJSDoc(options);
module.exports = swaggerSpec;