import 'package:equatable/equatable.dart';

class PracticeLessonEntity extends Equatable {
  const PracticeLessonEntity({
    required this.id,
    required this.title,
    required this.isCompleted,
  });

  final int id;
  final String title;
  final bool isCompleted;

  PracticeLessonEntity copyWith({
    int? id,
    String? title,
    bool? isCompleted,
  }) {
    return PracticeLessonEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  @override
  List<Object?> get props => [id, title, isCompleted];
}

class PracticeLevelEntity extends Equatable {
  const PracticeLevelEntity({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.lessons,
    required this.completedLessons,
  });

  final int id;
  final String title;
  final String subtitle;
  final List<PracticeLessonEntity> lessons;
  final int completedLessons;

  int get totalLessons => lessons.length;

  double get progress {
    if (totalLessons == 0) {
      return 0;
    }
    return completedLessons / totalLessons;
  }

  PracticeLevelEntity copyWith({
    int? id,
    String? title,
    String? subtitle,
    List<PracticeLessonEntity>? lessons,
    int? completedLessons,
  }) {
    return PracticeLevelEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      lessons: lessons ?? this.lessons,
      completedLessons: completedLessons ?? this.completedLessons,
    );
  }

  @override
  List<Object?> get props => [id, title, subtitle, lessons, completedLessons];
}
