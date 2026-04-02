import 'package:dartz/dartz.dart';
import 'package:isharaapp/core/error/failures.dart';
import 'package:isharaapp/features/auth/domain/entities/auth_result.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthResult>> login({
    required String email,
    required String password,
  });

  Future<Either<Failure, AuthResult>> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String gender,
    required String dateOfBirth,
  });

  Future<Either<Failure, AuthResult>> verifyOtp({
    required String email,
    required String otp,
  });

  Future<Either<Failure, AuthResult>> resendOtp({
    required String email,
  });

  Future<Either<Failure, AuthResult>> forgotPasswordSend({
    required String email,
  });

  Future<Either<Failure, AuthResult>> forgotPasswordVerify({
    required String email,
    required String otp,
  });

  Future<Either<Failure, AuthResult>> forgotPasswordReset({
    required String email,
    required String otp,
    required String password,
  });

  Future<Either<Failure, AuthResult>> forgotPasswordResendOtp({
    required String email,
  });
}
