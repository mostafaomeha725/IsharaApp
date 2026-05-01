import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isharaapp/core/constants/app_assets.dart';
import 'package:isharaapp/features/home/presentation/screens/widgets/course_card.dart';

class LearnFallbackCards extends StatelessWidget {
  final void Function(int) onGoTo;

  const LearnFallbackCards({super.key, required this.onGoTo});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CourseCard(
          title: 'Level One',
          assetName: Assets.catonbooks,
          subtitle: 'letters A B C E L O V W U Y',
          completetext: '0 of 10 completed',
          value: 0.0,
          onTap: () => onGoTo(2),
          isPractice: true,
          showBadgeImage: true,
        ),
        SizedBox(height: 38.h),
        CourseCard(
          title: 'Level Two',
          subtitle: 'letters D F K R S I T',
          completetext: '0 of 7 completed',
          value: 0.0,
          onTap: () => onGoTo(3),
          isPractice: true,
          showBadgeImage: true,
          assetName: Assets.boylookingglobal,
        ),
        SizedBox(height: 38.h),
        CourseCard(
          title: 'Level Three',
          subtitle: 'letters G H M N X',
          completetext: '0 of 5 completed',
          value: 0.0,
          onTap: () => onGoTo(4),
          isPractice: true,
          showBadgeImage: true,
          assetName: Assets.booksandcup,
        ),
        SizedBox(height: 38.h),
        CourseCard(
          title: 'Level Four',
          subtitle: 'letters P Q Z J',
          completetext: '0 of 4 completed',
          value: 0.0,
          onTap: () => onGoTo(5),
          isPractice: true,
          showBadgeImage: true,
          assetName: Assets.stackofbooks,
        ),
      ],
    );
  }
}
