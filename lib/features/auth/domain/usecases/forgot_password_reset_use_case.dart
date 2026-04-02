import 'package:dartz/dartz.dart';
import 'package:isharaapp/core/error/failures.dart';
import 'package:isharaapp/features/auth/domain/entities/auth_result.dart';
import 'package:isharaapp/features/auth/domain/repositories/auth_repository.dart';

class ForgotPasswordResetUseCase {
  final AuthRepository authRepository;

  const ForgotPasswordResetUseCase(this.authRepository);

  Future<Either<Failure, AuthResult>> call({
    required String email,
    required String otp,
    required String password,
  }) {
    return authRepository.forgotPasswordReset(
      email: email,
      otp: otp,
      password: password,
    );
  }
}
