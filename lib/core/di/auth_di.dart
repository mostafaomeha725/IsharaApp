import 'package:isharaapp/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:isharaapp/features/auth/data/services/auth_api_service.dart';
import 'package:isharaapp/features/auth/domain/usecases/forgot_password_resend_otp_use_case.dart';
import 'package:isharaapp/features/auth/domain/usecases/forgot_password_reset_use_case.dart';
import 'package:isharaapp/features/auth/domain/usecases/forgot_password_send_use_case.dart';
import 'package:isharaapp/features/auth/domain/usecases/forgot_password_verify_use_case.dart';
import 'package:isharaapp/features/auth/domain/usecases/login_use_case.dart';
import 'package:isharaapp/features/auth/domain/usecases/resend_otp_use_case.dart';
import 'package:isharaapp/features/auth/domain/usecases/register_use_case.dart';
import 'package:isharaapp/features/auth/domain/usecases/verify_otp_use_case.dart';
import 'package:isharaapp/features/auth/presentation/cubit/auth_cubit.dart';

class AuthDi {
  static AuthCubit createCubit() {
    final authApiService = AuthApiService();
    final authRepository = AuthRepositoryImpl(authApiService: authApiService);

    return AuthCubit(
      loginUseCase: LoginUseCase(authRepository),
      registerUseCase: RegisterUseCase(authRepository),
      forgotPasswordSendUseCase: ForgotPasswordSendUseCase(authRepository),
      forgotPasswordVerifyUseCase: ForgotPasswordVerifyUseCase(authRepository),
      forgotPasswordResetUseCase: ForgotPasswordResetUseCase(authRepository),
      forgotPasswordResendOtpUseCase:
          ForgotPasswordResendOtpUseCase(authRepository),
      verifyOtpUseCase: VerifyOtpUseCase(authRepository),
      resendOtpUseCase: ResendOtpUseCase(authRepository),
    );
  }
}
