import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isharaapp/features/home/domain/entities/test/test_level_entity.dart';
import 'package:isharaapp/features/home/domain/usecases/test/complete_test_word_use_case.dart';
import 'package:isharaapp/features/home/domain/usecases/test/get_test_levels_use_case.dart';

part 'test_api_state.dart';

class TestApiCubit extends Cubit<TestApiState> {
  TestApiCubit({
    required GetTestLevelsUseCase getTestLevelsUseCase,
    required CompleteTestWordUseCase completeTestWordUseCase,
  })  : _getTestLevelsUseCase = getTestLevelsUseCase,
        _completeTestWordUseCase = completeTestWordUseCase,
        super(const TestApiState.initial());

  final GetTestLevelsUseCase _getTestLevelsUseCase;
  final CompleteTestWordUseCase _completeTestWordUseCase;

  void _safeEmit(TestApiState state) {
    if (!isClosed) {
      emit(state);
    }
  }

  Future<void> loadLevels({bool forceLoading = false}) async {
    final shouldShowLoader = forceLoading || state.levels.isEmpty;
    if (shouldShowLoader) {
      _safeEmit(state.copyWith(
          status: TestApiStatus.loading, action: TestApiAction.load));
    }

    final result = await _getTestLevelsUseCase();
    if (isClosed) {
      return;
    }

    result.fold(
      (failure) => _safeEmit(
        state.copyWith(
          status: TestApiStatus.error,
          action: TestApiAction.load,
          message: failure.message,
        ),
      ),
      (levels) => _safeEmit(
        state.copyWith(
          status: TestApiStatus.success,
          action: TestApiAction.load,
          levels: levels,
          message: null,
        ),
      ),
    );
  }

  Future<void> completeWord(int wordId) async {
    if (wordId <= 0 || state.completingWordId == wordId) {
      return;
    }

    _safeEmit(
      state.copyWith(
        status: TestApiStatus.loading,
        action: TestApiAction.completeWord,
        completingWordId: wordId,
      ),
    );

    final result = await _completeTestWordUseCase(wordId: wordId);
    if (isClosed) {
      return;
    }

    result.fold(
      (failure) => _safeEmit(
        state.copyWith(
          status: TestApiStatus.error,
          action: TestApiAction.completeWord,
          message: failure.message,
          completingWordId: null,
        ),
      ),
      (message) {
        final updatedLevels = state.levels
            .map((level) => _markWordCompleted(level, wordId))
            .toList();

        _safeEmit(
          state.copyWith(
            status: TestApiStatus.success,
            action: TestApiAction.completeWord,
            levels: updatedLevels,
            message: message,
            completingWordId: null,
          ),
        );
      },
    );
  }

  TestLevelEntity _markWordCompleted(TestLevelEntity level, int wordId) {
    var changed = false;

    final words = level.words.map((word) {
      if (word.id == wordId && !word.isCompleted) {
        changed = true;
        return word.copyWith(isCompleted: true);
      }
      return word;
    }).toList();

    if (!changed) {
      return level;
    }

    final completed = words.where((word) => word.isCompleted).length;
    return level.copyWith(
      words: words,
      completedWords: completed,
    );
  }
}
