# Transliterate Bharat

A comprehensive web application for Indian script transliteration, enabling seamless transformation of text between different Indian scripts with precision and ease.

## Features

- **Text Transliteration**: Convert text between various Indian scripts (Devanagari, Tamil, Telugu, Bengali, Gujarati, etc.)
- **Image Text Recognition**: Extract and transliterate text from images using OCR technology
- **Camera Capture**: Real-time text capture and transliteration using device camera
- **Multi-Language Support**: Support for multiple Indian languages and scripts
- **User Authentication**: Secure user registration and login system
- **History Tracking**: Keep track of your transliteration history
- **Responsive Design**: Works seamlessly on desktop, tablet, and mobile devices
- **Real-time Processing**: Instant transliteration with live preview
- **Completely Free**: All features and services are completely free to use

## Tech Stack

### Frontend
- **React.js** - Modern JavaScript library for building user interfaces
- **React Bootstrap** - Responsive UI component library
- **React Router** - Client-side routing for single-page application
- **Axios** - HTTP client for API requests
- **Font Awesome** - Beautiful icons and graphics

### Backend
- **Node.js** - JavaScript runtime environment
- **Express.js** - Fast, unopinionated web framework
- **Multer** - File upload handling for image processing
- **OCR Libraries** - Text extraction from images
- **CORS** - Cross-origin resource sharing middleware
- **Body Parser** - Parse incoming request bodies

## Quick Start

### Prerequisites
- Node.js (v14 or higher)
- npm or yarn package manager

### Installation & Setup

1. **Clone the Project**
   ```bash
   git clone https://github.com/LokamGanesh/projectSIH.git
   cd projectSIH
   ```

2. **Install All Dependencies**
   ```bash
   npm run install-all
   ```

3. **Start the Application**
   ```bash
   # Option 1: Use the desktop launcher (Windows)
   start-app.bat
   
   # Option 2: Use npm scripts
   npm start
   
   # Option 3: Start components separately
   npm run server  # Backend server on port 5000
   npm run client  # Frontend app on port 3000
   ```

4. **Create Desktop Shortcut (Windows)**
   ```bash
   npm run create-shortcut
   ```

5. **Access the Application**
   - Frontend: http://localhost:3000
   - Backend API: http://localhost:5000

## Project Structure

```
projectSIH/
├── client/                    # React frontend application
│   ├── public/                   # Static files
│   ├── src/
│   │   ├── components/           # React components
│   │   │   ├── auth/            # Authentication components
│   │   │   ├── layout/          # Navigation, Footer
│   │   │   ├── pages/           # Home, About pages
│   │   │   └── transliteration/ # Transliteration components
│   │   ├── context/             # React Context for state management
│   │   ├── utils/               # Utility functions and translations
│   │   ├── App.js               # Main App component
│   │   └── App.css              # Global styles
│   └── package.json
├── server/                     # Express backend server
│   ├── routes/                   # API route handlers
│   │   ├── transliteration.js   # Transliteration API endpoints
│   │   ├── user.js              # User authentication
│   │   └── users.js             # User management
│   ├── utils/                   # Server utilities
│   │   └── transliterator.js    # Transliteration logic
│   ├── server.js                # Main server file
│   └── package.json
├── start-app.bat              # Windows launcher script
├── create-desktop-shortcut.ps1 # Desktop shortcut creator
├── package.json               # Root package configuration
└── README.md                  # This file
```

## API Endpoints

### Transliteration
- `POST /api/transliteration/text` - Transliterate text between scripts
- `POST /api/transliteration/image` - Extract and transliterate text from images
- `GET /api/transliteration/languages` - Get supported languages and scripts
- `GET /api/transliteration/history/:userId` - Get user's transliteration history

### User Management
- `POST /api/users/register` - User registration
- `POST /api/users/login` - User authentication
- `GET /api/users/profile` - Get user profile
- `PUT /api/users/profile` - Update user profile

## Key Features Explained

### Text Transliteration
- Convert text between various Indian scripts including Devanagari, Tamil, Telugu, Bengali, Gujarati
- Real-time transliteration with live preview
- Support for multiple input methods and keyboard layouts
- Accurate script conversion with proper character mapping

### Image Text Recognition
- Upload images containing Indian script text
- Advanced OCR technology for text extraction
- Automatic transliteration of extracted text
- Support for various image formats (JPG, PNG, etc.)

### Camera Capture
- Real-time camera integration for text capture
- Instant text recognition and transliteration
- Mobile-friendly camera interface
- Process text directly from camera feed

### User Management & History
- Secure user registration and authentication
- Personal transliteration history tracking
- Save and manage frequently used translations
- User profile customization

## Desktop Integration

### Creating Desktop Shortcut
1. **Automatic Method:**
   ```bash
   npm run create-shortcut
   ```

2. **Manual Method:**
   - Right-click on `start-app.bat`
   - Select "Create shortcut"
   - Move shortcut to Desktop
   - Rename to "Transliterate Bharat"

### Launching the App
- Double-click the desktop icon
- The app will automatically start both backend and frontend
- Your default browser will open to http://localhost:3000

## Configuration

### Environment Variables (Optional)
Create a `.env` file in the `server` directory:
```env
PORT=5000
MONGODB_URI=mongodb://localhost:27017/transliterateBharat
NODE_ENV=development
```

### Customization
- **Colors & Themes**: Edit `client/src/App.css`
- **Transliteration Logic**: Modify `server/utils/transliterator.js`
- **Supported Languages**: Update `client/src/utils/translations.js`
- **UI Components**: Customize components in `client/src/components/`

## Highlights

### Completely Free
- No paid features or premium subscriptions
- All transliteration services are completely free
- No hidden costs or charges

### Advanced Technology
- Modern React-based user interface
- Real-time transliteration processing
- Advanced OCR for image text recognition
- Mobile-responsive design

### Fast Performance
- Optimized React components
- Efficient transliteration algorithms
- Minimal loading times
- Smooth user experience

### Cross-Platform
- Works on Windows, Mac, and Linux
- Responsive design for all screen sizes
- Desktop shortcut for easy access

## Contributing

We welcome contributions to improve Transliterate Bharat!

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Support

For support and inquiries:
- Email: support@transliteratebharat.com
- GitHub: Create an issue in the repository
- Documentation: Check the README and code comments
- Community: Join our discussions in GitHub Issues

## Acknowledgments

- Indian Language Technology Proliferation and Deployment Centre
- Ministry of Electronics and Information Technology, Government of India
- Open source transliteration libraries and contributors
- React and Node.js communities
- OCR technology providers
