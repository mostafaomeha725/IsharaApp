import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isharaapp/core/constants/app_assets.dart';
import 'package:isharaapp/features/home/domain/entities/practice/practice_level_entity.dart';
import 'package:isharaapp/features/home/presentation/screens/widgets/course_card.dart';

import 'practice_helper.dart';

class PracticeApiCards extends StatelessWidget {
  final List<PracticeLevelEntity> levels;
  final void Function(int) onSelect;

  static const List<String> _levelCardAssets = <String>[
    Assets.catonbooks,
    Assets.boylookingglobal,
    Assets.booksandcup,
    Assets.stackofbooks,
  ];

  const PracticeApiCards({
    super.key,
    required this.levels,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final widgets = <Widget>[];
    final maxCards = levels.length > 4 ? 4 : levels.length;

    for (var i = 0; i < maxCards; i++) {
      final level = levels[i];
      final labels = level.lessons
          .map((lesson) => PracticeHelper.normalizeLabel(lesson.title));

      widgets.add(
        CourseCard(
          title: level.title.isEmpty ? 'Level ${i + 1}' : level.title,
          subtitle: level.subtitle.isNotEmpty
              ? level.subtitle
              : 'letters ${labels.join(' ')}',
          completetext:
              '${level.completedLessons} of ${level.totalLessons} completed',
          value: level.progress.clamp(0, 1).toDouble(),
          isPractice: true,
          showBadgeImage: true,
          assetName: _levelCardAssets[i],
          onTap: () => onSelect(i),
        ),
      );

      if (i != maxCards - 1) {
        widgets.add(SizedBox(height: 38.h));
      }
    }

    return Column(children: widgets);
  }
}
