import 'package:isharaapp/features/home/domain/entities/learn_level_entity.dart';

class LearnLessonModel {
  const LearnLessonModel({
    required this.id,
    required this.title,
    required this.isCompleted,
  });

  final int id;
  final String title;
  final bool isCompleted;

  LearnLessonModel copyWith({
    int? id,
    String? title,
    bool? isCompleted,
  }) {
    return LearnLessonModel(
      id: id ?? this.id,
      title: title ?? this.title,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  factory LearnLessonModel.fromJson(Map<String, dynamic> json) {
    final status = json['status']?.toString().toLowerCase();

    return LearnLessonModel(
      id: (json['id'] as num?)?.toInt() ??
          (json['lesson_id'] as num?)?.toInt() ??
          0,
      title: json['title']?.toString() ??
          json['name']?.toString() ??
          json['letter']?.toString() ??
          'Lesson',
      isCompleted: json['is_completed'] == true ||
          json['completed'] == true ||
          status == 'completed',
    );
  }

  LearnLessonEntity toEntity() {
    return LearnLessonEntity(
      id: id,
      title: title,
      isCompleted: isCompleted,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'is_completed': isCompleted,
    };
  }
}

class LearnLevelModel {
  const LearnLevelModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.lessons,
    required this.completedLessons,
  });

  final int id;
  final String title;
  final String subtitle;
  final List<LearnLessonModel> lessons;
  final int completedLessons;

  int get totalLessons => lessons.length;

  double get progress {
    if (totalLessons == 0) {
      return 0;
    }
    return completedLessons / totalLessons;
  }

  LearnLevelModel copyWith({
    int? id,
    String? title,
    String? subtitle,
    List<LearnLessonModel>? lessons,
    int? completedLessons,
  }) {
    return LearnLevelModel(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      lessons: lessons ?? this.lessons,
      completedLessons: completedLessons ?? this.completedLessons,
    );
  }

  factory LearnLevelModel.fromJson(Map<String, dynamic> json) {
    final lessonsJson = json['lessons'];
    final lessons = lessonsJson is List
        ? lessonsJson
            .whereType<Map>()
            .map((item) =>
                LearnLessonModel.fromJson(Map<String, dynamic>.from(item)))
            .toList()
        : const <LearnLessonModel>[];

    final completedFromApi = (json['completed_lessons'] as num?)?.toInt();
    final completedFromLessons =
        lessons.where((lesson) => lesson.isCompleted).length;

    return LearnLevelModel(
      id: (json['id'] as num?)?.toInt() ??
          (json['level_id'] as num?)?.toInt() ??
          0,
      title: json['title']?.toString() ?? json['name']?.toString() ?? 'Level',
      subtitle:
          json['subtitle']?.toString() ?? json['description']?.toString() ?? '',
      lessons: lessons,
      completedLessons: completedFromApi ?? completedFromLessons,
    );
  }

  LearnLevelEntity toEntity() {
    return LearnLevelEntity(
      id: id,
      title: title,
      subtitle: subtitle,
      lessons: lessons.map((item) => item.toEntity()).toList(),
      completedLessons: completedLessons,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'subtitle': subtitle,
      'completed_lessons': completedLessons,
      'lessons': lessons.map((item) => item.toJson()).toList(),
    };
  }
}
