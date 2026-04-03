part of 'test_api_cubit.dart';

enum TestApiStatus {
  initial,
  loading,
  success,
  error,
}

enum TestApiAction {
  none,
  load,
  completeWord,
}

class TestApiState extends Equatable {
  const TestApiState({
    required this.status,
    required this.action,
    required this.levels,
    this.message,
    this.completingWordId,
  });

  const TestApiState.initial()
      : status = TestApiStatus.initial,
        action = TestApiAction.none,
        levels = const <TestLevelEntity>[],
        message = null,
        completingWordId = null;

  final TestApiStatus status;
  final TestApiAction action;
  final List<TestLevelEntity> levels;
  final String? message;
  final int? completingWordId;

  TestApiState copyWith({
    TestApiStatus? status,
    TestApiAction? action,
    List<TestLevelEntity>? levels,
    String? message,
    int? completingWordId,
  }) {
    return TestApiState(
      status: status ?? this.status,
      action: action ?? this.action,
      levels: levels ?? this.levels,
      message: message,
      completingWordId: completingWordId,
    );
  }

  @override
  List<Object?> get props =>
      [status, action, levels, message, completingWordId];
}
