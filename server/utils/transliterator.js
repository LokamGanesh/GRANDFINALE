/**
 * Transliteration utility for converting between Indian scripts
 * This module provides functions to transliterate text between different Indian scripts
 * and perform OCR on images
 */

const Tesseract = require('tesseract.js');

// Using comprehensive character mappings for Indian script transliteration
// This provides accurate transliteration between major Indian scripts

// Note: In a production application, you would use a proper transliteration library
// such as Aksharamukha, Google Transliterate API, or a custom implementation
// For this demo, we'll implement a simplified version with basic character mappings

// Comprehensive character mappings for Indian scripts
const scriptMappings = {
  // Devanagari to Latin mapping (IAST standard)
  devanagari_to_latin: {
    // Vowels
    'अ': 'a', 'आ': 'ā', 'इ': 'i', 'ई': 'ī', 'उ': 'u', 'ऊ': 'ū',
    'ऋ': 'ṛ', 'ॠ': 'ṝ', 'ऌ': 'ḷ', 'ॡ': 'ḹ',
    'ए': 'e', 'ऐ': 'ai', 'ओ': 'o', 'औ': 'au',
    
    // Consonants
    'क': 'ka', 'ख': 'kha', 'ग': 'ga', 'घ': 'gha', 'ङ': 'ṅa',
    'च': 'ca', 'छ': 'cha', 'ज': 'ja', 'झ': 'jha', 'ञ': 'ña',
    'ट': 'ṭa', 'ठ': 'ṭha', 'ड': 'ḍa', 'ढ': 'ḍha', 'ण': 'ṇa',
    'त': 'ta', 'थ': 'tha', 'द': 'da', 'ध': 'dha', 'न': 'na',
    'प': 'pa', 'फ': 'pha', 'ब': 'ba', 'भ': 'bha', 'म': 'ma',
    'य': 'ya', 'र': 'ra', 'ल': 'la', 'व': 'va',
    'श': 'śa', 'ष': 'ṣa', 'स': 'sa', 'ह': 'ha',
    
    // Diacritics and special characters
    'ं': 'ṃ', 'ः': 'ḥ', '्': '', 'ँ': '̃',
    
    // Vowel signs (matras)
    'ा': 'ā', 'ि': 'i', 'ी': 'ī', 'ु': 'u', 'ू': 'ū',
    'ृ': 'ṛ', 'ॄ': 'ṝ', 'ॢ': 'ḷ', 'ॣ': 'ḹ',
    'े': 'e', 'ै': 'ai', 'ो': 'o', 'ौ': 'au',
    
    // Numbers
    '०': '0', '१': '1', '२': '2', '३': '3', '४': '4',
    '५': '5', '६': '6', '७': '7', '८': '8', '९': '9',
    
    // Punctuation
    ' ': ' ', '।': '.', '॥': '||'
  },
  
  // Latin to Devanagari mapping (IAST standard)
  latin_to_devanagari: {
    // Vowels
    'a': 'अ', 'ā': 'आ', 'i': 'इ', 'ī': 'ई', 'u': 'उ', 'ū': 'ऊ',
    'ṛ': 'ऋ', 'ṝ': 'ॠ', 'ḷ': 'ऌ', 'ḹ': 'ॡ',
    'e': 'ए', 'ai': 'ऐ', 'o': 'ओ', 'au': 'औ',
    
    // Consonants
    'ka': 'क', 'kha': 'ख', 'ga': 'ग', 'gha': 'घ', 'ṅa': 'ङ',
    'ca': 'च', 'cha': 'छ', 'ja': 'ज', 'jha': 'झ', 'ña': 'ञ',
    'ṭa': 'ट', 'ṭha': 'ठ', 'ḍa': 'ड', 'ḍha': 'ढ', 'ṇa': 'ण',
    'ta': 'त', 'tha': 'थ', 'da': 'द', 'dha': 'ध', 'na': 'न',
    'pa': 'प', 'pha': 'फ', 'ba': 'ब', 'bha': 'भ', 'ma': 'म',
    'ya': 'य', 'ra': 'र', 'la': 'ल', 'va': 'व',
    'śa': 'श', 'ṣa': 'ष', 'sa': 'स', 'ha': 'ह',
    
    // Diacritics
    'ṃ': 'ं', 'ḥ': 'ः',
    
    // Numbers
    '0': '०', '1': '१', '2': '२', '3': '३', '4': '४',
    '5': '५', '6': '६', '7': '७', '8': '८', '9': '९',
    
    // Punctuation
    ' ': ' ', '.': '।', '||': '॥'
  },

  // Tamil to Latin mapping
  tamil_to_latin: {
    // Vowels
    'அ': 'a', 'ஆ': 'ā', 'இ': 'i', 'ஈ': 'ī', 'உ': 'u', 'ஊ': 'ū',
    'எ': 'e', 'ஏ': 'ē', 'ஐ': 'ai', 'ஒ': 'o', 'ஓ': 'ō', 'ஔ': 'au',
    
    // Consonants
    'க': 'ka', 'ங': 'ṅa', 'ச': 'ca', 'ஞ': 'ña', 'ட': 'ṭa',
    'ண': 'ṇa', 'த': 'ta', 'ந': 'na', 'ப': 'pa', 'ம': 'ma',
    'ய': 'ya', 'ர': 'ra', 'ல': 'la', 'வ': 'va', 'ழ': 'ḻa',
    'ள': 'ḷa', 'ற': 'ṟa', 'ன': 'ṉa',
    
    // Grantha letters
    'ஜ': 'ja', 'ஷ': 'ṣa', 'ஸ': 'sa', 'ஹ': 'ha', 'க்ஷ': 'kṣa',
    
    // Vowel signs
    'ா': 'ā', 'ி': 'i', 'ீ': 'ī', 'ு': 'u', 'ூ': 'ū',
    'ெ': 'e', 'ே': 'ē', 'ை': 'ai', 'ொ': 'o', 'ோ': 'ō', 'ௌ': 'au',
    
    // Special
    '்': '', 'ஃ': 'ḥ',
    
    // Numbers
    '௦': '0', '௧': '1', '௨': '2', '௩': '3', '௪': '4',
    '௫': '5', '௬': '6', '௭': '7', '௮': '8', '௯': '9',
    
    ' ': ' '
  },

  // Latin to Tamil mapping
  latin_to_tamil: {
    // Vowels
    'a': 'அ', 'ā': 'ஆ', 'i': 'இ', 'ī': 'ஈ', 'u': 'உ', 'ū': 'ஊ',
    'e': 'எ', 'ē': 'ஏ', 'ai': 'ஐ', 'o': 'ஒ', 'ō': 'ஓ', 'au': 'ஔ',
    
    // Consonants
    'ka': 'க', 'ṅa': 'ங', 'ca': 'ச', 'ña': 'ஞ', 'ṭa': 'ட',
    'ṇa': 'ண', 'ta': 'த', 'na': 'ந', 'pa': 'ப', 'ma': 'ம',
    'ya': 'ய', 'ra': 'ர', 'la': 'ல', 'va': 'வ', 'ḻa': 'ழ',
    'ḷa': 'ள', 'ṟa': 'ற', 'ṉa': 'ன',
    
    // Grantha letters
    'ja': 'ஜ', 'ṣa': 'ஷ', 'sa': 'ஸ', 'ha': 'ஹ', 'kṣa': 'க்ஷ',
    
    // Special
    'ḥ': 'ஃ',
    
    // Numbers
    '0': '௦', '1': '௧', '2': '௨', '3': '௩', '4': '௪',
    '5': '௫', '6': '௬', '7': '௭', '8': '௮', '9': '௯',
    
    ' ': ' '
  },

  // Bengali to Latin mapping
  bengali_to_latin: {
    // Vowels
    'অ': 'a', 'আ': 'ā', 'ই': 'i', 'ঈ': 'ī', 'উ': 'u', 'ঊ': 'ū',
    'ঋ': 'ṛ', 'এ': 'e', 'ঐ': 'ai', 'ও': 'o', 'ঔ': 'au',
    
    // Consonants
    'ক': 'ka', 'খ': 'kha', 'গ': 'ga', 'ঘ': 'gha', 'ঙ': 'ṅa',
    'চ': 'ca', 'ছ': 'cha', 'জ': 'ja', 'ঝ': 'jha', 'ঞ': 'ña',
    'ট': 'ṭa', 'ঠ': 'ṭha', 'ড': 'ḍa', 'ঢ': 'ḍha', 'ণ': 'ṇa',
    'ত': 'ta', 'থ': 'tha', 'দ': 'da', 'ধ': 'dha', 'ন': 'na',
    'প': 'pa', 'ফ': 'pha', 'ব': 'ba', 'ভ': 'bha', 'ম': 'ma',
    'য': 'ya', 'র': 'ra', 'ল': 'la', 'শ': 'śa', 'ষ': 'ṣa',
    'স': 'sa', 'হ': 'ha', 'ড়': 'ṛa', 'ঢ়': 'ṛha', 'য়': 'ẏa',
    
    // Vowel signs
    'া': 'ā', 'ি': 'i', 'ী': 'ī', 'ু': 'u', 'ূ': 'ū',
    'ৃ': 'ṛ', 'ে': 'e', 'ৈ': 'ai', 'ো': 'o', 'ৌ': 'au',
    
    // Special
    '্': '', 'ং': 'ṃ', 'ঃ': 'ḥ', 'ঁ': '̃',
    
    // Numbers
    '০': '0', '১': '1', '২': '2', '৩': '3', '৪': '4',
    '৫': '5', '৬': '6', '৭': '7', '৮': '8', '৯': '9',
    
    ' ': ' '
  },

  // Latin to Bengali mapping
  latin_to_bengali: {
    // Vowels
    'a': 'অ', 'ā': 'আ', 'i': 'ই', 'ī': 'ঈ', 'u': 'উ', 'ū': 'ঊ',
    'ṛ': 'ঋ', 'e': 'এ', 'ai': 'ঐ', 'o': 'ও', 'au': 'ঔ',
    
    // Consonants
    'ka': 'ক', 'kha': 'খ', 'ga': 'গ', 'gha': 'ঘ', 'ṅa': 'ঙ',
    'ca': 'চ', 'cha': 'ছ', 'ja': 'জ', 'jha': 'ঝ', 'ña': 'ঞ',
    'ṭa': 'ট', 'ṭha': 'ঠ', 'ḍa': 'ড', 'ḍha': 'ঢ', 'ṇa': 'ণ',
    'ta': 'ত', 'tha': 'থ', 'da': 'দ', 'dha': 'ধ', 'na': 'ন',
    'pa': 'প', 'pha': 'ফ', 'ba': 'ব', 'bha': 'ভ', 'ma': 'ম',
    'ya': 'য', 'ra': 'র', 'la': 'ল', 'śa': 'শ', 'ṣa': 'ষ',
    'sa': 'স', 'ha': 'হ', 'ṛa': 'ড়', 'ṛha': 'ঢ়', 'ẏa': 'য়',
    
    // Special
    'ṃ': 'ং', 'ḥ': 'ঃ',
    
    // Numbers
    '0': '০', '1': '১', '2': '২', '3': '৩', '4': '৪',
    '5': '৫', '6': '৬', '7': '৭', '8': '৮', '9': '৯',
    
    ' ': ' '
  },

  // Telugu to Latin mapping
  telugu_to_latin: {
    // Vowels
    'అ': 'a', 'ఆ': 'ā', 'ఇ': 'i', 'ఈ': 'ī', 'ఉ': 'u', 'ఊ': 'ū',
    'ఋ': 'ṛ', 'ౠ': 'ṝ', 'ఌ': 'ḷ', 'ౡ': 'ḹ',
    'ఎ': 'e', 'ఏ': 'ē', 'ఐ': 'ai', 'ఒ': 'o', 'ఓ': 'ō', 'ఔ': 'au',
    
    // Consonants
    'క': 'ka', 'ఖ': 'kha', 'గ': 'ga', 'ఘ': 'gha', 'ఙ': 'ṅa',
    'చ': 'ca', 'ఛ': 'cha', 'జ': 'ja', 'ఝ': 'jha', 'ఞ': 'ña',
    'ట': 'ṭa', 'ఠ': 'ṭha', 'డ': 'ḍa', 'ఢ': 'ḍha', 'ణ': 'ṇa',
    'త': 'ta', 'థ': 'tha', 'ద': 'da', 'ధ': 'dha', 'న': 'na',
    'ప': 'pa', 'ఫ': 'pha', 'బ': 'ba', 'భ': 'bha', 'మ': 'ma',
    'య': 'ya', 'ర': 'ra', 'ల': 'la', 'వ': 'va', 'శ': 'śa',
    'ష': 'ṣa', 'స': 'sa', 'హ': 'ha', 'ళ': 'ḷa', 'క్ష': 'kṣa',
    
    // Vowel signs
    'ా': 'ā', 'ి': 'i', 'ీ': 'ī', 'ు': 'u', 'ూ': 'ū',
    'ృ': 'ṛ', 'ౄ': 'ṝ', 'ె': 'e', 'ే': 'ē', 'ై': 'ai',
    'ొ': 'o', 'ో': 'ō', 'ౌ': 'au',
    
    // Special
    '్': '', 'ం': 'ṃ', 'ః': 'ḥ',
    
    // Numbers
    '౦': '0', '౧': '1', '౨': '2', '౩': '3', '౪': '4',
    '౫': '5', '౬': '6', '౭': '7', '౮': '8', '౯': '9',
    
    ' ': ' '
  },

  // Latin to Telugu mapping
  latin_to_telugu: {
    // Vowels (standalone)
    'a': 'అ', 'ā': 'ఆ', 'aa': 'ఆ', 'i': 'ఇ', 'ī': 'ఈ', 'ii': 'ఈ', 
    'u': 'ఉ', 'ū': 'ఊ', 'uu': 'ఊ', 'ṛ': 'ఋ', 'ṝ': 'ౠ', 'ḷ': 'ఌ', 'ḹ': 'ౡ',
    'e': 'ఎ', 'ē': 'ఏ', 'ee': 'ఏ', 'ai': 'ఐ', 'o': 'ఒ', 'ō': 'ఓ', 'oo': 'ఓ', 'au': 'ఔ',
    
    // Consonants with inherent 'a'
    'ka': 'క', 'kha': 'ఖ', 'ga': 'గ', 'gha': 'ఘ', 'ṅa': 'ఙ', 'nga': 'ఙ',
    'ca': 'చ', 'cha': 'ఛ', 'ja': 'జ', 'jha': 'ఝ', 'ña': 'ఞ', 'nya': 'ఞ',
    'ṭa': 'ట', 'ṭha': 'ఠ', 'ḍa': 'డ', 'ḍha': 'ఢ', 'ṇa': 'ణ',
    'ta': 'త', 'tha': 'థ', 'da': 'ద', 'dha': 'ధ', 'na': 'న',
    'pa': 'ప', 'pha': 'ఫ', 'ba': 'బ', 'bha': 'భ', 'ma': 'మ',
    'ya': 'య', 'ra': 'ర', 'la': 'ల', 'va': 'వ', 'wa': 'వ',
    'śa': 'శ', 'sha': 'శ', 'ṣa': 'ష', 'sa': 'స', 'ha': 'హ', 
    'ḷa': 'ళ', 'kṣa': 'క్ష', 'ksha': 'క్ష',
    
    // Single consonants (will be converted to consonant + virama)
    'k': 'క్', 'g': 'గ్', 'c': 'చ్', 'j': 'జ్', 't': 'త్', 'd': 'ద్',
    'p': 'ప్', 'b': 'బ్', 'm': 'మ్', 'n': 'న్', 'r': 'ర్', 'l': 'ల్',
    'v': 'వ్', 'w': 'వ్', 's': 'స్', 'h': 'హ్', 'y': 'య్',
    
    // Special characters
    'ṃ': 'ం', 'ḥ': 'ః', 'OM': 'ఓం', 'om': 'ఓం',
    
    // Numbers
    '0': '౦', '1': '౧', '2': '౨', '3': '౩', '4': '౪',
    '5': '౫', '6': '౬', '7': '౭', '8': '౮', '9': '౯',
    
    // Punctuation and space
    ' ': ' ', '.': '.', ',': ',', '!': '!', '?': '?'
  },

  // Gujarati to Latin mapping
  gujarati_to_latin: {
    // Vowels
    'અ': 'a', 'આ': 'ā', 'ઇ': 'i', 'ઈ': 'ī', 'ઉ': 'u', 'ઊ': 'ū',
    'ઋ': 'ṛ', 'એ': 'e', 'ઐ': 'ai', 'ઓ': 'o', 'ઔ': 'au',
    
    // Consonants
    'ક': 'ka', 'ખ': 'kha', 'ગ': 'ga', 'ઘ': 'gha', 'ઙ': 'ṅa',
    'ચ': 'ca', 'છ': 'cha', 'જ': 'ja', 'ઝ': 'jha', 'ઞ': 'ña',
    'ટ': 'ṭa', 'ઠ': 'ṭha', 'ડ': 'ḍa', 'ઢ': 'ḍha', 'ણ': 'ṇa',
    'ત': 'ta', 'થ': 'tha', 'દ': 'da', 'ધ': 'dha', 'ન': 'na',
    'પ': 'pa', 'ફ': 'pha', 'બ': 'ba', 'ભ': 'bha', 'મ': 'ma',
    'ય': 'ya', 'ર': 'ra', 'લ': 'la', 'વ': 'va', 'શ': 'śa',
    'ષ': 'ṣa', 'સ': 'sa', 'હ': 'ha', 'ળ': 'ḷa',
    
    // Vowel signs
    'ા': 'ā', 'િ': 'i', 'ી': 'ī', 'ુ': 'u', 'ૂ': 'ū',
    'ૃ': 'ṛ', 'ે': 'e', 'ૈ': 'ai', 'ો': 'o', 'ૌ': 'au',
    
    // Special
    '્': '', 'ં': 'ṃ', 'ઃ': 'ḥ',
    
    // Numbers
    '૦': '0', '૧': '1', '૨': '2', '૩': '3', '૪': '4',
    '૫': '5', '૬': '6', '૭': '7', '૮': '8', '૯': '9',
    
    ' ': ' '
  },

  // Latin to Gujarati mapping
  latin_to_gujarati: {
    // Vowels
    'a': 'અ', 'ā': 'આ', 'i': 'ઇ', 'ī': 'ઈ', 'u': 'ઉ', 'ū': 'ઊ',
    'ṛ': 'ઋ', 'e': 'એ', 'ai': 'ઐ', 'o': 'ઓ', 'au': 'ઔ',
    
    // Consonants
    'ka': 'ક', 'kha': 'ખ', 'ga': 'ગ', 'gha': 'ઘ', 'ṅa': 'ઙ',
    'ca': 'ચ', 'cha': 'છ', 'ja': 'જ', 'jha': 'ઝ', 'ña': 'ઞ',
    'ṭa': 'ટ', 'ṭha': 'ઠ', 'ḍa': 'ડ', 'ḍha': 'ઢ', 'ṇa': 'ણ',
    'ta': 'ત', 'tha': 'થ', 'da': 'દ', 'dha': 'ધ', 'na': 'ન',
    'pa': 'પ', 'pha': 'ફ', 'ba': 'બ', 'bha': 'ભ', 'ma': 'મ',
    'ya': 'ય', 'ra': 'ર', 'la': 'લ', 'va': 'વ', 'śa': 'શ',
    'ṣa': 'ષ', 'sa': 'સ', 'ha': 'હ', 'ḷa': 'ળ',
    
    // Special
    'ṃ': 'ં', 'ḥ': 'ઃ',
    
    // Numbers
    '0': '૦', '1': '૧', '2': '૨', '3': '૩', '4': '૪',
    '5': '૫', '6': '૬', '7': '૭', '8': '૮', '9': '૯',
    
    ' ': ' '
  },

  // Kannada to Latin mapping
  kannada_to_latin: {
    // Vowels
    'ಅ': 'a', 'ಆ': 'ā', 'ಇ': 'i', 'ಈ': 'ī', 'ಉ': 'u', 'ಊ': 'ū',
    'ಋ': 'ṛ', 'ಎ': 'e', 'ಏ': 'ē', 'ಐ': 'ai', 'ಒ': 'o', 'ಓ': 'ō', 'ಔ': 'au',
    
    // Consonants
    'ಕ': 'ka', 'ಖ': 'kha', 'ಗ': 'ga', 'ಘ': 'gha', 'ಙ': 'ṅa',
    'ಚ': 'ca', 'ಛ': 'cha', 'ಜ': 'ja', 'ಝ': 'jha', 'ಞ': 'ña',
    'ಟ': 'ṭa', 'ಠ': 'ṭha', 'ಡ': 'ḍa', 'ಢ': 'ḍha', 'ಣ': 'ṇa',
    'ತ': 'ta', 'ಥ': 'tha', 'ದ': 'da', 'ಧ': 'dha', 'ನ': 'na',
    'ಪ': 'pa', 'ಫ': 'pha', 'ಬ': 'ba', 'ಭ': 'bha', 'ಮ': 'ma',
    'ಯ': 'ya', 'ರ': 'ra', 'ಲ': 'la', 'ವ': 'va', 'ಶ': 'śa',
    'ಷ': 'ṣa', 'ಸ': 'sa', 'ಹ': 'ha', 'ಳ': 'ḷa',
    
    // Vowel signs
    'ಾ': 'ā', 'ಿ': 'i', 'ೀ': 'ī', 'ು': 'u', 'ೂ': 'ū',
    'ೃ': 'ṛ', 'ೆ': 'e', 'ೇ': 'ē', 'ೈ': 'ai', 'ೊ': 'o', 'ೋ': 'ō', 'ೌ': 'au',
    
    // Special
    '್': '', 'ಂ': 'ṃ', 'ಃ': 'ḥ',
    
    // Numbers
    '೦': '0', '೧': '1', '೨': '2', '೩': '3', '೪': '4',
    '೫': '5', '೬': '6', '೭': '7', '೮': '8', '೯': '9',
    
    ' ': ' '
  },

  // Latin to Kannada mapping
  latin_to_kannada: {
    // Vowels
    'a': 'ಅ', 'ā': 'ಆ', 'aa': 'ಆ', 'i': 'ಇ', 'ī': 'ಈ', 'ii': 'ಈ',
    'u': 'ಉ', 'ū': 'ಊ', 'uu': 'ಊ', 'ṛ': 'ಋ',
    'e': 'ಎ', 'ē': 'ಏ', 'ee': 'ಏ', 'ai': 'ಐ', 'o': 'ಒ', 'ō': 'ಓ', 'oo': 'ಓ', 'au': 'ಔ',
    
    // Consonants
    'ka': 'ಕ', 'kha': 'ಖ', 'ga': 'ಗ', 'gha': 'ಘ', 'ṅa': 'ಙ', 'nga': 'ಙ',
    'ca': 'ಚ', 'cha': 'ಛ', 'ja': 'ಜ', 'jha': 'ಝ', 'ña': 'ಞ', 'nya': 'ಞ',
    'ṭa': 'ಟ', 'ṭha': 'ಠ', 'ḍa': 'ಡ', 'ḍha': 'ಢ', 'ṇa': 'ಣ',
    'ta': 'ತ', 'tha': 'ಥ', 'da': 'ದ', 'dha': 'ಧ', 'na': 'ನ',
    'pa': 'ಪ', 'pha': 'ಫ', 'ba': 'ಬ', 'bha': 'ಭ', 'ma': 'ಮ',
    'ya': 'ಯ', 'ra': 'ರ', 'la': 'ಲ', 'va': 'ವ', 'wa': 'ವ',
    'śa': 'ಶ', 'sha': 'ಶ', 'ṣa': 'ಷ', 'sa': 'ಸ', 'ha': 'ಹ', 'ḷa': 'ಳ',
    
    // Single consonants
    'k': 'ಕ್', 'g': 'ಗ್', 'c': 'ಚ್', 'j': 'ಜ್', 't': 'ತ್', 'd': 'ದ್',
    'p': 'ಪ್', 'b': 'ಬ್', 'm': 'ಮ್', 'n': 'ನ್', 'r': 'ರ್', 'l': 'ಲ್',
    'v': 'ವ್', 'w': 'ವ್', 's': 'ಸ್', 'h': 'ಹ್', 'y': 'ಯ್',
    
    // Special
    'ṃ': 'ಂ', 'ḥ': 'ಃ',
    
    // Numbers
    '0': '೦', '1': '೧', '2': '೨', '3': '೩', '4': '೪',
    '5': '೫', '6': '೬', '7': '೭', '8': '೮', '9': '೯',
    
    ' ': ' ', '.': '.', ',': ',', '!': '!', '?': '?'
  },

  // Malayalam to Latin mapping
  malayalam_to_latin: {
    // Vowels
    'അ': 'a', 'ആ': 'ā', 'ഇ': 'i', 'ഈ': 'ī', 'ഉ': 'u', 'ഊ': 'ū',
    'ഋ': 'ṛ', 'എ': 'e', 'ഏ': 'ē', 'ഐ': 'ai', 'ഒ': 'o', 'ഓ': 'ō', 'ഔ': 'au',
    
    // Consonants
    'ക': 'ka', 'ഖ': 'kha', 'ഗ': 'ga', 'ഘ': 'gha', 'ങ': 'ṅa',
    'ച': 'ca', 'ഛ': 'cha', 'ജ': 'ja', 'ഝ': 'jha', 'ഞ': 'ña',
    'ട': 'ṭa', 'ഠ': 'ṭha', 'ഡ': 'ḍa', 'ഢ': 'ḍha', 'ണ': 'ṇa',
    'ത': 'ta', 'ഥ': 'tha', 'ദ': 'da', 'ധ': 'dha', 'ന': 'na',
    'പ': 'pa', 'ഫ': 'pha', 'ബ': 'ba', 'ഭ': 'bha', 'മ': 'ma',
    'യ': 'ya', 'ര': 'ra', 'ല': 'la', 'വ': 'va', 'ശ': 'śa',
    'ഷ': 'ṣa', 'സ': 'sa', 'ഹ': 'ha', 'ള': 'ḷa', 'ഴ': 'ḻa', 'റ': 'ṟa',
    
    // Vowel signs
    'ാ': 'ā', 'ി': 'i', 'ീ': 'ī', 'ു': 'u', 'ൂ': 'ū',
    'ൃ': 'ṛ', 'െ': 'e', 'േ': 'ē', 'ൈ': 'ai', 'ൊ': 'o', 'ോ': 'ō', 'ൌ': 'au',
    
    // Special
    '്': '', 'ം': 'ṃ', 'ഃ': 'ḥ',
    
    ' ': ' '
  },

  // Latin to Malayalam mapping
  latin_to_malayalam: {
    // Vowels
    'a': 'അ', 'ā': 'ആ', 'aa': 'ആ', 'i': 'ഇ', 'ī': 'ഈ', 'ii': 'ഈ',
    'u': 'ഉ', 'ū': 'ഊ', 'uu': 'ഊ', 'ṛ': 'ഋ',
    'e': 'എ', 'ē': 'ഏ', 'ee': 'ഏ', 'ai': 'ഐ', 'o': 'ഒ', 'ō': 'ഓ', 'oo': 'ഓ', 'au': 'ഔ',
    
    // Consonants
    'ka': 'ക', 'kha': 'ഖ', 'ga': 'ഗ', 'gha': 'ഘ', 'ṅa': 'ങ', 'nga': 'ങ',
    'ca': 'ച', 'cha': 'ഛ', 'ja': 'ജ', 'jha': 'ഝ', 'ña': 'ഞ', 'nya': 'ഞ',
    'ṭa': 'ട', 'ṭha': 'ഠ', 'ḍa': 'ഡ', 'ḍha': 'ഢ', 'ṇa': 'ണ',
    'ta': 'ത', 'tha': 'ഥ', 'da': 'ദ', 'dha': 'ധ', 'na': 'ന',
    'pa': 'പ', 'pha': 'ഫ', 'ba': 'ബ', 'bha': 'ഭ', 'ma': 'മ',
    'ya': 'യ', 'ra': 'ര', 'la': 'ല', 'va': 'വ', 'wa': 'വ',
    'śa': 'ശ', 'sha': 'ശ', 'ṣa': 'ഷ', 'sa': 'സ', 'ha': 'ഹ',
    'ḷa': 'ള', 'ḻa': 'ഴ', 'ṟa': 'റ',
    
    // Single consonants
    'k': 'ക്', 'g': 'ഗ്', 'c': 'ച്', 'j': 'ജ്', 't': 'ത്', 'd': 'ദ്',
    'p': 'പ്', 'b': 'ബ്', 'm': 'മ്', 'n': 'ന്', 'r': 'ര്', 'l': 'ല്',
    'v': 'വ്', 'w': 'വ്', 's': 'സ്', 'h': 'ഹ്', 'y': 'യ്',
    
    // Special
    'ṃ': 'ം', 'ḥ': 'ഃ',
    
    ' ': ' ', '.': '.', ',': ',', '!': '!', '?': '?'
  },

  // Odia to Latin mapping
  odia_to_latin: {
    // Vowels
    'ଅ': 'a', 'ଆ': 'ā', 'ଇ': 'i', 'ଈ': 'ī', 'ଉ': 'u', 'ଊ': 'ū',
    'ଋ': 'ṛ', 'ଏ': 'e', 'ଐ': 'ai', 'ଓ': 'o', 'ଔ': 'au',
    
    // Consonants
    'କ': 'ka', 'ଖ': 'kha', 'ଗ': 'ga', 'ଘ': 'gha', 'ଙ': 'ṅa',
    'ଚ': 'ca', 'ଛ': 'cha', 'ଜ': 'ja', 'ଝ': 'jha', 'ଞ': 'ña',
    'ଟ': 'ṭa', 'ଠ': 'ṭha', 'ଡ': 'ḍa', 'ଢ': 'ḍha', 'ଣ': 'ṇa',
    'ତ': 'ta', 'ଥ': 'tha', 'ଦ': 'da', 'ଧ': 'dha', 'ନ': 'na',
    'ପ': 'pa', 'ଫ': 'pha', 'ବ': 'ba', 'ଭ': 'bha', 'ମ': 'ma',
    'ଯ': 'ya', 'ର': 'ra', 'ଲ': 'la', 'ଵ': 'va', 'ଶ': 'śa',
    'ଷ': 'ṣa', 'ସ': 'sa', 'ହ': 'ha', 'ଳ': 'ḷa',
    
    // Vowel signs
    'ା': 'ā', 'ି': 'i', 'ୀ': 'ī', 'ୁ': 'u', 'ୂ': 'ū',
    'ୃ': 'ṛ', 'େ': 'e', 'ୈ': 'ai', 'ୋ': 'o', 'ୌ': 'au',
    
    // Special
    '୍': '', 'ଂ': 'ṃ', 'ଃ': 'ḥ',
    
    // Numbers
    '୦': '0', '୧': '1', '୨': '2', '୩': '3', '୪': '4',
    '୫': '5', '୬': '6', '୭': '7', '୮': '8', '୯': '9',
    
    ' ': ' '
  },

  // Latin to Odia mapping
  latin_to_odia: {
    // Vowels
    'a': 'ଅ', 'ā': 'ଆ', 'aa': 'ଆ', 'i': 'ଇ', 'ī': 'ଈ', 'ii': 'ଈ',
    'u': 'ଉ', 'ū': 'ଊ', 'uu': 'ଊ', 'ṛ': 'ଋ',
    'e': 'ଏ', 'ai': 'ଐ', 'o': 'ଓ', 'au': 'ଔ',
    
    // Consonants
    'ka': 'କ', 'kha': 'ଖ', 'ga': 'ଗ', 'gha': 'ଘ', 'ṅa': 'ଙ', 'nga': 'ଙ',
    'ca': 'ଚ', 'cha': 'ଛ', 'ja': 'ଜ', 'jha': 'ଝ', 'ña': 'ଞ', 'nya': 'ଞ',
    'ṭa': 'ଟ', 'ṭha': 'ଠ', 'ḍa': 'ଡ', 'ḍha': 'ଢ', 'ṇa': 'ଣ',
    'ta': 'ତ', 'tha': 'ଥ', 'da': 'ଦ', 'dha': 'ଧ', 'na': 'ନ',
    'pa': 'ପ', 'pha': 'ଫ', 'ba': 'ବ', 'bha': 'ଭ', 'ma': 'ମ',
    'ya': 'ଯ', 'ra': 'ର', 'la': 'ଲ', 'va': 'ଵ', 'wa': 'ଵ',
    'śa': 'ଶ', 'sha': 'ଶ', 'ṣa': 'ଷ', 'sa': 'ସ', 'ha': 'ହ', 'ḷa': 'ଳ',
    
    // Single consonants
    'k': 'କ୍', 'g': 'ଗ୍', 'c': 'ଚ୍', 'j': 'ଜ୍', 't': 'ତ୍', 'd': 'ଦ୍',
    'p': 'ପ୍', 'b': 'ବ୍', 'm': 'ମ୍', 'n': 'ନ୍', 'r': 'ର୍', 'l': 'ଲ୍',
    'v': 'ଵ୍', 'w': 'ଵ୍', 's': 'ସ୍', 'h': 'ହ୍', 'y': 'ଯ୍',
    
    // Special
    'ṃ': 'ଂ', 'ḥ': 'ଃ',
    
    // Numbers
    '0': '୦', '1': '୧', '2': '୨', '3': '୩', '4': '୪',
    '5': '୫', '6': '୬', '7': '୭', '8': '୮', '9': '୯',
    
    ' ': ' ', '.': '.', ',': ',', '!': '!', '?': '?'
  },

  // Gurmukhi to Latin mapping
  gurmukhi_to_latin: {
    // Vowels
    'ਅ': 'a', 'ਆ': 'ā', 'ਇ': 'i', 'ਈ': 'ī', 'ਉ': 'u', 'ਊ': 'ū',
    'ਏ': 'e', 'ਐ': 'ai', 'ਓ': 'o', 'ਔ': 'au',
    
    // Consonants
    'ਕ': 'ka', 'ਖ': 'kha', 'ਗ': 'ga', 'ਘ': 'gha', 'ਙ': 'ṅa',
    'ਚ': 'ca', 'ਛ': 'cha', 'ਜ': 'ja', 'ਝ': 'jha', 'ਞ': 'ña',
    'ਟ': 'ṭa', 'ਠ': 'ṭha', 'ਡ': 'ḍa', 'ਢ': 'ḍha', 'ਣ': 'ṇa',
    'ਤ': 'ta', 'ਥ': 'tha', 'ਦ': 'da', 'ਧ': 'dha', 'ਨ': 'na',
    'ਪ': 'pa', 'ਫ': 'pha', 'ਬ': 'ba', 'ਭ': 'bha', 'ਮ': 'ma',
    'ਯ': 'ya', 'ਰ': 'ra', 'ਲ': 'la', 'ਵ': 'va', 'ਸ਼': 'śa',
    'ਸ': 'sa', 'ਹ': 'ha', 'ਲ਼': 'ḷa',
    
    // Vowel signs
    'ਾ': 'ā', 'ਿ': 'i', 'ੀ': 'ī', 'ੁ': 'u', 'ੂ': 'ū',
    'ੇ': 'e', 'ੈ': 'ai', 'ੋ': 'o', 'ੌ': 'au',
    
    // Special
    '੍': '', 'ਂ': 'ṃ', 'ਃ': 'ḥ',
    
    ' ': ' '
  },

  // Latin to Gurmukhi mapping
  latin_to_gurmukhi: {
    // Vowels
    'a': 'ਅ', 'ā': 'ਆ', 'aa': 'ਆ', 'i': 'ਇ', 'ī': 'ਈ', 'ii': 'ਈ',
    'u': 'ਉ', 'ū': 'ਊ', 'uu': 'ਊ',
    'e': 'ਏ', 'ai': 'ਐ', 'o': 'ਓ', 'au': 'ਔ',
    
    // Consonants
    'ka': 'ਕ', 'kha': 'ਖ', 'ga': 'ਗ', 'gha': 'ਘ', 'ṅa': 'ਙ', 'nga': 'ਙ',
    'ca': 'ਚ', 'cha': 'ਛ', 'ja': 'ਜ', 'jha': 'ਝ', 'ña': 'ਞ', 'nya': 'ਞ',
    'ṭa': 'ਟ', 'ṭha': 'ਠ', 'ḍa': 'ਡ', 'ḍha': 'ਢ', 'ṇa': 'ਣ',
    'ta': 'ਤ', 'tha': 'ਥ', 'da': 'ਦ', 'dha': 'ਧ', 'na': 'ਨ',
    'pa': 'ਪ', 'pha': 'ਫ', 'ba': 'ਬ', 'bha': 'ਭ', 'ma': 'ਮ',
    'ya': 'ਯ', 'ra': 'ਰ', 'la': 'ਲ', 'va': 'ਵ', 'wa': 'ਵ',
    'śa': 'ਸ਼', 'sha': 'ਸ਼', 'sa': 'ਸ', 'ha': 'ਹ', 'ḷa': 'ਲ਼',
    
    // Single consonants
    'k': 'ਕ੍', 'g': 'ਗ੍', 'c': 'ਚ੍', 'j': 'ਜ੍', 't': 'ਤ੍', 'd': 'ਦ੍',
    'p': 'ਪ੍', 'b': 'ਬ੍', 'm': 'ਮ੍', 'n': 'ਨ੍', 'r': 'ਰ੍', 'l': 'ਲ੍',
    'v': 'ਵ੍', 'w': 'ਵ੍', 's': 'ਸ੍', 'h': 'ਹ੍', 'y': 'ਯ੍',
    
    // Special
    'ṃ': 'ਂ', 'ḥ': 'ਃ',
    
    ' ': ' ', '.': '.', ',': ',', '!': '!', '?': '?'
  }
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
  
  try {
    // Use improved transliteration for complete script conversion
    return improvedTransliterate(text, fromScript, toScript);
  } catch (error) {
    console.error('Transliteration error:', error);
    return `Error during transliteration: ${error.message}`;
  }
};

