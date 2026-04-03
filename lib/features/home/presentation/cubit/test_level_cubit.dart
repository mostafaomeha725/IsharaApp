import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isharaapp/features/home/presentation/cubit/test_level_state.dart';

class TestLevelCubit extends Cubit<TestLevelState> {
  TestLevelCubit() : super(TestLevelState.initial());

  static const Duration _transitionDelay = Duration(milliseconds: 500);

  Timer? _transitionTimer;

  void setLoading() {
    emit(state.copyWith(
      viewStatus: TestLevelViewStatus.loading,
      clearErrorMessage: true,
    ));
  }

  void setReady() {
    emit(state.copyWith(
      viewStatus: TestLevelViewStatus.ready,
      clearErrorMessage: true,
    ));
  }

  void setFailure(String message) {
    emit(state.copyWith(
      viewStatus: TestLevelViewStatus.failure,
      errorMessage: message,
      statusMessage: message,
      statusColor: Colors.red,
      isSuccess: false,
    ));
  }

  void onDetection({
    required String detectedLabel,
    required String cleanWord,
  }) {
    if (state.isLevelCompleted || state.currentIndex >= cleanWord.length) {
      return;
    }

    final String targetChar = cleanWord[state.currentIndex];

    if (detectedLabel != targetChar) {
      emit(state.copyWith(
        viewStatus: TestLevelViewStatus.ready,
        statusMessage: "Wrong",
        statusColor: Colors.red,
        isSuccess: false,
        clearErrorMessage: true,
      ));
      return;
    }

    emit(state.copyWith(
      viewStatus: TestLevelViewStatus.ready,
      statusMessage: 'Excellent!',
      statusColor: Colors.green,
      isSuccess: true,
      clearErrorMessage: true,
    ));

    _scheduleNextCharacter(cleanWord);
  }

  void markNoHandFound() {
    emit(state.copyWith(
      viewStatus: TestLevelViewStatus.ready,
      statusMessage: 'No Hand Found',
      statusColor: Colors.orange,
      isSuccess: false,
      clearErrorMessage: true,
    ));
  }

  void _scheduleNextCharacter(String cleanWord) {
    if (_transitionTimer != null && _transitionTimer!.isActive) return;

    _transitionTimer = Timer(_transitionDelay, () {
      final nextIndex = state.currentIndex + 1;

      if (nextIndex >= cleanWord.length) {
        emit(state.copyWith(
          viewStatus: TestLevelViewStatus.completed,
          currentIndex: nextIndex,
          isLevelCompleted: true,
          statusMessage: _completionStatusMessage(cleanWord),
          statusColor: Colors.blue,
          isSuccess: false,
          clearErrorMessage: true,
        ));
        return;
      }

      emit(state.copyWith(
        viewStatus: TestLevelViewStatus.ready,
        currentIndex: nextIndex,
        statusMessage: 'Next: ${cleanWord[nextIndex]}',
        statusColor: Colors.orange,
        isSuccess: false,
        clearErrorMessage: true,
      ));
    });
  }

  String _completionStatusMessage(String cleanWord) {
    return cleanWord.length <= 1 ? 'LETTER COMPLETE!' : 'WORD COMPLETE!';
  }

  @override
  Future<void> close() {
    _transitionTimer?.cancel();
    return super.close();
  }
}
