import 'package:dartz/dartz.dart';
import 'package:isharaapp/core/error/failures.dart';
import 'package:isharaapp/features/home/domain/entities/practice/practice_level_entity.dart';
import 'package:isharaapp/features/home/domain/repositories/practice/practice_repository.dart';

class GetPracticeLevelsUseCase {
  const GetPracticeLevelsUseCase(this._repository);

  final PracticeRepository _repository;

  Future<Either<Failure, List<PracticeLevelEntity>>> call() {
    return _repository.getLevels();
  }
}