/**
 * Transliterate text using a character mapping
 * @param {string} text - The text to transliterate
 * @param {Object} mapping - The character mapping object
 * @returns {string} - The transliterated text
 */
const transliterateWithMapping = (text, mapping) => {
  // Enhanced implementation to handle multi-character mappings
  let result = '';
  let i = 0;
  
  while (i < text.length) {
    let matched = false;
    
    // Try to match longer sequences first (up to 4 characters for complex ligatures)
    for (let len = 4; len >= 1; len--) {
      if (i + len <= text.length) {
        const substring = text.substring(i, i + len);
        if (mapping[substring] !== undefined) {
          result += mapping[substring];
          i += len;
          matched = true;
          break;
        }
      }
    }
    
    // If no mapping found, keep the original character
    if (!matched) {
      result += text[i];
      i++;
    }
  }
  
  return result;
};

/**
 * Enhanced word-level transliteration for better accuracy
 * @param {string} text - The text to transliterate
 * @param {string} fromScript - The source script
 * @param {string} toScript - The target script
 * @returns {string} - The transliterated text
 */
const transliterateWords = (text, fromScript, toScript) => {
  // Split text into words and transliterate each word
  const words = text.split(/(\s+)/); // Keep whitespace
  
  return words.map(word => {
    if (/^\s+$/.test(word)) {
      // Keep whitespace as is
      return word;
    }
    
    // For simple English words, handle them specially
    if (fromScript === 'latin' && /^[a-zA-Z]+$/.test(word)) {
      return transliterateEnglishWord(word, toScript);
    }
    
    // Use regular character mapping for other cases
    const mappingKey = `${fromScript}_to_${toScript}`;
    if (scriptMappings[mappingKey]) {
      return transliterateWithMapping(word, scriptMappings[mappingKey]);
    }
    
    // Try intermediate conversion through Latin
    const toLatinKey = `${fromScript}_to_latin`;
    const fromLatinKey = `latin_to_${toScript}`;
    
    if (scriptMappings[toLatinKey] && scriptMappings[fromLatinKey]) {
      const latinText = transliterateWithMapping(word, scriptMappings[toLatinKey]);
      return transliterateWithMapping(latinText, scriptMappings[fromLatinKey]);
    }
    
    return word; // Return original if no mapping found
  }).join('');
};

