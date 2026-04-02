part of 'auth_cubit.dart';

enum AuthAction {
  none,
  login,
  register,
  verifyOtp,
  resendOtp,
  forgotPasswordSend,
  forgotPasswordVerify,
  forgotPasswordReset,
  forgotPasswordResendOtp,
}

enum AuthStatus { initial, loading, success, error }

class AuthState extends Equatable {
  final AuthStatus status;
  final String? message;
  final String? token;
  final AuthAction action;

  const AuthState({
    required this.status,
    this.message,
    this.token,
    this.action = AuthAction.none,
  });

  const AuthState.initial() : this(status: AuthStatus.initial);

  const AuthState.loading({AuthAction action = AuthAction.none})
      : this(
          status: AuthStatus.loading,
          action: action,
        );

  const AuthState.success({
    String? message,
    String? token,
    AuthAction action = AuthAction.none,
  }) : this(
          status: AuthStatus.success,
          message: message,
          token: token,
          action: action,
        );

  const AuthState.error(
    String errorMessage, {
    AuthAction action = AuthAction.none,
  }) : this(
          status: AuthStatus.error,
          message: errorMessage,
          action: action,
        );

  bool get isLoading => status == AuthStatus.loading;

  @override
  List<Object?> get props => [status, message, token, action];
}
