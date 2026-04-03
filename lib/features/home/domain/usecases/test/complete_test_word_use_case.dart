import 'package:dartz/dartz.dart';
import 'package:isharaapp/core/error/failures.dart';
import 'package:isharaapp/features/home/domain/repositories/test/test_repository.dart';

class CompleteTestWordUseCase {
  const CompleteTestWordUseCase(this._repository);

  final TestRepository _repository;

  Future<Either<Failure, String>> call({required int wordId}) {
    return _repository.completeWord(wordId: wordId);
  }
}
