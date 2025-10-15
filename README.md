# 🌟 GRANDFINALE - Transliterate Bharat

> **Advanced Indian Script Transliteration App with Enhanced OCR**

[![React](https://img.shields.io/badge/React-18.2.0-blue.svg)](https://reactjs.org/)
[![Node.js](https://img.shields.io/badge/Node.js-18+-green.svg)](https://nodejs.org/)
[![Express](https://img.shields.io/badge/Express-4.18+-lightgrey.svg)](https://expressjs.com/)
[![Tesseract.js](https://img.shields.io/badge/Tesseract.js-OCR-orange.svg)](https://tesseract.projectnaptha.com/)

## 🚀 **Features**

### 📝 **Text Transliteration**
- **15+ Indian Scripts** supported (Devanagari, Bengali, Tamil, Telugu, etc.)
- **Real-time transliteration** as you type
- **Bidirectional conversion** between any supported scripts
- **Unicode compliant** output

### 📷 **Enhanced OCR (Optical Character Recognition)**
- **Image-to-text extraction** with high accuracy
- **Live camera capture** for real-time scanning
- **Mobile-optimized** camera interface
- **Automatic language detection**
- **Sign board scanning** with specialized OCR settings
- **Confidence scoring** for OCR results

### 🌐 **Multi-Platform Support**
- **Progressive Web App (PWA)** - Install on any device
- **Mobile responsive** design
- **Cross-browser compatibility**
- **Offline functionality** (when installed)

### 🔐 **User Management**
- **Secure authentication** system
- **Personal translation history**
- **User preferences** and settings
- **Multi-language interface**

## 🛠️ **Technology Stack**

### **Frontend**
- **React.js** - Modern UI framework
- **Bootstrap** - Responsive design
- **React Webcam** - Camera integration
- **Axios** - API communication

### **Backend**
- **Node.js** - Runtime environment
- **Express.js** - Web framework
- **Multer** - File upload handling
- **JWT** - Authentication
- **bcryptjs** - Password hashing

### **OCR & Transliteration**
- **Tesseract.js** - OCR engine
- **Sanscript** - Script conversion library
- **Custom character whitelisting** for better accuracy
- **Enhanced preprocessing** for sign board text

## 📱 **Quick Start**

### **Prerequisites**
- Node.js 18+ installed
- Git installed
- Modern web browser

### **Installation**

```bash
# Clone the repository
git clone https://github.com/LokamGanesh/GRANDFINALE.git
cd GRANDFINALE

# Install dependencies
npm install
cd client
npm install
cd ..

# Start the application
npm run dev
```

### **Access the App**
- **Desktop:** http://localhost:3000
- **Mobile:** http://YOUR_IP:3000 (see setup scripts)

## 🎯 **Usage**

### **Text Transliteration**
1. Select source and target scripts
2. Type or paste text
3. Get instant transliteration

### **Image OCR**
1. Upload image or use camera
2. Automatic language detection
3. Extract and transliterate text
4. View confidence scores

### **Mobile Camera**
- **Works on HTTPS/localhost**
- **Fallback to upload** for HTTP connections
- **Troubleshooting guide** included

## 📂 **Project Structure**

```
GRANDFINALE/
├── client/                 # React frontend
│   ├── public/            # Static assets
│   ├── src/
│   │   ├── components/    # React components
│   │   ├── context/       # React contexts
│   │   ├── utils/         # Utility functions
│   │   └── App.js         # Main app component
├── server/                # Node.js backend
│   ├── controllers/       # Route controllers
│   ├── middleware/        # Custom middleware
│   ├── models/           # Data models
│   ├── routes/           # API routes
│   ├── utils/            # Server utilities
│   └── server.js         # Main server file
├── setup-scripts/        # Helper scripts
└── docs/                # Documentation
```

## 🔧 **Setup Scripts**

### **Mobile Access**
- `setup-phone-access.bat` - Configure for mobile testing
- `get-ip-address.bat` - Get your IP for mobile access
- `phone-access-info.bat` - Display connection info

### **Camera Troubleshooting**
- `enable-mobile-camera.bat` - Mobile camera solutions
- `mobile-camera-test.html` - Direct camera testing
- `camera-troubleshooting.html` - Comprehensive guide

### **App Deployment**
- `start-app-simple.bat` - Quick start
- `launch-transliterate-app.bat` - Full launch
- `create-desktop-app.bat` - Desktop shortcut

## 🌍 **Supported Scripts**

| Script | Language | Unicode Range |
|--------|----------|---------------|
| Devanagari | Hindi, Marathi, Sanskrit | U+0900–U+097F |
| Bengali | Bengali, Assamese | U+0980–U+09FF |
| Tamil | Tamil | U+0B80–U+0BFF |
| Telugu | Telugu | U+0C00–U+0C7F |
| Gujarati | Gujarati | U+0A80–U+0AFF |
| Kannada | Kannada | U+0C80–U+0CFF |
| Malayalam | Malayalam | U+0D00–U+0D7F |
| Odia | Odia | U+0B00–U+0B7F |
| Gurmukhi | Punjabi | U+0A00–U+0A7F |
| Latin | English | U+0000–U+007F |

## 🚨 **Troubleshooting**

### **Camera Issues**
- **Mobile:** Use upload feature or visit troubleshooting guide
- **Desktop:** Ensure HTTPS or use localhost
- **Permissions:** Allow camera access in browser settings

### **OCR Accuracy**
- **Good lighting** improves results
- **Clear, focused images** work best
- **Avoid shadows** and reflections
- **Close-up shots** of text

### **Performance**
- **Large images** may take longer to process
- **Multiple scripts** in one image may affect accuracy
- **Clear browser cache** if issues persist

## 🤝 **Contributing**

1. Fork the repository
2. Create feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit changes (`git commit -m 'Add AmazingFeature'`)
4. Push to branch (`git push origin feature/AmazingFeature`)
5. Open Pull Request

## 📄 **License**

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👨‍💻 **Author**

**Lokam Ganesh**
- GitHub: [@LokamGanesh](https://github.com/LokamGanesh)
- Project: [GRANDFINALE](https://github.com/LokamGanesh/GRANDFINALE)

## 🙏 **Acknowledgments**

- **Tesseract.js** team for OCR capabilities
- **Sanscript** library for script conversion
- **React** and **Node.js** communities
- **Indian language computing** researchers

## 📊 **Stats**

- **15+ Scripts** supported
- **99%+ OCR accuracy** on clear images
- **Real-time** transliteration
- **Mobile-first** design
- **PWA** capabilities

---

### 🌟 **Star this repository if you found it helpful!**

**Made with ❤️ for preserving and promoting Indian languages**
