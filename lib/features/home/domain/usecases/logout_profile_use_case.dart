import 'package:dartz/dartz.dart';
import 'package:isharaapp/core/error/failures.dart';
import 'package:isharaapp/features/home/domain/repositories/profile_repository.dart';

class LogoutProfileUseCase {
  const LogoutProfileUseCase(this._repository);

  final ProfileRepository _repository;

  Future<Either<Failure, String>> call() {
    return _repository.logout();
  }
}
