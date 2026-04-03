import 'package:dartz/dartz.dart';
import 'package:isharaapp/core/error/failures.dart';
import 'package:isharaapp/features/home/domain/entities/practice/practice_level_entity.dart';

abstract class PracticeRepository {
  Future<Either<Failure, List<PracticeLevelEntity>>> getLevels();

  Future<Either<Failure, String>> completeLesson({required int lessonId});
}
