const express = require('express');
const cors = require('cors');
const bodyParser = require('body-parser');
const path = require('path');
require('dotenv').config();

const app = express();

// Middleware
app.use(cors());
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

// Serve static files from uploads directory
app.use('/uploads', express.static(path.join(__dirname, 'uploads')));

// Basic routes for transliteration app
app.get('/', (req, res) => {
  res.json({
    message: 'Transliterate Bharat API is running',
    version: '1.0.0',
    status: 'active'
  });
});

app.get('/health', (req, res) => {
  res.json({
    status: 'OK',
    timestamp: new Date().toISOString(),
    uptime: process.uptime()
  });
});

// Simple transliteration endpoint
app.post('/api/transliterate', (req, res) => {
  const { text, sourceScript, targetScript } = req.body;
  
  // Simple mock transliteration (replace with actual logic)
  res.json({
    success: true,
    originalText: text,
    transliteratedText: `[${targetScript}] ${text}`,
    sourceScript,
    targetScript,
    timestamp: new Date().toISOString()
  });
});

// Simple user registration endpoint
app.post('/api/users/register', (req, res) => {
  const { username, email, password } = req.body;
  
  // Mock registration success
  res.json({
    success: true,
    message: 'User registered successfully',
    token: 'mock-jwt-token',
    user: { username, email }
  });
});

// Simple user login endpoint
app.post('/api/users/login', (req, res) => {
  const { email, password } = req.body;
  
  // Mock login success
  res.json({
    success: true,
    message: 'Login successful',
    token: 'mock-jwt-token',
    user: { email }
  });
});

// Get user profile
app.get('/api/users/me', (req, res) => {
  res.json({
    success: true,
    user: { 
      email: 'user@example.com',
      username: 'testuser'
    }
  });
});

// Error handling middleware
app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(500).json({
    error: 'Something went wrong!',
    message: err.message
  });
});

const PORT = process.env.PORT || 5000;

app.listen(PORT, () => {
  console.log(`🚀 Transliterate Bharat Server running on port ${PORT}`);
  console.log(`🌐 API URL: http://localhost:${PORT}`);
  console.log(`📊 Health Check: http://localhost:${PORT}/health`);
});