import 'package:shared_preferences/shared_preferences.dart';

/// Storage Service for local data persistence
/// 
/// Handles:
/// - Auth tokens
/// - User preferences
/// - Cache data
class StorageService {
  static const String _keyAuthToken = 'auth_token';
  static const String _keyRefreshToken = 'refresh_token';
  static const String _keyUserId = 'user_id';
  static const String _keyUserData = 'user_data';
  static const String _keyOnboardingComplete = 'onboarding_complete';
  static const String _keyFcmToken = 'fcm_token';

  final SharedPreferences _prefs;

  StorageService(this._prefs);

  // Auth Tokens
  Future<void> saveAuthToken(String token) async {
    await _prefs.setString(_keyAuthToken, token);
  }

  Future<String?> getAuthToken() async {
    return _prefs.getString(_keyAuthToken);
  }

  Future<void> saveRefreshToken(String token) async {
    await _prefs.setString(_keyRefreshToken, token);
  }

  Future<String?> getRefreshToken() async {
    return _prefs.getString(_keyRefreshToken);
  }

  Future<void> clearAuthToken() async {
    await _prefs.remove(_keyAuthToken);
    await _prefs.remove(_keyRefreshToken);
  }

  Future<void> clearAllAuth() async {
    await _prefs.remove(_keyAuthToken);
    await _prefs.remove(_keyRefreshToken);
    await _prefs.remove(_keyUserId);
    await _prefs.remove(_keyUserData);
  }

  // User Data
  Future<void> saveUserId(String userId) async {
    await _prefs.setString(_keyUserId, userId);
  }

  Future<String?> getUserId() async {
    return _prefs.getString(_keyUserId);
  }

  Future<void> saveUserData(Map<String, dynamic> userData) async {
    await _prefs.setString(_keyUserData, userData.toString());
  }

  Future<Map<String, dynamic>?> getUserData() async {
    final data = _prefs.getString(_keyUserData);
    if (data == null) return null;
    // Note: In production, use json encoding/decoding
    // For now, this is a placeholder
    return {};
  }

  // Onboarding
  Future<void> setOnboardingComplete(bool complete) async {
    await _prefs.setBool(_keyOnboardingComplete, complete);
  }

  Future<bool> isOnboardingComplete() async {
    return _prefs.getBool(_keyOnboardingComplete) ?? false;
  }

  // FCM Token
  Future<void> saveFcmToken(String token) async {
    await _prefs.setString(_keyFcmToken, token);
  }

  Future<String?> getFcmToken() async {
    return _prefs.getString(_keyFcmToken);
  }

  // Generic Methods
  Future<void> saveString(String key, String value) async {
    await _prefs.setString(key, value);
  }

  Future<String?> getString(String key) async {
    return _prefs.getString(key);
  }

  Future<void> saveBool(String key, bool value) async {
    await _prefs.setBool(key, value);
  }

  Future<bool?> getBool(String key) async {
    return _prefs.getBool(key);
  }

  Future<void> saveInt(String key, int value) async {
    await _prefs.setInt(key, value);
  }

  Future<int?> getInt(String key) async {
    return _prefs.getInt(key);
  }

  Future<void> remove(String key) async {
    await _prefs.remove(key);
  }

  Future<void> clear() async {
    await _prefs.clear();
  }
}