/**
 * Improved character-by-character transliteration with syllable awareness
 * @param {string} text - The text to transliterate
 * @param {string} fromScript - The source script
 * @param {string} toScript - The target script
 * @returns {string} - The transliterated text
 */
const improvedTransliterate = (text, fromScript, toScript) => {
  // Direct mapping if available
  const mappingKey = `${fromScript}_to_${toScript}`;
  if (scriptMappings[mappingKey]) {
    return transliterateWithMapping(text, scriptMappings[mappingKey]);
  }
  
  // For Latin to Indian scripts, use enhanced phonetic conversion
  if (fromScript === 'latin' && toScript !== 'latin') {
    return transliterateLatinToIndic(text, toScript);
  }
  
  // For Indian scripts to Latin
  if (fromScript !== 'latin' && toScript === 'latin') {
    const toLatinKey = `${fromScript}_to_latin`;
    if (scriptMappings[toLatinKey]) {
      return transliterateWithMapping(text, scriptMappings[toLatinKey]);
    }
  }
  
  // For Indian script to Indian script via Latin
  const toLatinKey = `${fromScript}_to_latin`;
  const fromLatinKey = `latin_to_${toScript}`;
  
  if (scriptMappings[toLatinKey] && scriptMappings[fromLatinKey]) {
    const latinText = transliterateWithMapping(text, scriptMappings[toLatinKey]);
    return transliterateLatinToIndic(latinText, toScript);
  }
  
  return text;
};

