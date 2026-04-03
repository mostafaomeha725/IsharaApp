import 'package:equatable/equatable.dart';

class LearnLessonEntity extends Equatable {
  const LearnLessonEntity({
    required this.id,
    required this.title,
    required this.isCompleted,
  });

  final int id;
  final String title;
  final bool isCompleted;

  LearnLessonEntity copyWith({
    int? id,
    String? title,
    bool? isCompleted,
  }) {
    return LearnLessonEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  @override
  List<Object?> get props => [id, title, isCompleted];
}

class LearnLevelEntity extends Equatable {
  const LearnLevelEntity({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.lessons,
    required this.completedLessons,
  });

  final int id;
  final String title;
  final String subtitle;
  final List<LearnLessonEntity> lessons;
  final int completedLessons;

  int get totalLessons => lessons.length;

  double get progress {
    if (totalLessons == 0) {
      return 0;
    }
    return completedLessons / totalLessons;
  }

  LearnLevelEntity copyWith({
    int? id,
    String? title,
    String? subtitle,
    List<LearnLessonEntity>? lessons,
    int? completedLessons,
  }) {
    return LearnLevelEntity(
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
