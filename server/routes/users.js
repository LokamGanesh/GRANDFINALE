const express = require('express');
const router = express.Router();
const userController = require('../controllers/userController');
const auth = require('../middleware/auth');

// @route   POST api/users/register
// @desc    Register a new user
// @access  Public
router.post('/register', userController.register);

// @route   POST api/users/login
// @desc    Authenticate user & get token
// @access  Public
router.post('/login', userController.login);

// @route   GET api/users/me
// @desc    Get current user profile
// @access  Private
router.get('/me', auth, userController.getProfile);

module.exports = router;