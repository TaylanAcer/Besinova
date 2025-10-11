/// App configuration management
///
/// This file handles secure configuration loading for the application.
/// It supports both environment variables and fallback values for development.
class AppConfig {
  // Private constructor to prevent instantiation
  AppConfig._();

  /// Google Places API Key
  ///
  /// This will be loaded from environment variables in production.
  /// For development, you can set it here temporarily, but REMOVE before committing!
  static const String googlePlacesApiKey = String.fromEnvironment(
    'GOOGLE_PLACES_API_KEY',
    defaultValue: 'YOUR_GOOGLE_PLACES_API_KEY_HERE',
  );

  /// Server API Base URL
  static const String serverBaseUrl = String.fromEnvironment(
    'SERVER_BASE_URL',
    defaultValue: 'https://shopping-optimizer-api.onrender.com',
  );

  /// Debug mode flag
  static const bool isDebugMode =
      bool.fromEnvironment('DEBUG_MODE', defaultValue: false);

  /// Check if the API key is properly configured
  static bool get isApiKeyConfigured {
    return googlePlacesApiKey != 'YOUR_GOOGLE_PLACES_API_KEY_HERE' &&
        googlePlacesApiKey.isNotEmpty;
  }

  /// Get configuration status for debugging
  static Map<String, dynamic> getConfigStatus() {
    return {
      'api_key_configured': isApiKeyConfigured,
      'server_url': serverBaseUrl,
      'debug_mode': isDebugMode,
      'api_key_length': googlePlacesApiKey.length,
    };
  }
}
