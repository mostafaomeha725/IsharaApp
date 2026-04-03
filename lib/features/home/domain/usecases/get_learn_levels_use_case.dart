import 'package:dartz/dartz.dart';
import 'package:isharaapp/core/error/failures.dart';
import 'package:isharaapp/features/home/domain/entities/learn_level_entity.dart';
import 'package:isharaapp/features/home/domain/repositories/learn_repository.dart';

class GetLearnLevelsUseCase {
  const GetLearnLevelsUseCase(this._repository);

  final LearnRepository _repository;

  Future<Either<Failure, List<LearnLevelEntity>>> call() {
    return _repository.getLevels();
  }
}
