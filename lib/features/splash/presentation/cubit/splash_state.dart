enum SplashStatus { loading, ready, error }

class SplashState {
  const SplashState({
    this.status = SplashStatus.loading,
    this.errorMessage,
    this.onboardingSeen = false,
    this.hasAuthToken = false,
  });

  final SplashStatus status;
  final String? errorMessage;
  final bool onboardingSeen;
  final bool hasAuthToken;

  SplashState copyWith({
    SplashStatus? status,
    String? errorMessage,
    bool? onboardingSeen,
    bool? hasAuthToken,
  }) {
    return SplashState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      onboardingSeen: onboardingSeen ?? this.onboardingSeen,
      hasAuthToken: hasAuthToken ?? this.hasAuthToken,
    );
  }
}
