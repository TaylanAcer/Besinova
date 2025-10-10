import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import '../../data/models/user.dart' as app_user;
import '../../data/services/firebase_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Provider for managing user state and data following industry standards
class UserProvider extends ChangeNotifier {
  // Private state variables
  app_user.User? _user;
  bool _isLoading = false;
  bool _isAuthenticated = false;
  String? _error;
  bool _hasSetBudget = false;

  // Public getters
  app_user.User? get user => _user;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _isAuthenticated;
  String? get error => _error;
  bool get hasSetBudget => _hasSetBudget;

  // User data getters - always return Firebase data or empty/zero if no data exists
  String get name => _user?.name ?? '';
  String get email => _user?.email ?? '';
  double get height => _user?.height ?? 0.0;
  double get weight => _user?.weight ?? 0.0;
  int get age => _user?.age ?? 0;
  String get gender => _user?.gender ?? '';
  String get activityLevel => _user?.activityLevel ?? '';
  String get goal => _user?.goal ?? '';
  String get avatar => _user?.avatar ?? '';
  int get loginCount => _user?.loginCount ?? 0;
  String get lastLogin => _user?.lastLogin ?? '';
  int get completedGoals => _user?.completedGoals ?? 0;
  double get budget => _user?.budget ?? 0.0;
  int get notificationCount => _user?.notificationCount ?? 0;

  /// Initialize the user provider and set up demo mode
  Future<void> initialize() async {
    print(
        'DEBUG: UserProvider.initialize() - Starting initialization in demo mode');

    // Initialize Firebase service (now mock)
    await FirebaseService.init();

    // Clear any cached local user data to ensure fresh data
    await clearLocalUserCache();

    // Load user data directly (demo mode)
    await _loadUserData();
  }

  /// Load user data from local storage (demo mode)
  Future<void> _loadUserData() async {
    print(
        'DEBUG: UserProvider._loadUserData() - Starting data load in demo mode');

    _setLoadingState(true);

    try {
      print(
          'DEBUG: UserProvider._loadUserData() - Loading user from local storage');

      // Try to load existing user data
      final loadedUser = await FirebaseService.loadUser();

      print(
          'DEBUG: UserProvider._loadUserData() - Successfully loaded user from local storage');
      print(
          'DEBUG: UserProvider._loadUserData() - Loaded user name: "${loadedUser.name}"');
      print(
          'DEBUG: UserProvider._loadUserData() - Loaded user email: "${loadedUser.email}"');
      print(
          'DEBUG: UserProvider._loadUserData() - Loaded user budget: ${loadedUser.budget}');

      // Load saved avatar from SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      final savedAvatar = prefs.getString('selected_avatar');
      print(
          'DEBUG: UserProvider._loadUserData() - Saved avatar from SharedPreferences: "$savedAvatar"');

      app_user.User finalUser = loadedUser;
      if (savedAvatar != null && savedAvatar.isNotEmpty) {
        finalUser = loadedUser.copyWith(avatar: savedAvatar);
        print(
            'DEBUG: UserProvider._loadUserData() - Applied saved avatar: $savedAvatar');
      }

      print(
          'DEBUG: UserProvider._loadUserData() - Setting authenticated state with final user');
      _setAuthenticatedState(finalUser);
    } catch (e) {
      print(
          'ERROR: UserProvider._loadUserData() - Failed to load user data: $e');
      _setError('Failed to load user data: $e');
    }
  }

  /// Save user data to local storage (demo mode)
  Future<void> _saveUserData(app_user.User user) async {
    print('DEBUG: UserProvider._saveUserData() - Starting save operation');
    print('DEBUG: UserProvider._saveUserData() - User to save: ${user.name}');
    print('DEBUG: UserProvider._saveUserData() - User budget: ${user.budget}');
    print(
        'DEBUG: UserProvider._saveUserData() - Current user ID: ${FirebaseService.currentUserId}');

    try {
      print(
          'DEBUG: UserProvider._saveUserData() - Calling FirebaseService.saveUser()');
      await FirebaseService.saveUser(user);
      print(
          'SUCCESS: UserProvider._saveUserData() - User data saved successfully to local storage');
    } catch (e) {
      print(
          'ERROR: UserProvider._saveUserData() - Failed to save user data to local storage: $e');
      print(
          'ERROR: UserProvider._saveUserData() - Error type: ${e.runtimeType}');
      print('ERROR: UserProvider._saveUserData() - Error details: $e');
      _setError('Failed to save user data: $e');
    }
  }

