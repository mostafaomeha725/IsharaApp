import 'package:flutter/material.dart';

enum TestLevelViewStatus {
  initial,
  loading,
  ready,
  failure,
  completed,
}

class TestLevelState {
  const TestLevelState({
    required this.viewStatus,
    required this.currentIndex,
    required this.isLevelCompleted,
    required this.statusMessage,
    required this.statusColor,
    required this.isSuccess,
    this.errorMessage,
  });

  factory TestLevelState.initial() {
    return const TestLevelState(
      viewStatus: TestLevelViewStatus.initial,
      currentIndex: 0,
      isLevelCompleted: false,
      statusMessage: 'Ready...',
      statusColor: Colors.white,
      isSuccess: false,
      errorMessage: null,
    );
  }

  final TestLevelViewStatus viewStatus;
  final int currentIndex;
  final bool isLevelCompleted;
  final String statusMessage;
  final Color statusColor;
  final bool isSuccess;
  final String? errorMessage;

  TestLevelState copyWith({
    TestLevelViewStatus? viewStatus,
    int? currentIndex,
    bool? isLevelCompleted,
    String? statusMessage,
    Color? statusColor,
    bool? isSuccess,
    String? errorMessage,
    bool clearErrorMessage = false,
  }) {
    return TestLevelState(
      viewStatus: viewStatus ?? this.viewStatus,
      currentIndex: currentIndex ?? this.currentIndex,
      isLevelCompleted: isLevelCompleted ?? this.isLevelCompleted,
      statusMessage: statusMessage ?? this.statusMessage,
      statusColor: statusColor ?? this.statusColor,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage:
          clearErrorMessage ? null : (errorMessage ?? this.errorMessage),
    );
  }
}
