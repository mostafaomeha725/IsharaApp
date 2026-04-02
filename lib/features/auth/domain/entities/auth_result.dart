import 'package:equatable/equatable.dart';

class AuthResult extends Equatable {
  final String? token;
  final String message;

  const AuthResult({
    required this.message,
    this.token,
  });

  @override
  List<Object?> get props => [token, message];
}
