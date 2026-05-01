import 'package:isharaapp/features/home/domain/entities/practice/practice_level_entity.dart';

class PracticeHelper {
  static String normalizeLabel(String raw) {
    final value = raw.trim();
    if (value.isEmpty) {
      return '-';
    }
    return value.split(RegExp(r'\s+')).last.toUpperCase();
  }

  static List<String>? getItems(PracticeLevelEntity? level) {
    if (level == null) return null;
    return level.lessons.map((item) => normalizeLabel(item.title)).toList();
  }

  static Map<String, int> getIdsByItem(PracticeLevelEntity? level) {
    if (level == null) return const <String, int>{};
    return {
      for (final lesson in level.lessons)
        normalizeLabel(lesson.title): lesson.id,
    };
  }

  static Set<String> getCompletedItems(PracticeLevelEntity? level) {
    if (level == null) return const <String>{};
    return {
      for (final lesson in level.lessons)
        if (lesson.isCompleted) normalizeLabel(lesson.title),
    };
  }
}
