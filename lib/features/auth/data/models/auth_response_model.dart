import 'package:isharaapp/features/auth/domain/entities/auth_result.dart';

class AuthResponseModel {
  final String? token;
  final String message;

  const AuthResponseModel({
    required this.message,
    this.token,
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    final dynamic data = json['data'];
    final String? dataToken =
        data is Map<String, dynamic> ? data['token']?.toString() : null;

    return AuthResponseModel(
      token: json['token']?.toString() ?? dataToken,
      message: json['message']?.toString() ??
          json['error']?.toString() ??
          'Request completed.',
    );
  }

  AuthResult toEntity() {
    return AuthResult(
      message: message,
      token: token,
    );
  }
}
