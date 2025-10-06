const TransliterationHistory = require('../models/TransliterationHistory');
const fs = require('fs');
const path = require('path');
const transliterator = require('../utils/transliterator');

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
    
    // Save to history if user is authenticated
    if (req.user) {
      const history = new TransliterationHistory({
        userId: req.user.id,
        originalText: text,
        transliteratedText,
        fromScript,
        toScript
      });
      
      await history.save();
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
    const history = await TransliterationHistory.find({ userId: req.user.id })
      .sort({ date: -1 });
    
    res.json(history);
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
    
    // Save to history if user is authenticated
    if (req.user) {
      const history = new TransliterationHistory({
        userId: req.user.id,
        originalText: extractedText,
        transliteratedText,
        fromScript,
        toScript,
        isFromImage: true
      });
      
      await history.save();
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
    const history = await TransliterationHistory.findById(req.params.id);
    
    if (!history) {
      return res.status(404).json({ msg: 'History item not found' });
    }
    
    // Check if the history item belongs to the user
    if (history.userId.toString() !== req.user.id) {
      return res.status(401).json({ msg: 'Not authorized' });
    }
    
    await history.remove();
    
    res.json({ msg: 'History item removed' });
  } catch (err) {
    console.error(err.message);
    res.status(500).send('Server error');
  }
};