import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isharaapp/core/storage/app_session_manager.dart';
import 'package:isharaapp/features/splash/presentation/cubit/splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(const SplashState());

  final AppSessionManager _sessionManager = AppSessionManager();

  /// Minimum time the splash logo stays visible before we can navigate.
  static const _minDisplayDuration = Duration(milliseconds: 2000);

  Future<void> initialize() async {
    emit(state.copyWith(status: SplashStatus.loading));

    try {
      bool onboardingSeen = false;
      bool hasAuthToken = false;

      // Run session checks and the minimum display timer in parallel.
      await Future.wait([
        () async { onboardingSeen = await _sessionManager.isOnboardingSeen(); }(),
        () async { hasAuthToken = await _sessionManager.hasAuthToken(); }(),
        Future.delayed(_minDisplayDuration),
      ]);

      emit(
        state.copyWith(
          status: SplashStatus.ready,
          onboardingSeen: onboardingSeen,
          hasAuthToken: hasAuthToken,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: SplashStatus.error, errorMessage: e.toString()));
    }
  }
}