/**
 * Enhanced Latin to Indic script transliteration
 * @param {string} text - Latin text
 * @param {string} toScript - Target Indic script
 * @returns {string} - Transliterated text
 */
const transliterateLatinToIndic = (text, toScript) => {
  const fromLatinKey = `latin_to_${toScript}`;
  if (!scriptMappings[fromLatinKey]) {
    return text;
  }
  
  const mapping = scriptMappings[fromLatinKey];
  let result = '';
  let i = 0;
  
  while (i < text.length) {
    let matched = false;
    
    // Try to match longer sequences first (for complex consonants and vowels)
    for (let len = 4; len >= 1; len--) {
      if (i + len <= text.length) {
        const substring = text.substring(i, i + len);
        if (mapping[substring] !== undefined) {
          result += mapping[substring];
          i += len;
          matched = true;
          break;
        }
      }
    }
    
    // If no mapping found, try to convert individual characters
    if (!matched) {
      const char = text[i];
      
      // Handle individual vowels and consonants
      if (mapping[char]) {
        result += mapping[char];
      } else {
        // For unmapped characters, try basic phonetic conversion
        const phoneticChar = getPhoneticEquivalent(char);
        if (mapping[phoneticChar]) {
          result += mapping[phoneticChar];
        } else {
          result += char; // Keep original if no conversion possible
        }
      }
      i++;
    }
  }
  
  return result;
};

