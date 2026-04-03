import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isharaapp/features/home/domain/entities/learn_level_entity.dart';
import 'package:isharaapp/features/home/domain/usecases/complete_lesson_use_case.dart';
import 'package:isharaapp/features/home/domain/usecases/get_learn_levels_use_case.dart';

part 'learn_state.dart';

class LearnCubit extends Cubit<LearnState> {
  LearnCubit({
    required GetLearnLevelsUseCase getLearnLevelsUseCase,
    required CompleteLessonUseCase completeLessonUseCase,
  })  : _getLearnLevelsUseCase = getLearnLevelsUseCase,
        _completeLessonUseCase = completeLessonUseCase,
        super(const LearnState.initial());

  final GetLearnLevelsUseCase _getLearnLevelsUseCase;
  final CompleteLessonUseCase _completeLessonUseCase;

  void _safeEmit(LearnState state) {
    if (!isClosed) {
      emit(state);
    }
  }

  Future<void> loadLevels({bool forceLoading = false}) async {
    final shouldShowLoader = forceLoading || state.levels.isEmpty;
    if (shouldShowLoader) {
      _safeEmit(state.copyWith(
          status: LearnStatus.loading, action: LearnAction.load));
    }

    final result = await _getLearnLevelsUseCase();
    if (isClosed) {
      return;
    }

    result.fold(
      (failure) => _safeEmit(
        state.copyWith(
          status: LearnStatus.error,
          action: LearnAction.load,
          message: failure.message,
        ),
      ),
      (levels) => _safeEmit(
        state.copyWith(
          status: LearnStatus.success,
          action: LearnAction.load,
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
        status: LearnStatus.loading,
        action: LearnAction.completeLesson,
        completingLessonId: lessonId,
      ),
    );

    final result = await _completeLessonUseCase(lessonId: lessonId);
    if (isClosed) {
      return;
    }

    result.fold(
      (failure) => _safeEmit(
        state.copyWith(
          status: LearnStatus.error,
          action: LearnAction.completeLesson,
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
            status: LearnStatus.success,
            action: LearnAction.completeLesson,
            levels: updatedLevels,
            message: message,
            completingLessonId: null,
          ),
        );
      },
    );
  }

  LearnLevelEntity _markLessonCompleted(LearnLevelEntity level, int lessonId) {
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
