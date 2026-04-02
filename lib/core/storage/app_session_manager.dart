import 'package:shared_preferences/shared_preferences.dart';

class AppSessionManager {
  static const String onboardingSeenKey = 'onboarding_seen';
  static const String authTokenKey = 'auth_token';
  static const String profileCacheKey = 'profile_cache_json';
  static const String profileCacheTimestampKey = 'profile_cache_ts';

  Future<void> setOnboardingSeen() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(onboardingSeenKey, true);
  }

  Future<bool> isOnboardingSeen() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(onboardingSeenKey) ?? false;
  }

  Future<bool> hasAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(authTokenKey);
    return token != null && token.isNotEmpty;
  }

  Future<String?> getAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(authTokenKey);
  }

  Future<void> clearAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(authTokenKey);
  }

  Future<void> setProfileCache(String profileJson) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(profileCacheKey, profileJson);
    await prefs.setInt(
      profileCacheTimestampKey,
      DateTime.now().millisecondsSinceEpoch,
    );
  }

  Future<String?> getProfileCache() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(profileCacheKey);
  }

  Future<void> clearProfileCache() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(profileCacheKey);
    await prefs.remove(profileCacheTimestampKey);
  }

  Future<bool> isProfileCacheFresh(Duration maxAge) async {
    final prefs = await SharedPreferences.getInstance();
    final ts = prefs.getInt(profileCacheTimestampKey);
    if (ts == null) {
      return false;
    }

    final cachedAt = DateTime.fromMillisecondsSinceEpoch(ts);
    return DateTime.now().difference(cachedAt) <= maxAge;
  }
}
