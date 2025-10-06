/**
 * Transliteration utility for converting between Indian scripts
 * This module provides functions to transliterate text between different Indian scripts
 * and perform OCR on images
 */

const Tesseract = require('tesseract.js');

// Note: In a production application, you would use a proper transliteration library
// such as Aksharamukha, Google Transliterate API, or a custom implementation
// For this demo, we'll implement a simplified version with basic character mappings

// Basic character mappings for demonstration purposes
// In a real application, these would be much more comprehensive
const scriptMappings = {
  // Devanagari to Latin mapping (simplified)
  devanagari_to_latin: {
    'अ': 'a', 'आ': 'ā', 'इ': 'i', 'ई': 'ī', 'उ': 'u', 'ऊ': 'ū',
    'ए': 'e', 'ऐ': 'ai', 'ओ': 'o', 'औ': 'au',
    'क': 'ka', 'ख': 'kha', 'ग': 'ga', 'घ': 'gha', 'ङ': 'ṅa',
    'च': 'ca', 'छ': 'cha', 'ज': 'ja', 'झ': 'jha', 'ञ': 'ña',
    'ट': 'ṭa', 'ठ': 'ṭha', 'ड': 'ḍa', 'ढ': 'ḍha', 'ण': 'ṇa',
    'त': 'ta', 'थ': 'tha', 'द': 'da', 'ध': 'dha', 'न': 'na',
    'प': 'pa', 'फ': 'pha', 'ब': 'ba', 'भ': 'bha', 'म': 'ma',
    'य': 'ya', 'र': 'ra', 'ल': 'la', 'व': 'va',
    'श': 'śa', 'ष': 'ṣa', 'स': 'sa', 'ह': 'ha',
    'ं': 'ṃ', 'ः': 'ḥ', '्': '',
    ' ': ' ', '।': '.'
  },
  
  // Latin to Devanagari mapping (simplified)
  latin_to_devanagari: {
    'a': 'अ', 'ā': 'आ', 'i': 'इ', 'ī': 'ई', 'u': 'उ', 'ū': 'ऊ',
    'e': 'ए', 'ai': 'ऐ', 'o': 'ओ', 'au': 'औ',
    'ka': 'क', 'kha': 'ख', 'ga': 'ग', 'gha': 'घ', 'ṅa': 'ङ',
    'ca': 'च', 'cha': 'छ', 'ja': 'ज', 'jha': 'झ', 'ña': 'ञ',
    'ṭa': 'ट', 'ṭha': 'ठ', 'ḍa': 'ड', 'ḍha': 'ढ', 'ṇa': 'ण',
    'ta': 'त', 'tha': 'थ', 'da': 'द', 'dha': 'ध', 'na': 'न',
    'pa': 'प', 'pha': 'फ', 'ba': 'ब', 'bha': 'भ', 'ma': 'म',
    'ya': 'य', 'ra': 'र', 'la': 'ल', 'va': 'व',
    'śa': 'श', 'ṣa': 'ष', 'sa': 'स', 'ha': 'ह',
    'ṃ': 'ं', 'ḥ': 'ः',
    ' ': ' ', '.': '।'
  },
  
  // Add more script mappings here for other Indian scripts
  // For example: devanagari_to_tamil, tamil_to_devanagari, etc.
};

/**
 * Transliterate text from one script to another
 * @param {string} text - The text to transliterate
 * @param {string} fromScript - The source script (e.g., 'devanagari')
 * @param {string} toScript - The target script (e.g., 'latin')
 * @returns {string} - The transliterated text
 */
const transliterate = (text, fromScript, toScript) => {
  // If source and target scripts are the same, return the original text
  if (fromScript === toScript) {
    return text;
  }
  
  // Get the mapping key
  const mappingKey = `${fromScript}_to_${toScript}`;
  
  // Check if we have a direct mapping
  if (scriptMappings[mappingKey]) {
    return transliterateWithMapping(text, scriptMappings[mappingKey]);
  }
  
  // If no direct mapping exists, we could try to go through an intermediate script
  // For example: bengali -> latin -> tamil
  // This is a simplified approach and would need more sophisticated logic in a real app
  
  // For this demo, if no direct mapping exists, we'll return a placeholder message
  return `[Transliteration from ${fromScript} to ${toScript} is not yet implemented]`;
};

/**
 * Transliterate text using a character mapping
 * @param {string} text - The text to transliterate
 * @param {Object} mapping - The character mapping object
 * @returns {string} - The transliterated text
 */
const transliterateWithMapping = (text, mapping) => {
  // This is a very simplified implementation
  // A real implementation would handle complex script rules, conjuncts, etc.
  
  let result = '';
  
  // Simple character-by-character replacement
  // This won't work well for many scripts but serves as a demonstration
  for (let i = 0; i < text.length; i++) {
    const char = text[i];
    result += mapping[char] || char;
  }
  
  return result;
};

/**
 * Get a list of supported scripts
 * @returns {Array} - Array of supported script codes
 */
const getSupportedScripts = () => {
  const scripts = new Set();
  
  // Extract script names from mapping keys
  Object.keys(scriptMappings).forEach(key => {
    const [from, to] = key.split('_to_');
    scripts.add(from);
    scripts.add(to);
  });
  
  return Array.from(scripts);
};

/**
 * Perform OCR on an image and extract text
 * @param {Buffer} imageBuffer - The image buffer
 * @param {string} language - The language code for OCR (e.g., 'eng', 'hin', 'ben')
 * @returns {Promise<string>} - The extracted text
 */
const performOCR = async (imageBuffer, language = 'eng') => {
  try {
    const result = await Tesseract.recognize(
      imageBuffer,
      language,
      { logger: m => console.log(m) }
    );
    
    return result.data.text;
  } catch (error) {
    console.error('OCR Error:', error);
    throw new Error('Failed to perform OCR on the image');
  }
};

/**
 * Map Tesseract language codes to our script codes
 * @param {string} script - Our script code
 * @returns {string} - Tesseract language code
 */
const mapScriptToTesseractLang = (script) => {
  const mapping = {
    'devanagari': 'hin+san+mar', // Hindi, Sanskrit, Marathi
    'bengali': 'ben',
    'gujarati': 'guj',
    'gurmukhi': 'pan', // Punjabi
    'kannada': 'kan',
    'malayalam': 'mal',
    'odia': 'ori',
    'tamil': 'tam',
    'telugu': 'tel',
    'latin': 'eng'
  };
  
  return mapping[script] || 'eng';
};

module.exports = {
  transliterate,
  getSupportedScripts,
  performOCR,
  mapScriptToTesseractLang
};