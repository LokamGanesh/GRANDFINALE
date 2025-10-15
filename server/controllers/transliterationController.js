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

// @desc    Process image and extract text using OCR (Enhanced for sign boards)
// @route   POST /api/transliterate/image
// @access  Public
exports.processImage = async (req, res) => {
  try {
    if (!req.file) {
      return res.status(400).json({ msg: 'Please upload an image file' });
    }

    let { fromScript, toScript } = req.body;
    
    // Set defaults for automatic detection
    if (!fromScript || fromScript === 'auto') {
      fromScript = 'devanagari'; // Default to detect Hindi/Devanagari first
    }
    if (!toScript || toScript === 'auto') {
      toScript = 'latin'; // Default to transliterate to English
    }

    console.log(`Processing image for sign board scanning: ${fromScript} -> ${toScript}`);
    
    // Read the file as buffer
    const imageBuffer = fs.readFileSync(req.file.path);
    
    // Map script to Tesseract language code with enhanced options for sign boards
    const tesseractLang = transliterator.mapScriptToTesseractLang(fromScript);
    
    // Enhanced OCR with automatic language detection
    const ocrResult = await transliterator.performEnhancedOCR(imageBuffer, tesseractLang, {
      isSignBoard: true,
      fromScript: fromScript,
      autoDetect: true
    });
    
    // Auto-detect script if needed
    if (req.body.fromScript === 'auto') {
      fromScript = transliterator.detectScript(ocrResult.text) || fromScript;
    }
    
    const extractedText = ocrResult.text;
    const confidence = ocrResult.confidence;
    
    // Clean and preprocess the extracted text for better transliteration
    const cleanedText = transliterator.cleanExtractedText(extractedText, fromScript);
    
    // Transliterate the extracted text
    const transliteratedText = transliterator.transliterate(cleanedText, fromScript, toScript);
    
    // Save to history if user is authenticated (in-memory for demo)
    if (req.user) {
      const historyItem = {
        id: Date.now().toString(),
        userId: req.user.id,
        originalText: cleanedText,
        transliteratedText,
        fromScript,
        toScript,
        date: new Date(),
        isFromImage: true,
        confidence: confidence,
        type: 'sign_board'
      };
      
      transliterationHistory.push(historyItem);
    }
    
    // Delete the temporary file
    try {
      fs.unlinkSync(req.file.path);
    } catch (unlinkError) {
      console.warn('Could not delete temporary file:', unlinkError.message);
    }
    
    res.json({
      originalText: cleanedText,
      transliteratedText,
      fromScript,
      toScript,
      confidence: confidence,
      type: 'sign_board',
      timestamp: new Date().toISOString()
    });
  } catch (err) {
    console.error('Sign board processing error:', err.message);
    
    // Clean up file on error
    if (req.file && req.file.path) {
      try {
        fs.unlinkSync(req.file.path);
      } catch (unlinkError) {
        console.warn('Could not delete temporary file on error:', unlinkError.message);
      }
    }
    
    res.status(500).json({ 
      msg: 'Error processing sign board image', 
      error: err.message,
      type: 'ocr_error'
    });
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