/**
 * Get phonetic equivalent for basic English characters
 * @param {string} char - Single character
 * @returns {string} - Phonetic equivalent
 */
const getPhoneticEquivalent = (char) => {
  const phoneticMap = {
    'a': 'a', 'e': 'e', 'i': 'i', 'o': 'o', 'u': 'u',
    'k': 'ka', 'g': 'ga', 'c': 'ka', 'j': 'ja',
    't': 'ta', 'd': 'da', 'p': 'pa', 'b': 'ba',
    'm': 'ma', 'n': 'na', 'r': 'ra', 'l': 'la',
    'v': 'va', 'w': 'va', 'y': 'ya', 's': 'sa',
    'h': 'ha', 'f': 'pha', 'z': 'ja'
  };
  
  return phoneticMap[char.toLowerCase()] || char;
};

/**
 * Transliterate English words to Indian scripts
 * @param {string} word - English word
 * @param {string} toScript - Target script
 * @returns {string} - Transliterated word
 */
const transliterateEnglishWord = (word, toScript) => {
  // Convert English word to phonetic representation
  const phoneticMapping = {
    'peace': 'pīsa',
    'love': 'lava',
    'hello': 'halō',
    'world': 'varḷḍa',
    'namaste': 'namastē',
    'welcome': 'velakama',
    'thank': 'thāṅka',
    'you': 'yū',
    'good': 'guḍa',
    'morning': 'mōrniṅga',
    'evening': 'īvaniṅga',
    'night': 'nāiṭa',
    'water': 'vāṭara',
    'food': 'fūḍa',
    'house': 'hausa',
    'family': 'phāmilī',
    'friend': 'phrenḍa',
    'book': 'buka',
    'school': 'skūla',
    'teacher': 'ṭīcara',
    'student': 'sṭūḍenṭa'
  };
  
  const lowerWord = word.toLowerCase();
  let phoneticWord = phoneticMapping[lowerWord];
  
  if (!phoneticWord) {
    // Simple phonetic conversion for unknown words
    phoneticWord = word.toLowerCase()
      .replace(/ch/g, 'ca')
      .replace(/sh/g, 'śa')
      .replace(/th/g, 'tha')
      .replace(/ph/g, 'pha')
      .replace(/gh/g, 'gha')
      .replace(/kh/g, 'kha')
      .replace(/ng/g, 'ṅga')
      .replace(/c/g, 'ka')
      .replace(/q/g, 'ka')
      .replace(/x/g, 'ksa')
      .replace(/z/g, 'ja');
  }
  
  // Now transliterate the phonetic representation
  const fromLatinKey = `latin_to_${toScript}`;
  if (scriptMappings[fromLatinKey]) {
    return transliterateWithMapping(phoneticWord, scriptMappings[fromLatinKey]);
  }
  
  return word; // Return original if no mapping
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
      { 
        logger: m => console.log(m),
        tessedit_pageseg_mode: Tesseract.PSM.SINGLE_BLOCK,
        tessedit_char_whitelist: undefined // Allow all characters
      }
    );
    
    return result.data.text;
  } catch (error) {
    console.error('OCR Error:', error);
    throw new Error('Failed to perform OCR on the image');
  }
};

