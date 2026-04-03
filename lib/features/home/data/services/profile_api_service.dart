import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:isharaapp/core/constants/strings.dart';
import 'package:isharaapp/core/error/api_error_parser.dart';
import 'package:isharaapp/core/error/exceptions.dart';
import 'package:isharaapp/core/storage/app_session_manager.dart';
import 'package:isharaapp/features/home/data/models/profile_user_model.dart';

class ProfileApiService {
  ProfileApiService({
    Dio? dio,
    AppSessionManager? sessionManager,
  })  : _dio = dio ?? Dio(BaseOptions(baseUrl: AppStrings.baseUrl)),
        _sessionManager = sessionManager ?? AppSessionManager();

  final Dio _dio;
  final AppSessionManager _sessionManager;

  Future<ProfileUserModel> getProfile() async {
    final response = await _authorizedGet('/api/profile');
    final json = _asMap(response.data);
    final user = _asMap(_asMap(json['data'])['user']);
    final profile = ProfileUserModel.fromJson(user);
    await saveProfileCache(profile);
    return profile;
  }

  Future<ProfileUserModel> updateName({
    required String firstName,
    required String lastName,
    String? email,
  }) async {
    final data = <String, dynamic>{
      'first_name': firstName.trim(),
      'last_name': lastName.trim(),
    };
    if (email != null && email.trim().isNotEmpty) {
      data['email'] = email.trim();
    }

    final response = await _authorizedPost(
      '/api/profile/update-name',
      data: data,
    );

    final json = _asMap(response.data);
    final user = _asMap(_asMap(json['data'])['user']);
    final profile = ProfileUserModel.fromJson(user);
    await saveProfileCache(profile);
    return profile;
  }

  Future<String> clearProgress() async {
    final response = await _authorizedDelete('/api/profile/clear-progress');
    final json = _asMap(response.data);
    return json['message']?.toString() ?? 'Progress cleared successfully.';
  }

  Future<String> logout() async {
    final response = await _authorizedPost('/api/logout');
    final json = _asMap(response.data);
    return json['message']?.toString() ?? 'Logged out successfully.';
  }

  Future<ProfileUserModel?> getCachedProfile() async {
    final raw = await _sessionManager.getProfileCache();
    if (raw == null || raw.isEmpty) {
      return null;
    }

    try {
      final decoded = jsonDecode(raw);
      if (decoded is Map<String, dynamic>) {
        return ProfileUserModel.fromJson(decoded);
      }
      if (decoded is Map) {
        return ProfileUserModel.fromJson(Map<String, dynamic>.from(decoded));
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  Future<void> saveProfileCache(ProfileUserModel user) async {
    await _sessionManager.setProfileCache(jsonEncode(user.toJson()));
  }

  Future<void> clearProfileCache() async {
    await _sessionManager.clearProfileCache();
  }

  Future<bool> isCachedProfileFresh({
    Duration maxAge = const Duration(minutes: 10),
  }) async {
    return _sessionManager.isProfileCacheFresh(maxAge);
  }

  Future<Response<dynamic>> _authorizedPost(
    String path, {
    Map<String, dynamic>? data,
  }) async {
    final token = await _sessionManager.getAuthToken();
    if (token == null || token.isEmpty) {
      throw const ServerException('User is not authenticated.');
    }

    final response = await _dio.post<dynamic>(
      path,
      data: data,
      options: Options(
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        validateStatus: (_) => true,
      ),
    );

    return _validateResponse(response);
  }

  Future<Response<dynamic>> _authorizedGet(String path) async {
    final token = await _sessionManager.getAuthToken();
    if (token == null || token.isEmpty) {
      throw const ServerException('User is not authenticated.');
    }

    final response = await _dio.get<dynamic>(
      path,
      options: Options(
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        validateStatus: (_) => true,
      ),
    );

    return _validateResponse(response);
  }

  Future<Response<dynamic>> _authorizedDelete(String path) async {
    final token = await _sessionManager.getAuthToken();
    if (token == null || token.isEmpty) {
      throw const ServerException('User is not authenticated.');
    }

    final response = await _dio.delete<dynamic>(
      path,
      options: Options(
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        validateStatus: (_) => true,
      ),
    );

    return _validateResponse(response);
  }

  Response<dynamic> _validateResponse(Response<dynamic> response) {
    final statusCode = response.statusCode ?? 500;
    final json = _asMap(response.data);

    if (statusCode < 200 || statusCode >= 300) {
      final message = ApiErrorParser.fromResponseBody(
        json,
        statusCode: statusCode,
      );
      throw ServerException(message);
    }

    return response;
  }

  Map<String, dynamic> _asMap(dynamic data) {
    if (data is Map<String, dynamic>) {
      return data;
    }

    if (data is Map) {
      return Map<String, dynamic>.from(data);
    }

    return <String, dynamic>{};
  }
}
