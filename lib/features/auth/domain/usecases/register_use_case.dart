import 'package:dartz/dartz.dart';
import 'package:isharaapp/core/error/failures.dart';
import 'package:isharaapp/features/auth/domain/entities/auth_result.dart';
import 'package:isharaapp/features/auth/domain/repositories/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository authRepository;

  const RegisterUseCase(this.authRepository);

  Future<Either<Failure, AuthResult>> call({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String gender,
    required String dateOfBirth,
  }) {
    return authRepository.register(
      firstName: firstName,
      lastName: lastName,
      email: email,
      password: password,
      gender: gender,
      dateOfBirth: dateOfBirth,
    );
  }
}