  /// Set authenticated state
  void _setAuthenticatedState(app_user.User user) {
    print(
        'DEBUG: UserProvider._setAuthenticatedState() - Setting authenticated state');
    print(
        'DEBUG: UserProvider._setAuthenticatedState() - User to set: ${user.name}');
    print(
        'DEBUG: UserProvider._setAuthenticatedState() - User budget: ${user.budget}');
    print(
        'DEBUG: UserProvider._setAuthenticatedState() - User height: ${user.height}');
    print(
        'DEBUG: UserProvider._setAuthenticatedState() - User weight: ${user.weight}');
    print(
        'DEBUG: UserProvider._setAuthenticatedState() - User age: ${user.age}');
    print(
        'DEBUG: UserProvider._setAuthenticatedState() - User gender: "${user.gender}"');
    print(
        'DEBUG: UserProvider._setAuthenticatedState() - User activityLevel: "${user.activityLevel}"');
    print(
        'DEBUG: UserProvider._setAuthenticatedState() - User goal: "${user.goal}"');

    _user = user;
    _isAuthenticated = true;
    _isLoading = false;
    _error = null;
    _hasSetBudget = user.budget > 0;

    print(
        'DEBUG: UserProvider._setAuthenticatedState() - State variables set:');
    print('  - _user: ${_user?.name}');
    print('  - _isAuthenticated: $_isAuthenticated');
    print('  - _isLoading: $_isLoading');
    print('  - _hasSetBudget: $_hasSetBudget');

    print(
        'DEBUG: UserProvider._setAuthenticatedState() - Calling notifyListeners()');
    notifyListeners();

    print(
        'DEBUG: UserProvider._setAuthenticatedState() - Authenticated state set successfully');
  }

  /// Set unauthenticated state
  void _setUnauthenticatedState() {
    print(
        'DEBUG: UserProvider._setUnauthenticatedState() - Setting unauthenticated state');
    print(
        'DEBUG: UserProvider._setUnauthenticatedState() - Previous user: ${_user?.name}');
    print(
        'DEBUG: UserProvider._setUnauthenticatedState() - Previous UID: ${FirebaseService.currentUserId}');

    _user = null;
    _isAuthenticated = false;
    _isLoading = false;
    _error = null;
    _hasSetBudget = false;

    print(
        'DEBUG: UserProvider._setUnauthenticatedState() - State variables cleared:');
    print('  - _user: ${_user?.name}');
    print('  - _isAuthenticated: $_isAuthenticated');
    print('  - _isLoading: $_isLoading');
    print('  - _hasSetBudget: $_hasSetBudget');

    print(
        'DEBUG: UserProvider._setUnauthenticatedState() - Calling notifyListeners()');
    notifyListeners();

    print(
        'DEBUG: UserProvider._setUnauthenticatedState() - Unauthenticated state set successfully');
  }

  /// Set loading state
  void _setLoadingState(bool loading) {
    _isLoading = loading;
    if (loading) {
      _error = null;
    }
    notifyListeners();
  }

  /// Set error state
  void _setError(String error) {
    _error = error;
    _isLoading = false;
    notifyListeners();
  }

  /// Clear error state
  void clearError() {
    _error = null;
    notifyListeners();
  }

  /// Create user data for new demo user
  Future<void> createUserForDemoUser(String name, String email) async {
    print(
        'DEBUG: UserProvider.createUserForDemoUser() - Creating demo user: $name, $email');

    final newUser = app_user.User(
      name: name,
      email: email,
      height: 0.0,
      weight: 0.0,
      age: 0,
      gender: '',
      activityLevel: '',
      goal: '',
      avatar: '',
      loginCount: 0,
      lastLogin: '',
      completedGoals: 0,
      budget: 0.0,
      notificationCount: 0,
    );

    await _saveUserData(newUser);
    _setAuthenticatedState(newUser);
  }

