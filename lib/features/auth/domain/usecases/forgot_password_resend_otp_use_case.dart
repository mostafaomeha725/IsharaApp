import 'package:dartz/dartz.dart';
import 'package:isharaapp/core/error/failures.dart';
import 'package:isharaapp/features/auth/domain/entities/auth_result.dart';
import 'package:isharaapp/features/auth/domain/repositories/auth_repository.dart';

class ForgotPasswordResendOtpUseCase {
  final AuthRepository authRepository;

  const ForgotPasswordResendOtpUseCase(this.authRepository);

  Future<Either<Failure, AuthResult>> call({
    required String email,
  }) {
    return authRepository.forgotPasswordResendOtp(email: email);
  }
}
