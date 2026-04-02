import 'package:dartz/dartz.dart';
import 'package:isharaapp/core/error/failures.dart';
import 'package:isharaapp/features/auth/domain/entities/auth_result.dart';
import 'package:isharaapp/features/auth/domain/repositories/auth_repository.dart';

class ForgotPasswordVerifyUseCase {
  final AuthRepository authRepository;

  const ForgotPasswordVerifyUseCase(this.authRepository);

  Future<Either<Failure, AuthResult>> call({
    required String email,
    required String otp,
  }) {
    return authRepository.forgotPasswordVerify(
      email: email,
      otp: otp,
    );
  }
}
