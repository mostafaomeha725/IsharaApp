import 'package:equatable/equatable.dart';

class TestWordEntity extends Equatable {
  const TestWordEntity({
    required this.id,
    required this.word,
    required this.isCompleted,
  });

  final int id;
  final String word;
  final bool isCompleted;

  TestWordEntity copyWith({
    int? id,
    String? word,
    bool? isCompleted,
  }) {
    return TestWordEntity(
      id: id ?? this.id,
      word: word ?? this.word,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  @override
  List<Object?> get props => [id, word, isCompleted];
}

class TestLevelEntity extends Equatable {
  const TestLevelEntity({
    required this.id,
    required this.title,
    required this.words,
    required this.completedWords,
  });

  final int id;
  final String title;
  final List<TestWordEntity> words;
  final int completedWords;

  int get totalWords => words.length;

  double get progress {
    if (totalWords == 0) {
      return 0;
    }
    return completedWords / totalWords;
  }

  TestLevelEntity copyWith({
    int? id,
    String? title,
    List<TestWordEntity>? words,
    int? completedWords,
  }) {
    return TestLevelEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      words: words ?? this.words,
      completedWords: completedWords ?? this.completedWords,
    );
  }

  @override
  List<Object?> get props => [id, title, words, completedWords];
}
