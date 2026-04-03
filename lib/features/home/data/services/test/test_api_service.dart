import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:isharaapp/core/constants/strings.dart';
import 'package:isharaapp/core/error/api_error_parser.dart';
import 'package:isharaapp/core/error/exceptions.dart';
import 'package:isharaapp/core/storage/app_session_manager.dart';
import 'package:isharaapp/features/home/data/models/test/test_level_model.dart';

class TestApiService {
  static const Duration _cacheMaxAge = Duration(minutes: 15);

  TestApiService({
    Dio? dio,
    AppSessionManager? sessionManager,
  })  : _dio = dio ?? Dio(BaseOptions(baseUrl: AppStrings.baseUrl)),
        _sessionManager = sessionManager ?? AppSessionManager();

  final Dio _dio;
  final AppSessionManager _sessionManager;

  Future<List<TestLevelModel>> getLevels() async {
    final cached = await _readCachedLevels();
    if (cached.isNotEmpty) {
      return cached;
    }

    final response = await _authorizedGet('/api/test/levels');
    final json = _asMap(response.data);

    final levelsNode = _extractLevelsNode(json);

    if (levelsNode is List) {
      final levels = levelsNode
          .whereType<Map>()
          .map((item) =>
              TestLevelModel.fromJson(Map<String, dynamic>.from(item)))
          .toList();

      await _sessionManager.setTestLevelsCache(
        jsonEncode(levels.map((item) => item.toJson()).toList()),
      );

      return levels;
    }

    return const <TestLevelModel>[];
  }

  dynamic _extractLevelsNode(Map<String, dynamic> json) {
    final data = json['data'];

    if (data is List) {
      return data;
    }

    if (data is Map) {
      final dataMap = _asMap(data);
      return dataMap['levels'] ??
          dataMap['test_levels'] ??
          dataMap['items'] ??
          dataMap['results'];
    }

    return json['levels'] ??
        json['test_levels'] ??
        json['items'] ??
        json['results'];
  }

  Future<String> completeWord({required int wordId}) async {
    final response = await _authorizedPost('/api/test/words/$wordId/complete');
    final json = _asMap(response.data);
    await _sessionManager.clearTestLevelsCache();
    return json['message']?.toString() ?? 'Test word completed.';
  }

  Future<List<TestLevelModel>> _readCachedLevels() async {
    final isFresh = await _sessionManager.isTestLevelsCacheFresh(_cacheMaxAge);
    if (!isFresh) {
      await _sessionManager.clearTestLevelsCache();
      return const <TestLevelModel>[];
    }

    final raw = await _sessionManager.getTestLevelsCache();
    if (raw == null || raw.isEmpty) {
      return const <TestLevelModel>[];
    }

    try {
      final decoded = jsonDecode(raw);
      if (decoded is List) {
        return decoded
            .whereType<Map>()
            .map((item) =>
                TestLevelModel.fromJson(Map<String, dynamic>.from(item)))
            .toList();
      }
      return const <TestLevelModel>[];
    } catch (_) {
      return const <TestLevelModel>[];
    }
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

  Future<Response<dynamic>> _authorizedPost(String path) async {
    final token = await _sessionManager.getAuthToken();
    if (token == null || token.isEmpty) {
      throw const ServerException('User is not authenticated.');
    }

    final response = await _dio.post<dynamic>(
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
    if (statusCode < 200 || statusCode >= 300) {
      throw ServerException(
        ApiErrorParser.fromResponseBody(
          response.data,
          statusCode: statusCode,
        ),
      );
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