  /// Update user data
  Future<void> updateUser(app_user.User updatedUser) async {
    print('DEBUG: UserProvider.updateUser() - Starting update');
    print('DEBUG: UserProvider.updateUser() - Current user: ${_user?.name}');
    print(
        'DEBUG: UserProvider.updateUser() - Updated user: ${updatedUser.name}');
    print(
        'DEBUG: UserProvider.updateUser() - Updated budget: ${updatedUser.budget}');

    if (_user == null) {
      print('ERROR: UserProvider.updateUser() - No user data available');
      _setError('No user data available');
      return;
    }

    try {
      print(
          'DEBUG: UserProvider.updateUser() - Calling FirebaseService.saveUser()');
      await _saveUserData(updatedUser);

      print(
          'DEBUG: UserProvider.updateUser() - Firebase save successful, updating local state');
      _user = updatedUser;
      _hasSetBudget = updatedUser.budget > 0;

      // Clear any local cache to ensure we always use Firebase data
      await clearLocalUserCache();

      print(
          'DEBUG: UserProvider.updateUser() - Local state updated, notifying listeners');
      notifyListeners();

      print(
          'SUCCESS: UserProvider.updateUser() - User data updated successfully');
    } catch (e) {
      print(
          'ERROR: UserProvider.updateUser() - Failed to update user data: $e');
      _setError('Failed to update user data: $e');
    }
  }

  /// Update specific user field
  Future<void> updateUserField({
    String? name,
    String? email,
    double? height,
    double? weight,
    int? age,
    String? gender,
    String? activityLevel,
    String? goal,
    String? avatar,
    int? loginCount,
    String? lastLogin,
    int? completedGoals,
    double? budget,
    int? notificationCount,
  }) async {
    print('DEBUG: UserProvider.updateUserField() - Starting field update');
    print(
        'DEBUG: UserProvider.updateUserField() - Current user: ${_user?.name}');
    print('DEBUG: UserProvider.updateUserField() - Fields to update:');
    if (name != null) print('  - name: $name');
    if (email != null) print('  - email: $email');
    if (height != null) print('  - height: $height');
    if (weight != null) print('  - weight: $weight');
    if (age != null) print('  - age: $age');
    if (gender != null) print('  - gender: $gender');
    if (activityLevel != null) print('  - activityLevel: $activityLevel');
    if (goal != null) print('  - goal: $goal');
    if (avatar != null) print('  - avatar: $avatar');
    if (loginCount != null) print('  - loginCount: $loginCount');
    if (lastLogin != null) print('  - lastLogin: $lastLogin');
    if (completedGoals != null) print('  - completedGoals: $completedGoals');
    if (budget != null) print('  - budget: $budget');
    if (notificationCount != null) {
      print('  - notificationCount: $notificationCount');
    }

    if (_user == null) {
      print('ERROR: UserProvider.updateUserField() - No user data available');
      _setError('No user data available');
      return;
    }

    try {
      print(
          'DEBUG: UserProvider.updateUserField() - Creating updated user object');
      final updatedUser = _user!.copyWith(
        name: name ?? _user!.name,
        email: email ?? _user!.email,
        height: height ?? _user!.height,
        weight: weight ?? _user!.weight,
        age: age ?? _user!.age,
        gender: gender ?? _user!.gender,
        activityLevel: activityLevel ?? _user!.activityLevel,
        goal: goal ?? _user!.goal,
        avatar: avatar ?? _user!.avatar,
        loginCount: loginCount ?? _user!.loginCount,
        lastLogin: lastLogin ?? _user!.lastLogin,
        completedGoals: completedGoals ?? _user!.completedGoals,
        budget: budget ?? _user!.budget,
        notificationCount: notificationCount ?? _user!.notificationCount,
      );

      print(
          'DEBUG: UserProvider.updateUserField() - Updated user created, calling updateUser()');
      await updateUser(updatedUser);
      print(
          'SUCCESS: UserProvider.updateUserField() - Field update completed successfully');
    } catch (e) {
      print(
          'ERROR: UserProvider.updateUserField() - Failed to update field: $e');
      _setError('Failed to update field: $e');
    }
  }

  /// Update avatar
  Future<void> setAvatar(String newAvatar) async {
    print('DEBUG: UserProvider.setAvatar() - Setting avatar: $newAvatar');

    // Save to SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selected_avatar', newAvatar);

    await updateUserField(avatar: newAvatar);
  }

  /// Update name
  Future<void> setName(String newName) => updateUserField(name: newName);

