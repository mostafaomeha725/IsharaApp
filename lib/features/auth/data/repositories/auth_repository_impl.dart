import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:isharaapp/core/error/api_error_parser.dart';
import 'package:isharaapp/core/error/exceptions.dart';
import 'package:isharaapp/core/error/failures.dart';
import 'package:isharaapp/features/auth/data/services/auth_api_service.dart';
import 'package:isharaapp/features/auth/domain/entities/auth_result.dart';
import 'package:isharaapp/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthApiService authApiService;

  const AuthRepositoryImpl({required this.authApiService});

  Future<Either<Failure, AuthResult>> _execute(
    Future<AuthResult> Function() operation,
  ) async {
    try {
      final result = await operation();
      return Right(result);
    } on ServerException catch (error) {
      return Left(ServerFailure(error.message));
    } on DioException catch (error) {
      return Left(NetworkFailure(ApiErrorParser.fromDioException(error)));
    } catch (_) {
      return const Left(UnknownFailure('Unexpected error occurred.'));
    }
  }

  @override
  Future<Either<Failure, AuthResult>> login({
    required String email,
    required String password,
  }) async {
    return _execute(() async {
      final response = await authApiService.login(
        email: email,
        password: password,
      );

      return response.toEntity();
    });
  }

  @override
  Future<Either<Failure, AuthResult>> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String gender,
    required String dateOfBirth,
  }) async {
    return _execute(() async {
      final response = await authApiService.register(
        firstName: firstName,
        lastName: lastName,
        email: email,
        password: password,
        gender: gender,
        dateOfBirth: dateOfBirth,
      );

      return response.toEntity();
    });
  }

  @override
  Future<Either<Failure, AuthResult>> verifyOtp({
    required String email,
    required String otp,
  }) async {
    return _execute(() async {
      final response = await authApiService.verifyOtp(
        email: email,
        otp: otp,
      );

      return response.toEntity();
    });
  }

  @override
  Future<Either<Failure, AuthResult>> resendOtp({
    required String email,
  }) async {
    return _execute(() async {
      final response = await authApiService.resendOtp(email: email);
      return response.toEntity();
    });
  }

  @override
  Future<Either<Failure, AuthResult>> forgotPasswordSend({
    required String email,
  }) async {
    return _execute(() async {
      final response = await authApiService.forgotPasswordSend(email: email);
      return response.toEntity();
    });
  }

  @override
  Future<Either<Failure, AuthResult>> forgotPasswordVerify({
    required String email,
    required String otp,
  }) async {
    return _execute(() async {
      final response = await authApiService.forgotPasswordVerify(
        email: email,
        otp: otp,
      );
      return response.toEntity();
    });
  }

  @override
  Future<Either<Failure, AuthResult>> forgotPasswordReset({
    required String email,
    required String otp,
    required String password,
  }) async {
    return _execute(() async {
      final response = await authApiService.forgotPasswordReset(
        email: email,
        otp: otp,
        password: password,
      );
      return response.toEntity();
    });
  }

  @override
  Future<Either<Failure, AuthResult>> forgotPasswordResendOtp({
    required String email,
  }) async {
    return _execute(() async {
      final response =
          await authApiService.forgotPasswordResendOtp(email: email);
      return response.toEntity();
    });
  }
}
