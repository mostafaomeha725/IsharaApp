part of 'learn_cubit.dart';

enum LearnStatus {
  initial,
  loading,
  success,
  error,
}

enum LearnAction {
  none,
  load,
  completeLesson,
}

class LearnState extends Equatable {
  const LearnState({
    required this.status,
    required this.action,
    required this.levels,
    this.message,
    this.completingLessonId,
  });

  const LearnState.initial()
      : status = LearnStatus.initial,
        action = LearnAction.none,
        levels = const <LearnLevelEntity>[],
        message = null,
        completingLessonId = null;

  final LearnStatus status;
  final LearnAction action;
  final List<LearnLevelEntity> levels;
  final String? message;
  final int? completingLessonId;

  LearnState copyWith({
    LearnStatus? status,
    LearnAction? action,
    List<LearnLevelEntity>? levels,
    String? message,
    bool clearMessage = false,
    int? completingLessonId,
  }) {
    return LearnState(
      status: status ?? this.status,
      action: action ?? this.action,
      levels: levels ?? this.levels,
      message: clearMessage ? null : message ?? this.message,
      completingLessonId: completingLessonId,
    );
  }

  @override
  List<Object?> get props => [
        status,
        action,
        levels,
        message,
        completingLessonId,
      ];
}