  /// Update budget
  Future<void> setBudget(double newBudget) async {
    print('DEBUG: UserProvider.setBudget() - Starting budget update');
    print('DEBUG: UserProvider.setBudget() - New budget: $newBudget');
    print('DEBUG: UserProvider.setBudget() - Current user: ${_user?.name}');
    print('DEBUG: UserProvider.setBudget() - Current budget: ${_user?.budget}');

    _hasSetBudget = true;

    try {
      print('DEBUG: UserProvider.setBudget() - Calling updateUserField()');
      await updateUserField(budget: newBudget);
      print('SUCCESS: UserProvider.setBudget() - Budget updated successfully');
    } catch (e) {
      print('ERROR: UserProvider.setBudget() - Failed to update budget: $e');
      _setError('Failed to update budget: $e');
    }
  }

  /// Increment login count
  Future<void> incrementLoginCount() =>
      updateUserField(loginCount: loginCount + 1);

  /// Update last login time
  Future<void> updateLastLogin(String dateTime) =>
      updateUserField(lastLogin: dateTime);

  /// Increment completed goals
  Future<void> incrementCompletedGoals() =>
      updateUserField(completedGoals: completedGoals + 1);

  /// Sign out user (demo mode - just clear local state)
  Future<void> signOut() async {
    print(
        'DEBUG: UserProvider.signOut() - Starting sign out process in demo mode');
    print('DEBUG: UserProvider.signOut() - Current user: ${_user?.name}');
    print(
        'DEBUG: UserProvider.signOut() - Current UID: ${FirebaseService.currentUserId}');

    try {
      print('DEBUG: UserProvider.signOut() - Clearing local state');
      _setUnauthenticatedState();
      print('DEBUG: UserProvider.signOut() - Sign out completed successfully');
    } catch (e) {
      print('ERROR: UserProvider.signOut() - Failed to sign out: $e');
      _setError('Failed to sign out: $e');
    }
  }

  /// Clear all user data
  Future<void> clearUserData() async {
    print('DEBUG: UserProvider.clearUserData() - Clearing user data');

    try {
      await FirebaseService.clearAllUserData();
      _setUnauthenticatedState();
    } catch (e) {
      print(
          'ERROR: UserProvider.clearUserData() - Failed to clear user data: $e');
      _setError('Failed to clear user data: $e');
    }
  }

  /// Create default user
  app_user.User _createDefaultUser() => const app_user.User(
        name: 'Demo User',
        email: 'demo@example.com',
        height: 170.0,
        weight: 70.0,
        age: 25,
        gender: 'Male',
        activityLevel: 'Moderate',
        goal: 'Maintain',
        avatar: '',
        loginCount: 0,
        lastLogin: '',
        completedGoals: 0,
        budget: 1000.0,
        notificationCount: 0,
      );

  /// Retry loading user data (demo mode)
  Future<void> retryLoadUserData() async {
    print(
        'DEBUG: UserProvider.retryLoadUserData() - Retrying user data load in demo mode');
    await _loadUserData();
  }

  /// Test user data persistence
  Future<Map<String, dynamic>> testDataPersistence() async {
    print(
        'DEBUG: UserProvider.testDataPersistence() - Starting persistence test');

    if (_user == null) {
      return {'success': false, 'error': 'No user data available'};
    }

    try {
      // Save current user data
      final originalUser = _user!;
      print(
          'DEBUG: UserProvider.testDataPersistence() - Original user: ${originalUser.name}, budget: ${originalUser.budget}');

      await _saveUserData(originalUser);
      print(
          'DEBUG: UserProvider.testDataPersistence() - User data saved to Firebase');

      // Clear local state
      _user = null;
      _isAuthenticated = false;
      print('DEBUG: UserProvider.testDataPersistence() - Local state cleared');

      // Reload user data
      await _loadUserData();
      print('DEBUG: UserProvider.testDataPersistence() - User data reloaded');

      if (_user != null) {
        final success = _user!.name == originalUser.name &&
            _user!.budget == originalUser.budget &&
            _user!.height == originalUser.height &&
            _user!.weight == originalUser.weight;

        return {
          'success': success,
          'original': {
            'name': originalUser.name,
            'budget': originalUser.budget,
            'height': originalUser.height,
            'weight': originalUser.weight,
          },
          'loaded': {
            'name': _user!.name,
            'budget': _user!.budget,
            'height': _user!.height,
            'weight': _user!.weight,
          },
        };
      }

      return {'success': false, 'error': 'Failed to reload user data'};
    } catch (e) {
      print('ERROR: UserProvider.testDataPersistence() - Test failed: $e');
      return {'success': false, 'error': e.toString()};
    }
  }

