import 'package:dartz/dartz.dart';
import 'package:isharaapp/core/error/failures.dart';
import 'package:isharaapp/features/home/domain/entities/learn_level_entity.dart';

abstract class LearnRepository {
  Future<Either<Failure, List<LearnLevelEntity>>> getLevels();

  Future<Either<Failure, String>> completeLesson({required int lessonId});
}
