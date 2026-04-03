import 'package:dartz/dartz.dart';
import 'package:isharaapp/core/error/failures.dart';
import 'package:isharaapp/features/home/domain/entities/profile_user_entity.dart';

abstract class ProfileRepository {
  Future<ProfileUserEntity?> getCachedProfile();

  Future<bool> isCachedProfileFresh({Duration maxAge});

  Future<Either<Failure, ProfileUserEntity>> getProfile();

  Future<Either<Failure, ProfileUserEntity>> updateProfile({
    required String firstName,
    required String lastName,
    String? email,
  });

  Future<Either<Failure, String>> clearProgress();

  Future<Either<Failure, String>> logout();
}
