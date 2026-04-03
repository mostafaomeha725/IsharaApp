import 'package:dartz/dartz.dart';
import 'package:isharaapp/core/error/failures.dart';
import 'package:isharaapp/features/home/domain/entities/test/test_level_entity.dart';

abstract class TestRepository {
  Future<Either<Failure, List<TestLevelEntity>>> getLevels();

  Future<Either<Failure, String>> completeWord({required int wordId});
}
