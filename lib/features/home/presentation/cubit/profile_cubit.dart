import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isharaapp/core/error/exceptions.dart';
import 'package:isharaapp/core/storage/app_session_manager.dart';
import 'package:isharaapp/features/home/data/models/profile_user_model.dart';
import 'package:isharaapp/features/home/data/services/profile_api_service.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit({
    required ProfileApiService profileApiService,
    required AppSessionManager sessionManager,
  })  : _profileApiService = profileApiService,
        _sessionManager = sessionManager,
        super(const ProfileState.initial());

  final ProfileApiService _profileApiService;
  final AppSessionManager _sessionManager;

  Future<void> loadProfile({bool forceRefresh = false}) async {
    final cachedUser = await _profileApiService.getCachedProfile();
    if (cachedUser != null) {
      emit(
        ProfileState.success(
          action: ProfileAction.loadProfile,
          user: cachedUser,
        ),
      );

      final isFresh = await _profileApiService.isCachedProfileFresh();
      if (!forceRefresh && isFresh) {
        return;
      }
    } else {
      emit(const ProfileState.loading(action: ProfileAction.loadProfile));
    }

    try {
      final user = await _profileApiService.getProfile();
      emit(
        ProfileState.success(
          action: ProfileAction.loadProfile,
          user: user,
        ),
      );
    } on ServerException catch (error) {
      emit(
        ProfileState.error(
          error.message,
          action: ProfileAction.loadProfile,
          user: state.user,
        ),
      );
    } on DioException catch (error) {
      emit(
        ProfileState.error(
          error.message ?? 'Network error',
          action: ProfileAction.loadProfile,
          user: state.user,
        ),
      );
    } catch (_) {
      emit(
        ProfileState.error(
          'Failed to load profile.',
          action: ProfileAction.loadProfile,
          user: state.user,
        ),
      );
    }
  }

  Future<void> updateName({
    required String firstName,
    required String lastName,
  }) async {
    emit(ProfileState.loading(
        action: ProfileAction.updateName, user: state.user));

    try {
      final user = await _profileApiService.updateName(
        firstName: firstName,
        lastName: lastName,
      );
      emit(
        ProfileState.success(
          action: ProfileAction.updateName,
          user: user,
          message: 'Name updated successfully.',
        ),
      );
    } on ServerException catch (error) {
      emit(
        ProfileState.error(
          error.message,
          action: ProfileAction.updateName,
          user: state.user,
        ),
      );
    } on DioException catch (error) {
      emit(
        ProfileState.error(
          error.message ?? 'Network error',
          action: ProfileAction.updateName,
          user: state.user,
        ),
      );
    } catch (_) {
      emit(
        ProfileState.error(
          'Failed to update name.',
          action: ProfileAction.updateName,
          user: state.user,
        ),
      );
    }
  }

  Future<void> clearProgress() async {
    emit(ProfileState.loading(
        action: ProfileAction.clearProgress, user: state.user));

    try {
      final message = await _profileApiService.clearProgress();
      emit(
        ProfileState.success(
          action: ProfileAction.clearProgress,
          user: state.user,
          message: message,
        ),
      );
    } on ServerException catch (error) {
      emit(
        ProfileState.error(
          error.message,
          action: ProfileAction.clearProgress,
          user: state.user,
        ),
      );
    } on DioException catch (error) {
      emit(
        ProfileState.error(
          error.message ?? 'Network error',
          action: ProfileAction.clearProgress,
          user: state.user,
        ),
      );
    } catch (_) {
      emit(
        ProfileState.error(
          'Failed to clear progress.',
          action: ProfileAction.clearProgress,
          user: state.user,
        ),
      );
    }
  }

  Future<void> logout() async {
    emit(ProfileState.loading(action: ProfileAction.logout, user: state.user));

    try {
      final message = await _profileApiService.logout();
      await _sessionManager.clearAuthToken();
      await _profileApiService.clearProfileCache();
      emit(
        ProfileState.success(
          action: ProfileAction.logout,
          message: message,
        ),
      );
    } on ServerException catch (error) {
      emit(ProfileState.error(error.message, action: ProfileAction.logout));
    } on DioException catch (error) {
      emit(
        ProfileState.error(
          error.message ?? 'Network error',
          action: ProfileAction.logout,
        ),
      );
    } catch (_) {
      emit(const ProfileState.error('Failed to logout.'));
    }
  }
}
