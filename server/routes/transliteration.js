const express = require('express');
const router = express.Router();
const transliterationController = require('../controllers/transliterationController');
const auth = require('../middleware/auth');
const upload = require('../middleware/upload');

// @route   POST api/transliterate
// @desc    Transliterate text from one script to another
// @access  Public (but saves history if authenticated)
router.post('/', transliterationController.transliterate);

// @route   POST api/transliterate/image
// @desc    Process image and extract text using OCR
// @access  Public (but saves history if authenticated)
router.post('/image', upload.single('image'), transliterationController.processImage);

// @route   GET api/transliterate/history
// @desc    Get user's transliteration history
// @access  Private
router.get('/history', auth, transliterationController.getHistory);

// @route   DELETE api/transliterate/history/:id
// @desc    Delete a history item
// @access  Private
router.delete('/history/:id', auth, transliterationController.deleteHistoryItem);

module.exports = router;