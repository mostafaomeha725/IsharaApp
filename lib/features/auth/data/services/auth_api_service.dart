import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:isharaapp/core/constants/strings.dart';
import 'package:isharaapp/core/error/api_error_parser.dart';
import 'package:isharaapp/core/error/exceptions.dart';
import 'package:isharaapp/features/auth/data/constants/auth_endpoints.dart';
import 'package:isharaapp/features/auth/data/models/auth_response_model.dart';

class AuthApiService {
  final Dio _dio;

  AuthApiService({Dio? dio})
      : _dio = dio ??
            Dio(
              BaseOptions(
                baseUrl: AppStrings.baseUrl,
                connectTimeout: const Duration(seconds: 20),
                receiveTimeout: const Duration(seconds: 20),
                sendTimeout: const Duration(seconds: 20),
                headers: const {
                  'Content-Type': 'application/json',
                  'Accept': 'application/json',
                },
              ),
            );

  Future<AuthResponseModel> login({
    required String email,
    required String password,
  }) async {
    final response = await _post(
      AuthEndpoints.login,
      {
        'email': email,
        'password': password,
      },
    );

    return _handleResponse(response);
  }

  Future<AuthResponseModel> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String gender,
    required String dateOfBirth,
  }) async {
    final normalizedGender = _normalizeGender(gender);
    final normalizedDateOfBirth = _normalizeDate(dateOfBirth);

    final response = await _post(
      AuthEndpoints.register,
      {
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'password': password,
        'password_confirmation': password,
        'gender': normalizedGender,
        'date_of_birth': normalizedDateOfBirth,
      },
    );

    return _handleResponse(response);
  }

  Future<AuthResponseModel> verifyOtp({
    required String email,
    required String otp,
  }) async {
    final response = await _post(
      AuthEndpoints.verifyOtp,
      {
        'email': email,
        'otp_code': otp,
        'otp': otp,
      },
    );

    return _handleResponse(response);
  }

  Future<AuthResponseModel> resendOtp({
    required String email,
  }) async {
    final response = await _post(
      AuthEndpoints.resendOtp,
      {
        'email': email,
      },
    );

    return _handleResponse(response);
  }

  Future<AuthResponseModel> forgotPasswordSend({
    required String email,
  }) async {
    final response = await _post(
      AuthEndpoints.forgotPasswordSend,
      {
        'email': email,
      },
    );

    return _handleResponse(response);
  }

  Future<AuthResponseModel> forgotPasswordVerify({
    required String email,
    required String otp,
  }) async {
    final response = await _post(
      AuthEndpoints.forgotPasswordVerify,
      {
        'email': email,
        'otp_code': otp,
        'otp': otp,
      },
    );

    return _handleResponse(response);
  }

  Future<AuthResponseModel> forgotPasswordReset({
    required String email,
    required String otp,
    required String password,
  }) async {
    final response = await _post(
      AuthEndpoints.forgotPasswordReset,
      {
        'email': email,
        'otp_code': otp,
        'otp': otp,
        'password': password,
        'password_confirmation': password,
      },
    );

    return _handleResponse(response);
  }

  Future<AuthResponseModel> forgotPasswordResendOtp({
    required String email,
  }) async {
    final response = await _post(
      AuthEndpoints.forgotPasswordResendOtp,
      {
        'email': email,
      },
    );

    return _handleResponse(response);
  }

  Future<Response<dynamic>> _post(
    String endpoint,
    Map<String, dynamic> body,
  ) async {
    return _dio.post<dynamic>(
      endpoint,
      data: body,
      options: Options(
        validateStatus: (_) => true,
      ),
    );
  }

  AuthResponseModel _handleResponse(Response<dynamic> response) {
    final Map<String, dynamic> json = _normalizeResponseBody(response.data);
    final statusCode = response.statusCode ?? 500;

    if (statusCode >= 200 && statusCode < 300) {
      return AuthResponseModel.fromJson(json);
    }

    final String message = ApiErrorParser.fromResponseBody(
      json,
      statusCode: statusCode,
    );
    throw ServerException(message);
  }

  Map<String, dynamic> _normalizeResponseBody(dynamic responseData) {
    if (responseData is Map<String, dynamic>) {
      return responseData;
    }

    if (responseData is String) {
      final decoded = _safeJsonDecode(responseData);
      if (decoded != null) {
        return decoded;
      }
    }

    return <String, dynamic>{};
  }

  Map<String, dynamic>? _safeJsonDecode(String responseBody) {
    try {
      final dynamic decoded = jsonDecode(responseBody);
      if (decoded is Map<String, dynamic>) {
        return decoded;
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  String _normalizeGender(String gender) {
    final value = gender.trim().toLowerCase();
    if (value == 'male' || value == 'm') {
      return 'male';
    }
    if (value == 'female' || value == 'f') {
      return 'female';
    }
    return value;
  }

  String _normalizeDate(String value) {
    final text = value.trim();

    // Converts date from dd/mm/yyyy UI format to yyyy-MM-dd API format.
    final parts = text.split('/');
    if (parts.length == 3) {
      final day = parts[0].padLeft(2, '0');
      final month = parts[1].padLeft(2, '0');
      final year = parts[2];
      if (year.length == 4) {
        return '$year-$month-$day';
      }
    }

    return text;
  }
}
