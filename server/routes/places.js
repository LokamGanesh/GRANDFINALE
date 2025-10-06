const express = require('express');
const router = express.Router();

// Sample places data
const places = [
  {
    id: 1,
    name: 'Betla National Park',
    description: 'Famous wildlife sanctuary known for its elephants, tigers, and diverse flora and fauna',
    image: 'https://images.unsplash.com/photo-1564507592333-c60657eea523?ixlib=rb-4.0.3',
    rating: 4.8,
    location: 'Latehar District',
    category: 'Wildlife',
    coordinates: { lat: 23.8644, lng: 84.1956 },
    bestTimeToVisit: 'October to March',
    entryFee: 'Free',
    timings: '6:00 AM - 6:00 PM',
    facilities: ['Parking', 'Restrooms', 'Guide Services', 'Cafeteria'],
    highlights: ['Tiger Safari', 'Elephant Spotting', 'Bird Watching', 'Nature Trails']
  },
  {
    id: 2,
    name: 'Hundru Falls',
    description: 'Spectacular waterfall cascading from a height of 98 meters, surrounded by lush greenery',
    image: 'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?ixlib=rb-4.0.3',
    rating: 4.6,
    location: 'Ranchi',
    category: 'Waterfalls',
    coordinates: { lat: 23.4315, lng: 85.6012 },
    bestTimeToVisit: 'July to October',
    entryFee: 'Free',
    timings: '8:00 AM - 5:00 PM',
    facilities: ['Parking', 'Food Stalls', 'Photography Points'],
    highlights: ['Waterfall View', 'Rock Climbing', 'Photography', 'Picnic Spots']
  },
  {
    id: 3,
    name: 'Jagannath Temple',
    description: 'Ancient temple dedicated to Lord Jagannath, showcasing beautiful architecture and spiritual significance',
    image: 'https://images.unsplash.com/photo-1582510003544-4d00b7f74220?ixlib=rb-4.0.3',
    rating: 4.7,
    location: 'Ranchi',
    category: 'Religious',
    coordinates: { lat: 23.3441, lng: 85.3096 },
    bestTimeToVisit: 'All Year Round',
    entryFee: 'Free',
    timings: '5:00 AM - 9:00 PM',
    facilities: ['Parking', 'Prasad Counter', 'Shoe Storage'],
    highlights: ['Ancient Architecture', 'Religious Ceremonies', 'Peaceful Environment', 'Cultural Heritage']
  },
  {
    id: 4,
    name: 'Dassam Falls',
    description: 'Beautiful cascade waterfall formed by the Kanchi River, perfect for nature lovers',
    image: 'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?ixlib=rb-4.0.3',
    rating: 4.5,
    location: 'Taimara',
    category: 'Waterfalls',
    coordinates: { lat: 23.2833, lng: 85.5167 },
    bestTimeToVisit: 'July to December',
    entryFee: 'Free',
    timings: '7:00 AM - 6:00 PM',
    facilities: ['Parking', 'Local Guides', 'Refreshment Stalls'],
    highlights: ['Scenic Beauty', 'Swimming', 'Rock Formation', 'Nature Photography']
  },
  {
    id: 5,
    name: 'Patratu Valley',
    description: 'Picturesque valley offering panoramic views and serene environment for relaxation',
    image: 'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?ixlib=rb-4.0.3',
    rating: 4.4,
    location: 'Ramgarh',
    category: 'Scenic Views',
    coordinates: { lat: 23.6693, lng: 85.2072 },
    bestTimeToVisit: 'October to March',
    entryFee: 'Free',
    timings: '24 Hours',
    facilities: ['Viewpoints', 'Parking', 'Local Food'],
    highlights: ['Valley Views', 'Sunset Points', 'Photography', 'Peaceful Environment']
  },
  {
    id: 6,
    name: 'Netarhat',
    description: 'Hill station known as the "Queen of Chotanagpur" offering cool climate and scenic beauty',
    image: 'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?ixlib=rb-4.0.3',
    rating: 4.6,
    location: 'Latehar',
    category: 'Hill Stations',
    coordinates: { lat: 23.4667, lng: 84.2500 },
    bestTimeToVisit: 'October to April',
    entryFee: 'Free',
    timings: '24 Hours',
    facilities: ['Hotels', 'Restaurants', 'Trekking Guides'],
    highlights: ['Sunrise Views', 'Cool Climate', 'Forest Walks', 'Adventure Activities']
  }
];

// GET /api/places - Get all places with optional filtering
router.get('/', (req, res) => {
  try {
    const { category, location, rating, search } = req.query;
    let filteredPlaces = places;

    // Filter by category
    if (category) {
      filteredPlaces = filteredPlaces.filter(place => 
        place.category.toLowerCase() === category.toLowerCase()
      );
    }

    // Filter by location
    if (location) {
      filteredPlaces = filteredPlaces.filter(place => 
        place.location.toLowerCase().includes(location.toLowerCase())
      );
    }

    // Filter by minimum rating
    if (rating) {
      const minRating = parseFloat(rating);
      filteredPlaces = filteredPlaces.filter(place => place.rating >= minRating);
    }

    // Search in name and description
    if (search) {
      const searchTerm = search.toLowerCase();
      filteredPlaces = filteredPlaces.filter(place => 
        place.name.toLowerCase().includes(searchTerm) ||
        place.description.toLowerCase().includes(searchTerm) ||
        place.location.toLowerCase().includes(searchTerm)
      );
    }

    res.json({
      success: true,
      data: filteredPlaces,
      total: filteredPlaces.length,
      filters: { category, location, rating, search }
    });
  } catch (error) {
    res.status(500).json({
      success: false,
      message: 'Error fetching places',
      error: error.message
    });
  }
});

// GET /api/places/:id - Get specific place details
router.get('/:id', (req, res) => {
  try {
    const placeId = parseInt(req.params.id);
    const place = places.find(p => p.id === placeId);

    if (!place) {
      return res.status(404).json({
        success: false,
        message: 'Place not found'
      });
    }

    res.json({
      success: true,
      data: place
    });
  } catch (error) {
    res.status(500).json({
      success: false,
      message: 'Error fetching place details',
      error: error.message
    });
  }
});

// GET /api/places/categories - Get all available categories
router.get('/meta/categories', (req, res) => {
  try {
    const categories = [...new Set(places.map(place => place.category))];
    
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

// GET /api/places/locations - Get all available locations
router.get('/meta/locations', (req, res) => {
  try {
    const locations = [...new Set(places.map(place => place.location))];
    
    res.json({
      success: true,
      data: locations
    });
  } catch (error) {
    res.status(500).json({
      success: false,
      message: 'Error fetching locations',
      error: error.message
    });
  }
});

// GET /api/places/featured - Get featured places (top rated)
router.get('/meta/featured', (req, res) => {
  try {
    const featuredPlaces = places
      .sort((a, b) => b.rating - a.rating)
      .slice(0, 4);
    
    res.json({
      success: true,
      data: featuredPlaces
    });
  } catch (error) {
    res.status(500).json({
      success: false,
      message: 'Error fetching featured places',
      error: error.message
    });
  }
});

module.exports = router;
