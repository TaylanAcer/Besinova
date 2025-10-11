/// API Keys configuration
/// 
/// ⚠️  SECURITY NOTICE: This file should NEVER contain real API keys!
/// 
/// To set up your Google Places API key securely:
/// 1. Create a .env file in your project root
/// 2. Add: GOOGLE_PLACES_API_KEY=your_actual_api_key_here
/// 3. Add .env to your .gitignore file
/// 4. Use environment variables in production
/// 
/// For development, you can temporarily set the key here, but REMOVE IT before committing!
class ApiKeys {
  /// Google Places API Key
  /// This should be loaded from environment variables in production
  /// For development, set your key here temporarily, then remove before committing
  static const String googlePlacesApiKey = 'YOUR_GOOGLE_PLACES_API_KEY_HERE';
  
  /// Other API keys can be added here
  /// static const String otherApiKey = 'YOUR_OTHER_API_KEY';
}
