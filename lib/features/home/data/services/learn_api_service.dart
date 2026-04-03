import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:isharaapp/core/constants/strings.dart';
import 'package:isharaapp/core/error/api_error_parser.dart';
import 'package:isharaapp/core/error/exceptions.dart';
import 'package:isharaapp/core/storage/app_session_manager.dart';
import 'package:isharaapp/features/home/data/models/learn_level_model.dart';

class LearnApiService {
  static const Duration _cacheMaxAge = Duration(minutes: 15);

  LearnApiService({
    Dio? dio,
    AppSessionManager? sessionManager,
  })  : _dio = dio ?? Dio(BaseOptions(baseUrl: AppStrings.baseUrl)),
        _sessionManager = sessionManager ?? AppSessionManager();

  final Dio _dio;
  final AppSessionManager _sessionManager;

  Future<List<LearnLevelModel>> getLevels() async {
    final cached = await _readCachedLevels();
    if (cached.isNotEmpty) {
      return cached;
    }

    final response = await _authorizedGet('/api/learn/levels');
    final json = _asMap(response.data);

    final levelsNode = json['data'] is Map
        ? _asMap(json['data'])['levels']
        : json['levels'] ?? json['data'];

    if (levelsNode is List) {
      final levels = levelsNode
          .whereType<Map>()
          .map((item) =>
              LearnLevelModel.fromJson(Map<String, dynamic>.from(item)))
          .toList();

      await _sessionManager.setLearnLevelsCache(
        jsonEncode(levels.map((item) => item.toJson()).toList()),
      );

      return levels;
    }

    return const <LearnLevelModel>[];
  }

  Future<String> completeLesson({required int lessonId}) async {
    final response =
        await _authorizedPost('/api/learn/lessons/$lessonId/complete');
    final json = _asMap(response.data);
    await _sessionManager.clearLearnLevelsCache();
    return json['message']?.toString() ?? 'Lesson completed successfully.';
  }

  Future<List<LearnLevelModel>> _readCachedLevels() async {
    final isFresh = await _sessionManager.isLearnLevelsCacheFresh(_cacheMaxAge);
    if (!isFresh) {
      await _sessionManager.clearLearnLevelsCache();
      return const <LearnLevelModel>[];
    }

    final raw = await _sessionManager.getLearnLevelsCache();
    if (raw == null || raw.isEmpty) {
      return const <LearnLevelModel>[];
    }

    try {
      final decoded = jsonDecode(raw);
      if (decoded is List) {
        return decoded
            .whereType<Map>()
            .map((item) =>
                LearnLevelModel.fromJson(Map<String, dynamic>.from(item)))
            .toList();
      }
      return const <LearnLevelModel>[];
    } catch (_) {
      return const <LearnLevelModel>[];
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
