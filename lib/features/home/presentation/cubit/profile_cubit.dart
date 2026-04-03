import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isharaapp/features/home/domain/entities/profile_user_entity.dart';
import 'package:isharaapp/features/home/domain/repositories/profile_repository.dart';
import 'package:isharaapp/features/home/domain/usecases/clear_profile_progress_use_case.dart';
import 'package:isharaapp/features/home/domain/usecases/get_profile_use_case.dart';
import 'package:isharaapp/features/home/domain/usecases/logout_profile_use_case.dart';
import 'package:isharaapp/features/home/domain/usecases/update_profile_use_case.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit({
    required ProfileRepository profileRepository,
    required GetProfileUseCase getProfileUseCase,
    required UpdateProfileUseCase updateProfileUseCase,
    required ClearProfileProgressUseCase clearProfileProgressUseCase,
    required LogoutProfileUseCase logoutProfileUseCase,
  })  : _profileRepository = profileRepository,
        _getProfileUseCase = getProfileUseCase,
        _updateProfileUseCase = updateProfileUseCase,
        _clearProfileProgressUseCase = clearProfileProgressUseCase,
        _logoutProfileUseCase = logoutProfileUseCase,
        super(const ProfileState.initial());

  final ProfileRepository _profileRepository;
  final GetProfileUseCase _getProfileUseCase;
  final UpdateProfileUseCase _updateProfileUseCase;
  final ClearProfileProgressUseCase _clearProfileProgressUseCase;
  final LogoutProfileUseCase _logoutProfileUseCase;

  void _safeEmit(ProfileState state) {
    if (!isClosed) {
      emit(state);
    }
  }

  Future<void> loadProfile({bool forceRefresh = false}) async {
    final cachedUser = await _profileRepository.getCachedProfile();
    if (cachedUser != null) {
      _safeEmit(
        ProfileState.success(
          action: ProfileAction.loadProfile,
          user: cachedUser,
        ),
      );

      final isFresh = await _profileRepository.isCachedProfileFresh();
      if (!forceRefresh && isFresh) {
        return;
      }
    } else {
      _safeEmit(const ProfileState.loading(action: ProfileAction.loadProfile));
    }

    final result = await _getProfileUseCase();
    if (isClosed) {
      return;
    }

    result.fold(
      (failure) => _safeEmit(
        ProfileState.error(
          failure.message,
          action: ProfileAction.loadProfile,
          user: state.user,
        ),
      ),
      (user) => _safeEmit(
        ProfileState.success(
          action: ProfileAction.loadProfile,
          user: user,
        ),
      ),
    );
  }

  Future<void> updateName({
    required String firstName,
    required String lastName,
    String? email,
  }) async {
    _safeEmit(ProfileState.loading(
        action: ProfileAction.updateName, user: state.user));

    final result = await _updateProfileUseCase(
      firstName: firstName,
      lastName: lastName,
      email: email,
    );
    if (isClosed) {
      return;
    }

    result.fold(
      (failure) => _safeEmit(
        ProfileState.error(
          failure.message,
          action: ProfileAction.updateName,
          user: state.user,
        ),
      ),
      (user) => _safeEmit(
        ProfileState.success(
          action: ProfileAction.updateName,
          user: user,
          message: 'Name updated successfully.',
        ),
      ),
    );
  }

  Future<void> clearProgress() async {
    _safeEmit(ProfileState.loading(
        action: ProfileAction.clearProgress, user: state.user));

    final result = await _clearProfileProgressUseCase();
    if (isClosed) {
      return;
    }

    result.fold(
      (failure) => _safeEmit(
        ProfileState.error(
          failure.message,
          action: ProfileAction.clearProgress,
          user: state.user,
        ),
      ),
      (message) => _safeEmit(
        ProfileState.success(
          action: ProfileAction.clearProgress,
          user: state.user,
          message: message,
        ),
      ),
    );
  }

  Future<void> logout() async {
    _safeEmit(
        ProfileState.loading(action: ProfileAction.logout, user: state.user));

    final result = await _logoutProfileUseCase();
    if (isClosed) {
      return;
    }

    result.fold(
      (failure) => _safeEmit(
        ProfileState.error(
          failure.message,
          action: ProfileAction.logout,
        ),
      ),
      (message) => _safeEmit(
        ProfileState.success(
          action: ProfileAction.logout,
          message: message,
        ),
      ),
    );
  }
}
