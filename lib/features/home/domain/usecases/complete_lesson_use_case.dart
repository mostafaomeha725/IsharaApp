import 'package:dartz/dartz.dart';
import 'package:isharaapp/core/error/failures.dart';
import 'package:isharaapp/features/home/domain/repositories/learn_repository.dart';

class CompleteLessonUseCase {
  const CompleteLessonUseCase(this._repository);

  final LearnRepository _repository;

  Future<Either<Failure, String>> call({required int lessonId}) {
    return _repository.completeLesson(lessonId: lessonId);
  }
}