/**
 * Enhanced OCR specifically optimized for sign boards and street signs
 * @param {Buffer} imageBuffer - The image buffer
 * @param {string} language - The language code for OCR
 * @param {Object} options - OCR options including sign board specific settings
 * @returns {Promise<Object>} - Object containing text and confidence
 */
const performEnhancedOCR = async (imageBuffer, language = 'eng', options = {}) => {
  try {
    console.log(`Performing enhanced OCR for sign board with language: ${language}`);
    
    const { isSignBoard = false, fromScript = 'latin' } = options;
    
    // Enhanced OCR settings for sign boards
    const ocrOptions = {
      logger: m => {
        if (m.status === 'recognizing text') {
          console.log(`OCR Progress: ${Math.round(m.progress * 100)}%`);
        }
      },
      // Page segmentation mode - treat image as single text block
      tessedit_pageseg_mode: isSignBoard ? Tesseract.PSM.SINGLE_BLOCK : Tesseract.PSM.AUTO,
      // OCR Engine mode - use LSTM neural network
      tessedit_ocr_engine_mode: Tesseract.OEM.LSTM_ONLY,
      // Preserve interword spaces
      preserve_interword_spaces: '1'
    };
    
    // Add script-specific character whitelisting for better accuracy
    if (isSignBoard) {
      const whitelist = getCharacterWhitelist(fromScript);
      if (whitelist) {
        ocrOptions.tessedit_char_whitelist = whitelist;
      }
    }
    
    const result = await Tesseract.recognize(
      imageBuffer,
      language,
      ocrOptions
    );
    
    const extractedText = result.data.text.trim();
    const confidence = result.data.confidence;
    
    console.log(`OCR completed with confidence: ${confidence}%`);
    console.log(`Extracted text: "${extractedText}"`);
    
    return {
      text: extractedText,
      confidence: confidence,
      words: result.data.words || [],
      lines: result.data.lines || []
    };
  } catch (error) {
    console.error('Enhanced OCR Error:', error);
    throw new Error(`Failed to perform enhanced OCR: ${error.message}`);
  }
};

