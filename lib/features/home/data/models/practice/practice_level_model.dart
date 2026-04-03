import 'package:isharaapp/features/home/domain/entities/practice/practice_level_entity.dart';

class PracticeLessonModel {
  const PracticeLessonModel({
    required this.id,
    required this.title,
    required this.isCompleted,
  });

  final int id;
  final String title;
  final bool isCompleted;

  factory PracticeLessonModel.fromJson(Map<String, dynamic> json) {
    final status = json['status']?.toString().toLowerCase();

    return PracticeLessonModel(
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

  PracticeLessonEntity toEntity() {
    return PracticeLessonEntity(
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

class PracticeLevelModel {
  const PracticeLevelModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.lessons,
    required this.completedLessons,
  });

  final int id;
  final String title;
  final String subtitle;
  final List<PracticeLessonModel> lessons;
  final int completedLessons;

  factory PracticeLevelModel.fromJson(Map<String, dynamic> json) {
    final lessonsJson = json['lessons'];
    final lessons = lessonsJson is List
        ? lessonsJson
            .whereType<Map>()
            .map((item) =>
                PracticeLessonModel.fromJson(Map<String, dynamic>.from(item)))
            .toList()
        : const <PracticeLessonModel>[];

    final completedFromApi = (json['completed_lessons'] as num?)?.toInt();
    final completedFromLessons =
        lessons.where((lesson) => lesson.isCompleted).length;

    return PracticeLevelModel(
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

  PracticeLevelEntity toEntity() {
    return PracticeLevelEntity(
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
