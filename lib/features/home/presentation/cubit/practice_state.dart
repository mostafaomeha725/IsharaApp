part of 'practice_cubit.dart';

enum PracticeStatus {
  initial,
  loading,
  success,
  error,
}

enum PracticeAction {
  none,
  load,
  completeLesson,
}

class PracticeState extends Equatable {
  const PracticeState({
    required this.status,
    required this.action,
    required this.levels,
    this.message,
    this.completingLessonId,
  });

  const PracticeState.initial()
      : status = PracticeStatus.initial,
        action = PracticeAction.none,
        levels = const <PracticeLevelEntity>[],
        message = null,
        completingLessonId = null;

  final PracticeStatus status;
  final PracticeAction action;
  final List<PracticeLevelEntity> levels;
  final String? message;
  final int? completingLessonId;

  PracticeState copyWith({
    PracticeStatus? status,
    PracticeAction? action,
    List<PracticeLevelEntity>? levels,
    String? message,
    int? completingLessonId,
  }) {
    return PracticeState(
      status: status ?? this.status,
      action: action ?? this.action,
      levels: levels ?? this.levels,
      message: message,
      completingLessonId: completingLessonId,
    );
  }

  @override
  List<Object?> get props =>
      [status, action, levels, message, completingLessonId];
}
