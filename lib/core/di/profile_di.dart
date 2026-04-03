import 'package:isharaapp/core/storage/app_session_manager.dart';
import 'package:isharaapp/features/home/data/repositories/profile_repository_impl.dart';
import 'package:isharaapp/features/home/data/services/profile_api_service.dart';
import 'package:isharaapp/features/home/domain/usecases/clear_profile_progress_use_case.dart';
import 'package:isharaapp/features/home/domain/usecases/get_profile_use_case.dart';
import 'package:isharaapp/features/home/domain/usecases/logout_profile_use_case.dart';
import 'package:isharaapp/features/home/domain/usecases/update_profile_use_case.dart';
import 'package:isharaapp/features/home/presentation/cubit/profile_cubit.dart';

class ProfileDi {
  static ProfileCubit createCubit() {
    final sessionManager = AppSessionManager();
    final profileApiService = ProfileApiService(sessionManager: sessionManager);
    final repository = ProfileRepositoryImpl(
      profileApiService: profileApiService,
      sessionManager: sessionManager,
    );

    return ProfileCubit(
      profileRepository: repository,
      getProfileUseCase: GetProfileUseCase(repository),
      updateProfileUseCase: UpdateProfileUseCase(repository),
      clearProfileProgressUseCase: ClearProfileProgressUseCase(repository),
      logoutProfileUseCase: LogoutProfileUseCase(repository),
    );
  }
}