  /// Check if user data exists in Firebase
  Future<bool> userDataExists() async {
    try {
      return await FirebaseService.userDataExists();
    } catch (e) {
      print(
          'ERROR: UserProvider.userDataExists() - Failed to check user data existence: $e');
      return false;
    }
  }

  /// Initialize user data if it doesn't exist
  Future<void> initializeUserDataIfNeeded(app_user.User defaultUser) async {
    try {
      await FirebaseService.initializeUserDataIfNeeded(defaultUser);
    } catch (e) {
      print(
          'ERROR: UserProvider.initializeUserDataIfNeeded() - Failed to initialize user data: $e');
      throw Exception('Failed to initialize user data: $e');
    }
  }

  /// Debug method to log current user state
  void logCurrentState() {
    print('DEBUG: UserProvider.logCurrentState() - Current state:');
    print('  - _isAuthenticated: $_isAuthenticated');
    print('  - _isLoading: $_isLoading');
    print('  - _error: $_error');
    print('  - _hasSetBudget: $_hasSetBudget');
    print('  - _user: ${_user?.name ?? "null"}');
    if (_user != null) {
      print('  - User details:');
      print('    - name: "${_user!.name}"');
      print('    - email: "${_user!.email}"');
      print('    - budget: ${_user!.budget}');
      print('    - height: ${_user!.height}');
      print('    - weight: ${_user!.weight}');
      print('    - age: ${_user!.age}');
      print('    - gender: "${_user!.gender}"');
      print('    - activityLevel: "${_user!.activityLevel}"');
      print('    - goal: "${_user!.goal}"');
    }
    print('  - Local storage current user: ${FirebaseService.currentUserId}');
  }

  /// Force refresh user data from local storage (demo mode)
  Future<void> refreshUserData() async {
    print(
        'DEBUG: UserProvider.refreshUserData() - Force refreshing user data from local storage');
    await _loadUserData();
  }

  /// Clear any cached local user data to ensure fresh Firebase data
  Future<void> clearLocalUserCache() async {
    print(
        'DEBUG: UserProvider.clearLocalUserCache() - Clearing local user cache');

    try {
      final prefs = await SharedPreferences.getInstance();

      // Clear all user-related local storage except avatar
      await prefs.remove(AppConstants.storageKeyName);
      await prefs.remove(AppConstants.storageKeyEmail);
      await prefs.remove(AppConstants.storageKeyHeight);
      await prefs.remove(AppConstants.storageKeyWeight);
      await prefs.remove(AppConstants.storageKeyAge);
      await prefs.remove(AppConstants.storageKeyGender);
      await prefs.remove(AppConstants.storageKeyActivityLevel);
      await prefs.remove(AppConstants.storageKeyGoal);
      await prefs.remove(AppConstants.storageKeyLoginCount);
      await prefs.remove(AppConstants.storageKeyLastLogin);
      await prefs.remove(AppConstants.storageKeyCompletedGoals);
      await prefs.remove(AppConstants.storageKeyBudget);
      await prefs.remove(AppConstants.storageKeyNotificationCount);

      print(
          'DEBUG: UserProvider.clearLocalUserCache() - Local user cache cleared');
    } catch (e) {
      print(
          'ERROR: UserProvider.clearLocalUserCache() - Failed to clear local cache: $e');
    }
  }

  /// Refresh user data when network connectivity is restored (demo mode)
  Future<void> refreshOnNetworkRestore() async {
    print(
        'DEBUG: UserProvider.refreshOnNetworkRestore() - Network restored, refreshing user data in demo mode');
    if (_isAuthenticated) {
      // Clear local cache and reload from local storage
      await clearLocalUserCache();
      await _loadUserData();
    }
  }

  /// Check if local data is accessible (demo mode)
  Future<bool> isFirebaseAccessible() async {
    try {
      // In demo mode, always return true
      return true;
    } catch (e) {
      print(
          'DEBUG: UserProvider.isFirebaseAccessible() - Local data not accessible: $e');
      return false;
    }
  }

  /// Get current data source status
  String get dataSourceStatus {
    if (_user == null) return 'No data available';
    if (_isLoading) return 'Loading from local storage...';
    if (_error != null) return 'Error loading from local storage';
    return 'Data from local storage (Demo Mode)';
  }
}
