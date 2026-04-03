import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isharaapp/features/home/domain/entities/practice/practice_level_entity.dart';
import 'package:isharaapp/features/home/domain/usecases/practice/complete_practice_lesson_use_case.dart';
import 'package:isharaapp/features/home/domain/usecases/practice/get_practice_levels_use_case.dart';

part 'practice_state.dart';

class PracticeCubit extends Cubit<PracticeState> {
  PracticeCubit({
    required GetPracticeLevelsUseCase getPracticeLevelsUseCase,
    required CompletePracticeLessonUseCase completePracticeLessonUseCase,
  })  : _getPracticeLevelsUseCase = getPracticeLevelsUseCase,
        _completePracticeLessonUseCase = completePracticeLessonUseCase,
        super(const PracticeState.initial());

  final GetPracticeLevelsUseCase _getPracticeLevelsUseCase;
  final CompletePracticeLessonUseCase _completePracticeLessonUseCase;

  void _safeEmit(PracticeState state) {
    if (!isClosed) {
      emit(state);
    }
  }

  Future<void> loadLevels({bool forceLoading = false}) async {
    final shouldShowLoader = forceLoading || state.levels.isEmpty;
    if (shouldShowLoader) {
      _safeEmit(state.copyWith(
          status: PracticeStatus.loading, action: PracticeAction.load));
    }

    final result = await _getPracticeLevelsUseCase();
    if (isClosed) {
      return;
    }

    result.fold(
      (failure) => _safeEmit(
        state.copyWith(
          status: PracticeStatus.error,
          action: PracticeAction.load,
          message: failure.message,
        ),
      ),
      (levels) => _safeEmit(
        state.copyWith(
          status: PracticeStatus.success,
          action: PracticeAction.load,
          levels: levels,
          message: null,
        ),
      ),
    );
  }

  Future<void> completeLesson(int lessonId) async {
    if (lessonId <= 0 || state.completingLessonId == lessonId) {
      return;
    }

    _safeEmit(
      state.copyWith(
        status: PracticeStatus.loading,
        action: PracticeAction.completeLesson,
        completingLessonId: lessonId,
      ),
    );

    final result = await _completePracticeLessonUseCase(lessonId: lessonId);
    if (isClosed) {
      return;
    }

    result.fold(
      (failure) => _safeEmit(
        state.copyWith(
          status: PracticeStatus.error,
          action: PracticeAction.completeLesson,
          message: failure.message,
          completingLessonId: null,
        ),
      ),
      (message) {
        final updatedLevels = state.levels
            .map((level) => _markLessonCompleted(level, lessonId))
            .toList();

        _safeEmit(
          state.copyWith(
            status: PracticeStatus.success,
            action: PracticeAction.completeLesson,
            levels: updatedLevels,
            message: message,
            completingLessonId: null,
          ),
        );
      },
    );
  }

  PracticeLevelEntity _markLessonCompleted(
      PracticeLevelEntity level, int lessonId) {
    var changed = false;

    final lessons = level.lessons.map((lesson) {
      if (lesson.id == lessonId && !lesson.isCompleted) {
        changed = true;
        return lesson.copyWith(isCompleted: true);
      }
      return lesson;
    }).toList();

    if (!changed) {
      return level;
    }

    final completed = lessons.where((lesson) => lesson.isCompleted).length;
    return level.copyWith(
      lessons: lessons,
      completedLessons: completed,
    );
  }
}
