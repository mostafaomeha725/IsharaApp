import 'package:shared_preferences/shared_preferences.dart';

class AppSessionManager {
  static const String onboardingSeenKey = 'onboarding_seen';
  static const String authTokenKey = 'auth_token';
  static const String profileCacheKey = 'profile_cache_json';
  static const String profileCacheTimestampKey = 'profile_cache_ts';
  static const String learnLevelsCacheKey = 'learn_levels_cache_json';
  static const String learnLevelsCacheTimestampKey = 'learn_levels_cache_ts';
  static const String practiceLevelsCacheKey = 'practice_levels_cache_json';
  static const String practiceLevelsCacheTimestampKey =
      'practice_levels_cache_ts';
  static const String testLevelsCacheKey = 'test_levels_cache_json';
  static const String testLevelsCacheTimestampKey = 'test_levels_cache_ts';

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

  Future<void> setLearnLevelsCache(String json) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(learnLevelsCacheKey, json);
    await prefs.setInt(
      learnLevelsCacheTimestampKey,
      DateTime.now().millisecondsSinceEpoch,
    );
  }

  Future<String?> getLearnLevelsCache() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(learnLevelsCacheKey);
  }

  Future<void> clearLearnLevelsCache() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(learnLevelsCacheKey);
    await prefs.remove(learnLevelsCacheTimestampKey);
  }

  Future<bool> isLearnLevelsCacheFresh(Duration maxAge) async {
    final prefs = await SharedPreferences.getInstance();
    final ts = prefs.getInt(learnLevelsCacheTimestampKey);
    if (ts == null) {
      return false;
    }

    final cachedAt = DateTime.fromMillisecondsSinceEpoch(ts);
    return DateTime.now().difference(cachedAt) <= maxAge;
  }

  Future<void> setPracticeLevelsCache(String json) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(practiceLevelsCacheKey, json);
    await prefs.setInt(
      practiceLevelsCacheTimestampKey,
      DateTime.now().millisecondsSinceEpoch,
    );
  }

  Future<String?> getPracticeLevelsCache() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(practiceLevelsCacheKey);
  }

  Future<void> clearPracticeLevelsCache() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(practiceLevelsCacheKey);
    await prefs.remove(practiceLevelsCacheTimestampKey);
  }

  Future<bool> isPracticeLevelsCacheFresh(Duration maxAge) async {
    final prefs = await SharedPreferences.getInstance();
    final ts = prefs.getInt(practiceLevelsCacheTimestampKey);
    if (ts == null) {
      return false;
    }

    final cachedAt = DateTime.fromMillisecondsSinceEpoch(ts);
    return DateTime.now().difference(cachedAt) <= maxAge;
  }

  Future<void> setTestLevelsCache(String json) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(testLevelsCacheKey, json);
    await prefs.setInt(
      testLevelsCacheTimestampKey,
      DateTime.now().millisecondsSinceEpoch,
    );
  }

  Future<String?> getTestLevelsCache() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(testLevelsCacheKey);
  }

  Future<void> clearTestLevelsCache() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(testLevelsCacheKey);
    await prefs.remove(testLevelsCacheTimestampKey);
  }

  Future<bool> isTestLevelsCacheFresh(Duration maxAge) async {
    final prefs = await SharedPreferences.getInstance();
    final ts = prefs.getInt(testLevelsCacheTimestampKey);
    if (ts == null) {
      return false;
    }

    final cachedAt = DateTime.fromMillisecondsSinceEpoch(ts);
    return DateTime.now().difference(cachedAt) <= maxAge;
  }

  Future<void> clearAllLearningProgressCaches() async {
    await clearLearnLevelsCache();
    await clearPracticeLevelsCache();
    await clearTestLevelsCache();
  }
}
