import 'package:isharaapp/features/home/domain/entities/test/test_level_entity.dart';

class TestWordModel {
  const TestWordModel({
    required this.id,
    required this.word,
    required this.isCompleted,
  });

  final int id;
  final String word;
  final bool isCompleted;

  factory TestWordModel.fromJson(Map<String, dynamic> json) {
    final status = json['status']?.toString().toLowerCase();

    return TestWordModel(
      id: (json['id'] as num?)?.toInt() ??
          (json['word_id'] as num?)?.toInt() ??
          0,
      word: json['word']?.toString() ??
          json['title']?.toString() ??
          json['name']?.toString() ??
          '',
      isCompleted: json['is_completed'] == true ||
          json['completed'] == true ||
          status == 'completed',
    );
  }

  TestWordEntity toEntity() {
    return TestWordEntity(
      id: id,
      word: word,
      isCompleted: isCompleted,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'word': word,
      'is_completed': isCompleted,
    };
  }
}

class TestLevelModel {
  const TestLevelModel({
    required this.id,
    required this.title,
    required this.words,
    required this.completedWords,
  });

  final int id;
  final String title;
  final List<TestWordModel> words;
  final int completedWords;

  factory TestLevelModel.fromJson(Map<String, dynamic> json) {
    final wordsNode = json['words'] ?? json['lessons'];
    final words = wordsNode is List
        ? wordsNode
            .whereType<Map>()
            .map((item) =>
                TestWordModel.fromJson(Map<String, dynamic>.from(item)))
            .toList()
        : const <TestWordModel>[];

    final completedFromApi = (json['completed_words'] as num?)?.toInt() ??
        (json['completed_lessons'] as num?)?.toInt();
    final completedFromItems = words.where((item) => item.isCompleted).length;

    return TestLevelModel(
      id: (json['id'] as num?)?.toInt() ??
          (json['level_id'] as num?)?.toInt() ??
          0,
      title: json['title']?.toString() ?? json['name']?.toString() ?? 'Level',
      words: words,
      completedWords: completedFromApi ?? completedFromItems,
    );
  }

  TestLevelEntity toEntity() {
    return TestLevelEntity(
      id: id,
      title: title,
      words: words.map((item) => item.toEntity()).toList(),
      completedWords: completedWords,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'completed_words': completedWords,
      'words': words.map((item) => item.toJson()).toList(),
    };
  }
}
