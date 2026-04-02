import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isharaapp/core/error/failures.dart';
import 'package:isharaapp/features/auth/domain/entities/auth_result.dart';
import 'package:isharaapp/features/auth/domain/usecases/forgot_password_resend_otp_use_case.dart';
import 'package:isharaapp/features/auth/domain/usecases/forgot_password_reset_use_case.dart';
import 'package:isharaapp/features/auth/domain/usecases/forgot_password_send_use_case.dart';
import 'package:isharaapp/features/auth/domain/usecases/forgot_password_verify_use_case.dart';
import 'package:isharaapp/features/auth/domain/usecases/login_use_case.dart';
import 'package:isharaapp/features/auth/domain/usecases/resend_otp_use_case.dart';
import 'package:isharaapp/features/auth/domain/usecases/register_use_case.dart';
import 'package:isharaapp/features/auth/domain/usecases/verify_otp_use_case.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({
    required LoginUseCase loginUseCase,
    required RegisterUseCase registerUseCase,
    required ForgotPasswordSendUseCase forgotPasswordSendUseCase,
    required ForgotPasswordVerifyUseCase forgotPasswordVerifyUseCase,
    required ForgotPasswordResetUseCase forgotPasswordResetUseCase,
    required ForgotPasswordResendOtpUseCase forgotPasswordResendOtpUseCase,
    required VerifyOtpUseCase verifyOtpUseCase,
    required ResendOtpUseCase resendOtpUseCase,
  })  : _loginUseCase = loginUseCase,
        _registerUseCase = registerUseCase,
        _forgotPasswordSendUseCase = forgotPasswordSendUseCase,
        _forgotPasswordVerifyUseCase = forgotPasswordVerifyUseCase,
        _forgotPasswordResetUseCase = forgotPasswordResetUseCase,
        _forgotPasswordResendOtpUseCase = forgotPasswordResendOtpUseCase,
        _verifyOtpUseCase = verifyOtpUseCase,
        _resendOtpUseCase = resendOtpUseCase,
        super(const AuthState.initial());

  static const String tokenStorageKey = 'auth_token';

  final LoginUseCase _loginUseCase;
  final RegisterUseCase _registerUseCase;
  final ForgotPasswordSendUseCase _forgotPasswordSendUseCase;
  final ForgotPasswordVerifyUseCase _forgotPasswordVerifyUseCase;
  final ForgotPasswordResetUseCase _forgotPasswordResetUseCase;
  final ForgotPasswordResendOtpUseCase _forgotPasswordResendOtpUseCase;
  final VerifyOtpUseCase _verifyOtpUseCase;
  final ResendOtpUseCase _resendOtpUseCase;

  Future<void> _handleResult({
    required Future<Either<Failure, AuthResult>> request,
    required AuthAction action,
    bool persistToken = false,
  }) async {
    emit(AuthState.loading(action: action));

    final result = await request;

    await result.fold(
      (failure) async {
        emit(AuthState.error(failure.message, action: action));
      },
      (data) async {
        if (persistToken && data.token != null && data.token!.isNotEmpty) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString(tokenStorageKey, data.token!);
        }

        emit(
          AuthState.success(
            message: data.message,
            token: data.token,
            action: action,
          ),
        );
      },
    );
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    await _handleResult(
      request: _loginUseCase(email: email, password: password),
      action: AuthAction.login,
      persistToken: true,
    );
  }

  Future<void> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String gender,
    required String dateOfBirth,
  }) async {
    await _handleResult(
      request: _registerUseCase(
        firstName: firstName,
        lastName: lastName,
        email: email,
        password: password,
        gender: gender,
        dateOfBirth: dateOfBirth,
      ),
      action: AuthAction.register,
      persistToken: true,
    );
  }

  Future<void> forgotPasswordSend({
    required String email,
  }) async {
    await _handleResult(
      request: _forgotPasswordSendUseCase(email: email),
      action: AuthAction.forgotPasswordSend,
    );
  }

  Future<void> verifyOtp({
    required String email,
    required String otp,
  }) async {
    await _handleResult(
      request: _verifyOtpUseCase(
        email: email,
        otp: otp,
      ),
      action: AuthAction.verifyOtp,
    );
  }

  Future<void> resendOtp({
    required String email,
  }) async {
    await _handleResult(
      request: _resendOtpUseCase(email: email),
      action: AuthAction.resendOtp,
    );
  }

  Future<void> forgotPasswordVerify({
    required String email,
    required String otp,
  }) async {
    await _handleResult(
      request: _forgotPasswordVerifyUseCase(
        email: email,
        otp: otp,
      ),
      action: AuthAction.forgotPasswordVerify,
    );
  }

  Future<void> forgotPasswordReset({
    required String email,
    required String otp,
    required String password,
  }) async {
    await _handleResult(
      request: _forgotPasswordResetUseCase(
        email: email,
        otp: otp,
        password: password,
      ),
      action: AuthAction.forgotPasswordReset,
    );
  }

  Future<void> forgotPasswordResendOtp({
    required String email,
  }) async {
    await _handleResult(
      request: _forgotPasswordResendOtpUseCase(email: email),
      action: AuthAction.forgotPasswordResendOtp,
    );
  }

  void reset() {
    emit(const AuthState.initial());
  }
}
