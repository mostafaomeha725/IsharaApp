import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:isharaapp/core/error/api_error_parser.dart';
import 'package:isharaapp/core/error/exceptions.dart';
import 'package:isharaapp/core/error/failures.dart';
import 'package:isharaapp/core/storage/app_session_manager.dart';
import 'package:isharaapp/features/home/data/services/profile_api_service.dart';
import 'package:isharaapp/features/home/domain/entities/profile_user_entity.dart';
import 'package:isharaapp/features/home/domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  const ProfileRepositoryImpl({
    required ProfileApiService profileApiService,
    required AppSessionManager sessionManager,
  })  : _profileApiService = profileApiService,
        _sessionManager = sessionManager;

  final ProfileApiService _profileApiService;
  final AppSessionManager _sessionManager;

  @override
  Future<ProfileUserEntity?> getCachedProfile() async {
    final user = await _profileApiService.getCachedProfile();
    return user?.toEntity();
  }

  @override
  Future<bool> isCachedProfileFresh({
    Duration maxAge = const Duration(minutes: 10),
  }) {
    return _profileApiService.isCachedProfileFresh(maxAge: maxAge);
  }

  @override
  Future<Either<Failure, ProfileUserEntity>> getProfile() async {
    try {
      final user = await _profileApiService.getProfile();
      return Right(user.toEntity());
    } on ServerException catch (error) {
      return Left(ServerFailure(error.message));
    } on DioException catch (error) {
      return Left(NetworkFailure(ApiErrorParser.fromDioException(error)));
    } catch (_) {
      return const Left(UnknownFailure('Unexpected error occurred.'));
    }
  }

  @override
  Future<Either<Failure, ProfileUserEntity>> updateProfile({
    required String firstName,
    required String lastName,
    String? email,
  }) async {
    try {
      final user = await _profileApiService.updateName(
        firstName: firstName,
        lastName: lastName,
        email: email,
      );
      return Right(user.toEntity());
    } on ServerException catch (error) {
      return Left(ServerFailure(error.message));
    } on DioException catch (error) {
      return Left(NetworkFailure(ApiErrorParser.fromDioException(error)));
    } catch (_) {
      return const Left(UnknownFailure('Unexpected error occurred.'));
    }
  }

  @override
  Future<Either<Failure, String>> clearProgress() async {
    try {
      final message = await _profileApiService.clearProgress();
      await _sessionManager.clearAllLearningProgressCaches();
      await _profileApiService.clearProfileCache();
      return Right(message);
    } on ServerException catch (error) {
      return Left(ServerFailure(error.message));
    } on DioException catch (error) {
      return Left(NetworkFailure(ApiErrorParser.fromDioException(error)));
    } catch (_) {
      return const Left(UnknownFailure('Unexpected error occurred.'));
    }
  }

  @override
  Future<Either<Failure, String>> logout() async {
    try {
      final message = await _profileApiService.logout();
      await _sessionManager.clearAuthToken();
      await _profileApiService.clearProfileCache();
      return Right(message);
    } on ServerException catch (error) {
      return Left(ServerFailure(error.message));
    } on DioException catch (error) {
      return Left(NetworkFailure(ApiErrorParser.fromDioException(error)));
    } catch (_) {
      return const Left(UnknownFailure('Unexpected error occurred.'));
    }
  }
}
