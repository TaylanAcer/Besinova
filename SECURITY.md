# Security Guidelines

## ⚠️ IMPORTANT SECURITY NOTICE

This project has been cleaned of exposed API keys and sensitive data. Please follow these security guidelines to maintain a secure codebase.

## What Was Fixed

1. **Removed exposed Google API key** from:
   - `lib/data/services/optimization_service.dart`
   - `lib/core/constants/api_keys.dart`

2. **Implemented secure configuration management**:
   - Created `lib/core/config/app_config.dart` for environment-based configuration
   - Updated `.gitignore` to prevent future exposure of sensitive files

## Setting Up API Keys Securely

### For Development

1. **Temporary setup** (for testing only):
   ```dart
   // In lib/core/constants/api_keys.dart
   static const String googlePlacesApiKey = 'your_actual_key_here';
   ```
   ⚠️ **REMOVE THE KEY BEFORE COMMITTING!**

2. **Recommended setup** (using environment variables):
   ```bash
   # Create .env file in project root
   echo "GOOGLE_PLACES_API_KEY=your_actual_key_here" > .env
   ```

   Then build with:
   ```bash
   flutter build apk --dart-define=GOOGLE_PLACES_API_KEY=your_actual_key_here
   ```

### For Production

Use environment variables or secure key management:

```bash
flutter build apk --dart-define=GOOGLE_PLACES_API_KEY=your_production_key
```

## Security Best Practices

### 1. Never Commit API Keys
- ❌ Never commit real API keys to version control
- ✅ Use environment variables or secure configuration
- ✅ Add sensitive files to `.gitignore`

### 2. API Key Restrictions
When setting up Google API keys:
- Restrict to your app's package name: `com.example.besinova`
- Add SHA-1 fingerprint for Android
- Enable only required APIs (Places API)
- Set up billing alerts

### 3. File Security
The following files are now protected by `.gitignore`:
- `.env*` files
- `*secrets*` files
- `*credentials*` files
- `google-services.json`
- `GoogleService-Info.plist`

### 4. Code Security
- All API keys are now loaded from environment variables
- Sensitive data is clearly marked in code
- Configuration is centralized in `AppConfig`

## Verification

To verify the project is clean:

```bash
# Search for potential API keys
grep -r "AIza" . --exclude-dir=build --exclude-dir=.git
grep -r "sk-" . --exclude-dir=build --exclude-dir=.git
grep -r "pk_" . --exclude-dir=build --exclude-dir=.git
```

## If You Accidentally Expose a Key

1. **Immediately revoke the key** in Google Cloud Console
2. **Generate a new key** with proper restrictions
3. **Update all references** to use the new key
4. **Force push** to remove the key from git history (if possible)
5. **Consider the old key compromised** and monitor for abuse

## Support

If you need help with security setup:
1. Check the `GOOGLE_PLACES_SETUP.md` file
2. Review the `AppConfig` class in `lib/core/config/app_config.dart`
3. Ensure your `.env` file is in `.gitignore`

Remember: Security is everyone's responsibility!
