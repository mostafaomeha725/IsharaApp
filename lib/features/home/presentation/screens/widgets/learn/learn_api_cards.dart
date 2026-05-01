import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isharaapp/core/constants/app_assets.dart';
import 'package:isharaapp/features/home/domain/entities/learn_level_entity.dart';
import 'package:isharaapp/features/home/presentation/screens/widgets/course_card.dart';
import 'learn_helper.dart';

class LearnApiCards extends StatelessWidget {
  final List<LearnLevelEntity> levels;
  final void Function(int) onGoTo;

  static const List<String> _levelCardAssets = <String>[
    Assets.catonbooks,
    Assets.boylookingglobal,
    Assets.booksandcup,
    Assets.stackofbooks,
  ];

  const LearnApiCards({super.key, required this.levels, required this.onGoTo});

  @override
  Widget build(BuildContext context) {
    final cards = <Widget>[];
    final maxCards = levels.length > 4 ? 4 : levels.length;

    for (var i = 0; i < maxCards; i++) {
      final level = levels[i];
      final subtitle = level.subtitle.isNotEmpty
          ? level.subtitle
          : 'letters ${LearnHelper.buildLessonItems(level).join(' ')}';

      cards.add(
        CourseCard(
          title: level.title.isEmpty ? 'Level ${i + 1}' : level.title,
          subtitle: subtitle,
          completetext:
              '${level.completedLessons} of ${level.totalLessons} completed',
          value: level.progress.clamp(0, 1).toDouble(),
          onTap: () => onGoTo(i + 2),
          isPractice: true,
          showBadgeImage: true,
          assetName: _levelCardAssets[i],
        ),
      );

      if (i != maxCards - 1) {
        cards.add(SizedBox(height: 38.h));
      }
    }

    return Column(children: cards);
  }
}