/**
 * Get character whitelist for specific scripts to improve OCR accuracy
 * @param {string} script - The script name
 * @returns {string|null} - Character whitelist or null
 */
const getCharacterWhitelist = (script) => {
  const whitelists = {
    'devanagari': 'अआइईउऊऋएऐओऔकखगघङचछजझञटठडढणतथदधनपफबभमयरलवशषसहक्षज्ञ०१२३४५६७८९।॥ं्ःँ',
    'bengali': 'অআইঈউঊঋএঐওঔকখগঘঙচছজঝঞটঠডঢণতথদধনপফবভমযরলশষসহড়ঢ়য়০১২৩৪৫৆৭৮৯।',
    'tamil': 'அஆஇஈஉஊஎஏஐஒஓஔகஙசஞடணதநபமயரலவழளறன௦௧௨௩௪௫௬௭௮௯।',
    'telugu': 'అఆఇఈఉఊఋఎఏఐఒఓఔకఖగఘఙచఛజఝఞటఠడఢణతథదధనపఫబభమయరలవశషసహళ౦౧౨౩౪౫౬౭౮౯।',
    'gujarati': 'અઆઇઈઉઊઋએઐઓઔકખગઘઙચછજઝઞટઠડઢણતથદધનપફબભમયરલવશષસહળ૦૧૨૩૪૫૬૭૮૯।',
    'kannada': 'ಅಆಇಈಉಊಋಎಏಐಒಓಔಕಖಗಘಙಚಛಜಝಞಟಠಡಢಣತಥದಧನಪಫಬಭಮಯರಲವಶಷಸಹಳ೦೧೨೩೪೫೬೭೮೯।',
    'malayalam': 'അആഇഈഉഊഋഎഏഐഒഓഔകഖഗഘങചഛജഝഞടഠഡഢണതഥദധനപഫബഭമയരലവശഷസഹളഴറ।',
    'odia': 'ଅଆଇଈଉଊଋଏଐଓଔକଖଗଘଙଚଛଜଝଞଟଠଡଢଣତଥଦଧନପଫବଭମଯରଲଵଶଷସହଳ୦୧୨୩୪୫୬୭୮୯।',
    'gurmukhi': 'ਅਆਇਈਉਊਏਐਓਔਕਖਗਘਙਚਛਜਝਞਟਠਡਢਣਤਥਦਧਨਪਫਬਭਮਯਰਲਵਸ਼ਸਹਲ਼।',
    'latin': 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789.,!?;:"\'-()[]{}/@#$%^&*+=<>|\\~`'
  };
  
  return whitelists[script] || null;
};

