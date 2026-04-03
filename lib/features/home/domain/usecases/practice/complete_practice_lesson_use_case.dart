import 'package:dartz/dartz.dart';
import 'package:isharaapp/core/error/failures.dart';
import 'package:isharaapp/features/home/domain/repositories/practice/practice_repository.dart';

class CompletePracticeLessonUseCase {
  const CompletePracticeLessonUseCase(this._repository);

  final PracticeRepository _repository;

  Future<Either<Failure, String>> call({required int lessonId}) {
    return _repository.completeLesson(lessonId: lessonId);
  }
}
