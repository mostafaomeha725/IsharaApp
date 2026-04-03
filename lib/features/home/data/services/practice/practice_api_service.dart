import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:isharaapp/core/constants/strings.dart';
import 'package:isharaapp/core/error/api_error_parser.dart';
import 'package:isharaapp/core/error/exceptions.dart';
import 'package:isharaapp/core/storage/app_session_manager.dart';
import 'package:isharaapp/features/home/data/models/practice/practice_level_model.dart';

class PracticeApiService {
  static const Duration _cacheMaxAge = Duration(minutes: 15);

  PracticeApiService({
    Dio? dio,
    AppSessionManager? sessionManager,
  })  : _dio = dio ?? Dio(BaseOptions(baseUrl: AppStrings.baseUrl)),
        _sessionManager = sessionManager ?? AppSessionManager();

  final Dio _dio;
  final AppSessionManager _sessionManager;

  Future<List<PracticeLevelModel>> getLevels() async {
    final cached = await _readCachedLevels();
    if (cached.isNotEmpty) {
      return cached;
    }

    final response = await _authorizedGet('/api/practice/levels');
    final json = _asMap(response.data);

    final levelsNode = json['data'] is Map
        ? _asMap(json['data'])['levels']
        : json['levels'] ?? json['data'];

    if (levelsNode is List) {
      final levels = levelsNode
          .whereType<Map>()
          .map((item) =>
              PracticeLevelModel.fromJson(Map<String, dynamic>.from(item)))
          .toList();

      await _sessionManager.setPracticeLevelsCache(
        jsonEncode(levels.map((item) => item.toJson()).toList()),
      );

      return levels;
    }

    return const <PracticeLevelModel>[];
  }

  Future<String> completeLesson({required int lessonId}) async {
    final response =
        await _authorizedPost('/api/practice/lessons/$lessonId/complete');
    final json = _asMap(response.data);
    await _sessionManager.clearPracticeLevelsCache();
    return json['message']?.toString() ?? 'Practice lesson completed.';
  }

  Future<List<PracticeLevelModel>> _readCachedLevels() async {
    final isFresh =
        await _sessionManager.isPracticeLevelsCacheFresh(_cacheMaxAge);
    if (!isFresh) {
      await _sessionManager.clearPracticeLevelsCache();
      return const <PracticeLevelModel>[];
    }

    final raw = await _sessionManager.getPracticeLevelsCache();
    if (raw == null || raw.isEmpty) {
      return const <PracticeLevelModel>[];
    }

    try {
      final decoded = jsonDecode(raw);
      if (decoded is List) {
        return decoded
            .whereType<Map>()
            .map((item) =>
                PracticeLevelModel.fromJson(Map<String, dynamic>.from(item)))
            .toList();
      }
      return const <PracticeLevelModel>[];
    } catch (_) {
      return const <PracticeLevelModel>[];
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
