import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';
import '../models/shopping_item.dart';

/// Mock Firebase service for demo mode
/// This replaces Firebase functionality with local storage
class FirebaseService {
  static String? _currentUserId;
  static SharedPreferences? _prefs;

  /// Initialize the service
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    _currentUserId = 'demo_user_${DateTime.now().millisecondsSinceEpoch}';
  }

  /// Get current user ID
  static String? get currentUserId => _currentUserId;

  /// Save user data to local storage
  static Future<void> saveUser(User user) async {
    await init();
    final userJson = json.encode(user.toJson());
    await _prefs!.setString('demo_user_data', userJson);
  }

  /// Load user data from local storage
  static Future<User> loadUser() async {
    await init();
    final userJson = _prefs!.getString('demo_user_data');
    if (userJson != null) {
      final userMap = json.decode(userJson) as Map<String, dynamic>;
      return User.fromJson(userMap);
    }
    // Return default user if no data exists
    return const User(
      name: 'Demo User',
      email: 'demo@example.com',
      height: 170.0,
      weight: 70.0,
      age: 25,
      gender: 'Male',
      activityLevel: 'Moderate',
      goal: 'Maintain',
      avatar: '',
      loginCount: 1,
      lastLogin: '',
      completedGoals: 0,
      budget: 1000.0,
      notificationCount: 0,
    );
  }

  /// Check if user data exists
  static Future<bool> userDataExists() async {
    await init();
    return _prefs!.containsKey('demo_user_data');
  }

  /// Initialize user data if it doesn't exist
  static Future<void> initializeUserDataIfNeeded(User defaultUser) async {
    if (!await userDataExists()) {
      await saveUser(defaultUser);
    }
  }

  /// Clear all user data
  static Future<void> clearAllUserData() async {
    await init();
    await _prefs!.remove('demo_user_data');
  }

  /// Save favorites to local storage
  static Future<void> saveFavorites(List<String> favorites) async {
    await init();
    await _prefs!.setString('demo_favorites', json.encode(favorites));
  }

  /// Load favorites from local storage
  static Future<List<String>> loadFavorites() async {
    await init();
    final favoritesJson = _prefs!.getString('demo_favorites');
    if (favoritesJson != null) {
      final List<dynamic> favoritesList = json.decode(favoritesJson);
      return favoritesList.cast<String>();
    }
    return [];
  }

  /// Add to favorites
  static Future<void> addToFavorites(String productName) async {
    final favorites = await loadFavorites();
    if (!favorites.contains(productName)) {
      favorites.add(productName);
      await saveFavorites(favorites);
    }
  }

  /// Remove from favorites
  static Future<void> removeFromFavorites(String productName) async {
    final favorites = await loadFavorites();
    favorites.remove(productName);
    await saveFavorites(favorites);
  }

  /// Save shopping list to local storage
  static Future<void> saveShoppingList(List<ShoppingItem> items) async {
    await init();
    final itemsJson = json.encode(items.map((item) => item.toJson()).toList());
    await _prefs!.setString('demo_shopping_list', itemsJson);
  }

  /// Load shopping list from local storage
  static Future<List<ShoppingItem>> loadShoppingList() async {
    await init();
    final itemsJson = _prefs!.getString('demo_shopping_list');
    if (itemsJson != null) {
      final List<dynamic> itemsList = json.decode(itemsJson);
      return itemsList.map((json) => ShoppingItem.fromJson(json)).toList();
    }
    return [];
  }
}
