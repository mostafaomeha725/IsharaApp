import 'package:dio/dio.dart';

class ApiErrorParser {
  const ApiErrorParser._();

  static String fromResponseBody(
    dynamic body, {
    int? statusCode,
    String fallback = 'Something went wrong. Please try again.',
  }) {
    final json = _asMap(body);

    final directMessage = json['message']?.toString().trim();
    if (directMessage != null && directMessage.isNotEmpty) {
      return directMessage;
    }

    final directError = json['error']?.toString().trim();
    if (directError != null && directError.isNotEmpty) {
      return directError;
    }

    final validationMessage = _extractValidationMessage(json['errors']);
    if (validationMessage != null && validationMessage.isNotEmpty) {
      return validationMessage;
    }

    if (statusCode != null) {
      return 'Request failed with status $statusCode';
    }

    return fallback;
  }

  static String fromDioException(
    DioException error, {
    String fallback = 'Network error. Please try again.',
  }) {
    if (error.response != null) {
      final serverMessage = fromResponseBody(
        error.response?.data,
        statusCode: error.response?.statusCode,
      );
      if (serverMessage.isNotEmpty) {
        return serverMessage;
      }
    }

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return 'Connection timed out. Please try again.';
      case DioExceptionType.connectionError:
      case DioExceptionType.unknown:
        return 'No internet connection.';
      case DioExceptionType.cancel:
        return 'Request was cancelled.';
      case DioExceptionType.badCertificate:
      case DioExceptionType.badResponse:
        break;
    }

    final message = error.message?.trim();
    if (message != null && message.isNotEmpty) {
      return message;
    }

    return fallback;
  }

  static String? _extractValidationMessage(dynamic errorsNode) {
    if (errorsNode is Map) {
      for (final value in errorsNode.values) {
        if (value is List && value.isNotEmpty) {
          final first = value.first?.toString().trim();
          if (first != null && first.isNotEmpty) {
            return first;
          }
        }

        final nested = value?.toString().trim();
        if (nested != null && nested.isNotEmpty) {
          return nested;
        }
      }
    }

    if (errorsNode is List && errorsNode.isNotEmpty) {
      final first = errorsNode.first?.toString().trim();
      if (first != null && first.isNotEmpty) {
        return first;
      }
    }

    return null;
  }

  static Map<String, dynamic> _asMap(dynamic body) {
    if (body is Map<String, dynamic>) {
      return body;
    }
    if (body is Map) {
      return Map<String, dynamic>.from(body);
    }
    return <String, dynamic>{};
  }
}
