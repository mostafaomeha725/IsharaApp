import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:isharaapp/core/error/api_error_parser.dart';
import 'package:isharaapp/core/error/exceptions.dart';
import 'package:isharaapp/core/error/failures.dart';
import 'package:isharaapp/features/home/data/services/practice/practice_api_service.dart';
import 'package:isharaapp/features/home/domain/entities/practice/practice_level_entity.dart';
import 'package:isharaapp/features/home/domain/repositories/practice/practice_repository.dart';

class PracticeRepositoryImpl implements PracticeRepository {
  const PracticeRepositoryImpl({required PracticeApiService practiceApiService})
      : _practiceApiService = practiceApiService;

  final PracticeApiService _practiceApiService;

  @override
  Future<Either<Failure, List<PracticeLevelEntity>>> getLevels() async {
    try {
      final levels = await _practiceApiService.getLevels();
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
      final message =
          await _practiceApiService.completeLesson(lessonId: lessonId);
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
