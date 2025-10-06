const express = require('express');
const router = express.Router();

// Sample tourism data
const tourismStats = {
  touristPlaces: 50,
  averageRating: 4.8,
  happyTravelers: 10000,
  verifiedTravels: 200
};

const experiences = [
  {
    id: 1,
    title: 'Wildlife Safari',
    description: 'Experience the thrill of spotting elephants, tigers, and other wildlife in their natural habitat',
    duration: '3 hours',
    price: 'Free',
    image: 'https://images.unsplash.com/photo-1564507592333-c60657eea523?ixlib=rb-4.0.3',
    category: 'Wildlife',
    location: 'Betla National Park'
  },
  {
    id: 2,
    title: 'Tribal Culture Tour',
    description: 'Discover the rich tribal heritage and traditions of Jharkhand with local guides',
    duration: '4 hours',
    price: 'Free',
    image: 'https://images.unsplash.com/photo-1582510003544-4d00b7f74220?ixlib=rb-4.0.3',
    category: 'Cultural',
    location: 'Various Villages'
  },
  {
    id: 3,
    title: 'Nature Photography Walk',
    description: 'Capture the stunning landscapes and wildlife with expert photography guidance',
    duration: '2 hours',
    price: 'Free',
    image: 'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?ixlib=rb-4.0.3',
    category: 'Photography',
    location: 'Hundru Falls'
  },
  {
    id: 4,
    title: 'Waterfall Trekking',
    description: 'Adventure trek to discover hidden waterfalls and scenic viewpoints',
    duration: '5 hours',
    price: 'Free',
    image: 'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?ixlib=rb-4.0.3',
    category: 'Adventure',
    location: 'Dassam Falls'
  }
];

// GET /api/tourism/stats - Get tourism statistics
router.get('/stats', (req, res) => {
  try {
    res.json({
      success: true,
      data: tourismStats
    });
  } catch (error) {
    res.status(500).json({
      success: false,
      message: 'Error fetching tourism stats',
      error: error.message
    });
  }
});

// GET /api/tourism/experiences - Get all experiences
router.get('/experiences', (req, res) => {
  try {
    const { category, location } = req.query;
    let filteredExperiences = experiences;

    if (category) {
      filteredExperiences = filteredExperiences.filter(exp => 
        exp.category.toLowerCase() === category.toLowerCase()
      );
    }

    if (location) {
      filteredExperiences = filteredExperiences.filter(exp => 
        exp.location.toLowerCase().includes(location.toLowerCase())
      );
    }

    res.json({
      success: true,
      data: filteredExperiences,
      total: filteredExperiences.length
    });
  } catch (error) {
    res.status(500).json({
      success: false,
      message: 'Error fetching experiences',
      error: error.message
    });
  }
});

// GET /api/tourism/experiences/:id - Get specific experience
router.get('/experiences/:id', (req, res) => {
  try {
    const experienceId = parseInt(req.params.id);
    const experience = experiences.find(exp => exp.id === experienceId);

    if (!experience) {
      return res.status(404).json({
        success: false,
        message: 'Experience not found'
      });
    }

    res.json({
      success: true,
      data: experience
    });
  } catch (error) {
    res.status(500).json({
      success: false,
      message: 'Error fetching experience',
      error: error.message
    });
  }
});

// POST /api/tourism/contact - Handle contact form submissions
router.post('/contact', (req, res) => {
  try {
    const { name, email, subject, message } = req.body;

    // Validate required fields
    if (!name || !email || !subject || !message) {
      return res.status(400).json({
        success: false,
        message: 'All fields are required'
      });
    }

    // In a real app, you would save this to a database or send an email
    console.log('Contact form submission:', { name, email, subject, message });

    res.json({
      success: true,
      message: 'Thank you for your message! We will get back to you soon.'
    });
  } catch (error) {
    res.status(500).json({
      success: false,
      message: 'Error processing contact form',
      error: error.message
    });
  }
});

// GET /api/tourism/categories - Get experience categories
router.get('/categories', (req, res) => {
  try {
    const categories = [...new Set(experiences.map(exp => exp.category))];
    
    res.json({
      success: true,
      data: categories
    });
  } catch (error) {
    res.status(500).json({
      success: false,
      message: 'Error fetching categories',
      error: error.message
    });
  }
});

module.exports = router;
