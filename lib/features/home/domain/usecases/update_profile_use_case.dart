import 'package:dartz/dartz.dart';
import 'package:isharaapp/core/error/failures.dart';
import 'package:isharaapp/features/home/domain/entities/profile_user_entity.dart';
import 'package:isharaapp/features/home/domain/repositories/profile_repository.dart';

class UpdateProfileUseCase {
  const UpdateProfileUseCase(this._repository);

  final ProfileRepository _repository;

  Future<Either<Failure, ProfileUserEntity>> call({
    required String firstName,
    required String lastName,
    String? email,
  }) {
    return _repository.updateProfile(
      firstName: firstName,
      lastName: lastName,
      email: email,
    );
  }
}
