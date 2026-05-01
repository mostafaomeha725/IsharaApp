import 'package:isharaapp/features/home/domain/entities/learn_level_entity.dart';

class LearnHelper {
  static List<String> buildLessonItems(LearnLevelEntity level) {
    return level.lessons
        .asMap()
        .entries
        .map((entry) => lessonItemLabel(entry.value.title, entry.key))
        .toList();
  }

  static Map<String, int> buildLessonIdMap(LearnLevelEntity level) {
    final result = <String, int>{};
    for (var i = 0; i < level.lessons.length; i++) {
      final lesson = level.lessons[i];
      result[lessonItemLabel(lesson.title, i)] = lesson.id;
    }
    return result;
  }

  static Set<String> buildCompletedItems(LearnLevelEntity level) {
    final result = <String>{};
    for (var i = 0; i < level.lessons.length; i++) {
      final lesson = level.lessons[i];
      if (lesson.isCompleted) {
        result.add(lessonItemLabel(lesson.title, i));
      }
    }
    return result;
  }

  static String lessonItemLabel(String raw, int index) {
    final value = raw.trim();
    if (value.isEmpty) {
      return 'L${index + 1}';
    }

    final parts = value.split(RegExp(r'\s+'));
    return parts.last.toUpperCase();
  }
}