/**
 * Clean and preprocess extracted text for better transliteration
 * @param {string} text - Raw extracted text
 * @param {string} script - Source script
 * @returns {string} - Cleaned text
 */
const cleanExtractedText = (text, script) => {
  if (!text) return '';
  
  let cleaned = text
    // Remove excessive whitespace
    .replace(/\s+/g, ' ')
    // Remove common OCR artifacts
    .replace(/[|\\]/g, '')
    // Remove isolated punctuation that might be OCR errors
    .replace(/\s+[.,;:!?]\s+/g, ' ')
    // Trim whitespace
    .trim();
  
  // Script-specific cleaning
  if (script === 'devanagari') {
    // Remove standalone virama that might be OCR errors
    cleaned = cleaned.replace(/\s्\s/g, ' ');
    // Fix common OCR mistakes in Devanagari
    cleaned = cleaned.replace(/।।/g, '॥'); // Double danda
  } else if (script === 'latin') {
    // Fix common English OCR mistakes
    cleaned = cleaned
      .replace(/\b0\b/g, 'O') // Zero to O
      .replace(/\b1\b/g, 'I') // One to I in context
      .replace(/rn/g, 'm') // Common OCR mistake
      .replace(/vv/g, 'w'); // Double v to w
  }
  
  return cleaned;
};

/**
 * Detect the script of the given text
 * @param {string} text - Text to analyze
 * @returns {string} - Detected script name
 */
const detectScript = (text) => {
  if (!text || text.trim().length === 0) {
    return 'latin';
  }
  
  // Unicode ranges for different scripts
  const scriptRanges = {
    'devanagari': /[\u0900-\u097F]/,
    'bengali': /[\u0980-\u09FF]/,
    'gujarati': /[\u0A80-\u0AFF]/,
    'gurmukhi': /[\u0A00-\u0A7F]/,
    'kannada': /[\u0C80-\u0CFF]/,
    'malayalam': /[\u0D00-\u0D7F]/,
    'odia': /[\u0B00-\u0B7F]/,
    'tamil': /[\u0B80-\u0BFF]/,
    'telugu': /[\u0C00-\u0C7F]/,
    'latin': /[a-zA-Z]/
  };
  
  // Count characters for each script
  const scriptCounts = {};
  let totalChars = 0;
  
  for (const [script, regex] of Object.entries(scriptRanges)) {
    const matches = text.match(regex);
    scriptCounts[script] = matches ? matches.length : 0;
    totalChars += scriptCounts[script];
  }
  
  // Find the script with the highest count
  let detectedScript = 'latin';
  let maxCount = 0;
  
  for (const [script, count] of Object.entries(scriptCounts)) {
    if (count > maxCount) {
      maxCount = count;
      detectedScript = script;
    }
  }
  
  // Return detected script if confidence is reasonable
  return maxCount > 0 ? detectedScript : 'latin';
};

/**
 * Map our script codes to Sanscript scheme names
 * @param {string} script - Our script code
 * @returns {string} - Sanscript scheme name
 */
const mapToSanscriptScheme = (script) => {
  const mapping = {
    'devanagari': 'devanagari',
    'bengali': 'bengali',
    'gujarati': 'gujarati',
    'gurmukhi': 'gurmukhi',
    'kannada': 'kannada',
    'malayalam': 'malayalam',
    'odia': 'oriya',
    'tamil': 'tamil',
    'telugu': 'telugu',
    'latin': 'iast' // International Alphabet of Sanskrit Transliteration
  };
  
  return mapping[script];
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
  performEnhancedOCR,
  cleanExtractedText,
  detectScript,
  mapScriptToTesseractLang,
  mapToSanscriptScheme
};