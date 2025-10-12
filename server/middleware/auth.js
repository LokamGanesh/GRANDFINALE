// Mock auth middleware for demo purposes
module.exports = function(req, res, next) {
  // Get token from header
  const token = req.header('x-auth-token');

  // For demo purposes, if token exists, create a mock user
  if (token) {
    req.user = {
      id: 'demo-user-123',
      email: 'demo@example.com'
    };
  }
  
  next();
};