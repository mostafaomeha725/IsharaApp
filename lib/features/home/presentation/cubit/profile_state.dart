part of 'profile_cubit.dart';

enum ProfileAction {
  none,
  loadProfile,
  updateName,
  clearProgress,
  logout,
}

enum ProfileStatus {
  initial,
  loading,
  success,
  error,
}

class ProfileState extends Equatable {
  final ProfileStatus status;
  final ProfileAction action;
  final ProfileUserModel? user;
  final String? message;

  const ProfileState({
    required this.status,
    this.action = ProfileAction.none,
    this.user,
    this.message,
  });

  const ProfileState.initial()
      : this(
          status: ProfileStatus.initial,
        );

  const ProfileState.loading({
    required ProfileAction action,
    ProfileUserModel? user,
  }) : this(
          status: ProfileStatus.loading,
          action: action,
          user: user,
        );

  const ProfileState.success({
    required ProfileAction action,
    ProfileUserModel? user,
    String? message,
  }) : this(
          status: ProfileStatus.success,
          action: action,
          user: user,
          message: message,
        );

  const ProfileState.error(
    String message, {
    ProfileAction action = ProfileAction.none,
    ProfileUserModel? user,
  }) : this(
          status: ProfileStatus.error,
          action: action,
          user: user,
          message: message,
        );

  bool get isLoading => status == ProfileStatus.loading;

  @override
  List<Object?> get props => [status, action, user, message];
}
