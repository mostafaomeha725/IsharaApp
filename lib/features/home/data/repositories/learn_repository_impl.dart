import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:isharaapp/core/error/api_error_parser.dart';
import 'package:isharaapp/core/error/exceptions.dart';
import 'package:isharaapp/core/error/failures.dart';
import 'package:isharaapp/features/home/data/services/learn_api_service.dart';
import 'package:isharaapp/features/home/domain/entities/learn_level_entity.dart';
import 'package:isharaapp/features/home/domain/repositories/learn_repository.dart';

class LearnRepositoryImpl implements LearnRepository {
  const LearnRepositoryImpl({required LearnApiService learnApiService})
      : _learnApiService = learnApiService;

  final LearnApiService _learnApiService;

  @override
  Future<Either<Failure, List<LearnLevelEntity>>> getLevels() async {
    try {
      final levels = await _learnApiService.getLevels();
      return Right(levels.map((item) => item.toEntity()).toList());
    } on ServerException catch (error) {
      return Left(ServerFailure(error.message));
    } on DioException catch (error) {
      return Left(NetworkFailure(ApiErrorParser.fromDioException(error)));
    } catch (_) {
      return const Left(UnknownFailure('Unexpected error occurred.'));
    }
  }

  @override
  Future<Either<Failure, String>> completeLesson(
      {required int lessonId}) async {
    try {
      final message = await _learnApiService.completeLesson(lessonId: lessonId);
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
