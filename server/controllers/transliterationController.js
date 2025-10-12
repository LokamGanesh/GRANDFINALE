// const TransliterationHistory = require('../models/TransliterationHistory');
const fs = require('fs');
const path = require('path');
const transliterator = require('../utils/transliterator');

// In-memory storage for demo purposes (replace with database in production)
let transliterationHistory = [];

// @desc    Transliterate text
// @route   POST /api/transliterate
// @access  Public
exports.transliterate = async (req, res) => {
  try {
    const { text, fromScript, toScript } = req.body;
    
    if (!text || !fromScript || !toScript) {
      return res.status(400).json({ msg: 'Please provide text, source script, and target script' });
    }

    // Use the transliterator utility
    const transliteratedText = transliterator.transliterate(text, fromScript, toScript);
    
    // Save to history if user is authenticated (in-memory for demo)
    if (req.user) {
      const historyItem = {
        id: Date.now().toString(),
        userId: req.user.id,
        originalText: text,
        transliteratedText,
        fromScript,
        toScript,
        date: new Date(),
        isFromImage: false
      };
      
      transliterationHistory.push(historyItem);
    }
    
    res.json({ originalText: text, transliteratedText, fromScript, toScript });
  } catch (err) {
    console.error(err.message);
    res.status(500).send('Server error');
  }
};

// Get user's transliteration history
exports.getHistory = async (req, res) => {
  try {
    const userHistory = transliterationHistory
      .filter(item => item.userId === req.user.id)
      .sort((a, b) => new Date(b.date) - new Date(a.date));
    
    res.json(userHistory);
  } catch (err) {
    console.error(err.message);
    res.status(500).send('Server error');
  }
};

// @desc    Process image and extract text using OCR
// @route   POST /api/transliterate/image
// @access  Public
exports.processImage = async (req, res) => {
  try {
    if (!req.file) {
      return res.status(400).json({ msg: 'Please upload an image file' });
    }

    const { fromScript, toScript } = req.body;
    
    if (!fromScript || !toScript) {
      return res.status(400).json({ msg: 'Please provide source script and target script' });
    }

    // Get the file path
    const filePath = path.join(__dirname, '..', req.file.path);
    
    // Read the file as buffer
    const imageBuffer = fs.readFileSync(req.file.path);
    
    // Map script to Tesseract language code
    const tesseractLang = transliterator.mapScriptToTesseractLang(fromScript);
    
    // Perform OCR
    const extractedText = await transliterator.performOCR(imageBuffer, tesseractLang);
    
    // Transliterate the extracted text
    const transliteratedText = transliterator.transliterate(extractedText, fromScript, toScript);
    
    // Save to history if user is authenticated (in-memory for demo)
    if (req.user) {
      const historyItem = {
        id: Date.now().toString(),
        userId: req.user.id,
        originalText: extractedText,
        transliteratedText,
        fromScript,
        toScript,
        date: new Date(),
        isFromImage: true
      };
      
      transliterationHistory.push(historyItem);
    }
    
    // Delete the temporary file
    fs.unlinkSync(req.file.path);
    
    res.json({
      originalText: extractedText,
      transliteratedText,
      fromScript,
      toScript
    });
  } catch (err) {
    console.error(err.message);
    res.status(500).send('Server error');
  }
};

// Delete a history item
exports.deleteHistoryItem = async (req, res) => {
  try {
    const itemIndex = transliterationHistory.findIndex(
      item => item.id === req.params.id && item.userId === req.user.id
    );
    
    if (itemIndex === -1) {
      return res.status(404).json({ msg: 'History item not found' });
    }
    
    transliterationHistory.splice(itemIndex, 1);
    
    res.json({ msg: 'History item removed' });
  } catch (err) {
    console.error(err.message);
    res.status(500).send('Server error');
  }
};