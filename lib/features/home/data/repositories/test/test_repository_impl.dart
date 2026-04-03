import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:isharaapp/core/error/api_error_parser.dart';
import 'package:isharaapp/core/error/exceptions.dart';
import 'package:isharaapp/core/error/failures.dart';
import 'package:isharaapp/features/home/data/services/test/test_api_service.dart';
import 'package:isharaapp/features/home/domain/entities/test/test_level_entity.dart';
import 'package:isharaapp/features/home/domain/repositories/test/test_repository.dart';

class TestRepositoryImpl implements TestRepository {
  const TestRepositoryImpl({required TestApiService testApiService})
      : _testApiService = testApiService;

  final TestApiService _testApiService;

  @override
  Future<Either<Failure, List<TestLevelEntity>>> getLevels() async {
    try {
      final levels = await _testApiService.getLevels();
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
  Future<Either<Failure, String>> completeWord({required int wordId}) async {
    try {
      final message = await _testApiService.completeWord(wordId: wordId);
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
