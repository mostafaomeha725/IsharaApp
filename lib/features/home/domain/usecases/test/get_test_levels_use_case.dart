import 'package:dartz/dartz.dart';
import 'package:isharaapp/core/error/failures.dart';
import 'package:isharaapp/features/home/domain/entities/test/test_level_entity.dart';
import 'package:isharaapp/features/home/domain/repositories/test/test_repository.dart';

class GetTestLevelsUseCase {
  const GetTestLevelsUseCase(this._repository);

  final TestRepository _repository;

  Future<Either<Failure, List<TestLevelEntity>>> call() {
    return _repository.getLevels();
  }
}
