# Jharkhand Tourism App

A comprehensive web application showcasing the natural beauty, rich cultural heritage, and diverse wildlife of Jharkhand - the Land of Forests.

## Features

- **Tourist Places**: Explore 50+ beautiful destinations across Jharkhand
- **Experiences**: Discover unique cultural and adventure experiences
- **Photo Gallery**: Browse stunning photography of landscapes and wildlife
- **Responsive Design**: Works seamlessly on desktop, tablet, and mobile devices
- **Completely Free**: All features and services are completely free to use
- **Smart Search**: Find places by name, location, or category
- **Ratings & Reviews**: See ratings and detailed information for each destination
- **Interactive Maps**: Get location details and coordinates
- **Contact Support**: Easy contact form for inquiries and support

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
- **MongoDB** - NoSQL database (optional - works with in-memory data)
- **CORS** - Cross-origin resource sharing middleware
- **Body Parser** - Parse incoming request bodies

## Quick Start

### Prerequisites
- Node.js (v14 or higher)
- npm or yarn package manager

### Installation & Setup

1. **Clone or Download the Project**
   ```bash
   cd transliterateAPP
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
transliterateAPP/
├── client/                    # React frontend application
│   ├── public/                   # Static files
│   ├── src/
│   │   ├── components/           # React components
│   │   │   ├── layout/          # Navigation, Footer
│   │   │   └── pages/           # Home, Places, Gallery, etc.
│   │   ├── context/             # React Context for state management
│   │   ├── App.js               # Main App component
│   │   └── App.css              # Global styles
│   └── package.json
├── server/                     # Express backend server
│   ├── routes/                   # API route handlers
│   │   ├── tourism.js           # tourism stats and experiences
│   │   └── places.js            # Tourist places data
│   ├── server.js                # Main server file
│   └── package.json
├── start-app.bat              # Windows launcher script
├── create-desktop-shortcut.ps1 # Desktop shortcut creator
├── package.json               # Root package configuration
└── README.md                  # This file
```

## API Endpoints

### Tourism Information
- `GET /api/tourism/stats` - Get tourism statistics
- `GET /api/tourism/experiences` - Get all experiences
- `GET /api/tourism/experiences/:id` - Get specific experience
- `POST /api/tourism/contact` - Submit contact form
- `GET /api/tourism/categories` - Get experience categories

### Places Information
- `GET /api/places` - Get all places (with filtering)
- `GET /api/places/:id` - Get specific place details
- `GET /api/places/meta/categories` - Get place categories
- `GET /api/places/meta/locations` - Get all locations
- `GET /api/places/meta/featured` - Get featured places

## Key Features Explained

### Tourist Places
- Browse 50+ destinations including Betla National Park, Hundru Falls, Jagannath Temple
- Filter by category (Wildlife, Waterfalls, Religious, Hill Stations)
- Search by name, location, or description
- View detailed information including timings, facilities, and highlights

### Experiences
- Wildlife safaris and Nature photography
- Tribal culture tours and heritage walks
- Adventure activities and trekking
- All experiences are completely free

### Photo Gallery
- High-quality photos of Jharkhand's natural beauty
- Interactive image viewer with descriptions
- Categories include wildlife, waterfalls, temples, and landscapes

### Contact & Support
- Easy-to-use contact form
- Multiple contact methods (phone, email, address)
- Social media integration
- Responsive customer support

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
   - Rename to "Jharkhand Tourism"

### Launching the App
- Double-click the desktop icon
- The app will automatically start both backend and frontend
- Your default browser will open to http://localhost:3000

## Configuration

### Environment Variables (Optional)
Create a `.env` file in the `server` directory:
```env
PORT=5000
MONGODB_URI=mongodb://localhost:27017/jharkhandTourism
NODE_ENV=development
```

### Customization
- **Colors & Themes**: Edit `client/src/App.css`
- **Tourist Places**: Modify `server/routes/places.js`
- **Experiences**: Update `server/routes/tourism.js`
- **Images**: Replace image URLs with local assets

## Highlights

### Completely Free
- No paid features or premium subscriptions
- All tourist information and experiences are free
- No hidden costs or charges

### Beautiful Design
- Modern, responsive UI matching the provided design
- Stunning hero section with statistics
- Professional color scheme and typography
- Mobile-friendly interface

### Fast Performance
- Optimized React components
- Efficient API endpoints
- Minimal loading times
- Smooth user experience

### Cross-Platform
- Works on Windows, Mac, and Linux
- Responsive design for all screen sizes
- Desktop shortcut for easy access

## Contributing

We welcome contributions to improve the Jharkhand Tourism App!

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Support

For support and inquiries:
- Email: info@jharkhandtourism.gov.in
- Phone: +91 651 2446441
- Website: Create an issue in the repository
- Hours: Monday-Friday, 9:00 AM - 6:00 PM

## Acknowledgments

- Jharkhand Tourism Development Corporation
- Forest Department of Jharkhand
- Photography contributors
- Open source community
- UI/UX design inspiration
