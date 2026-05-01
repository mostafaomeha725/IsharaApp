import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isharaapp/core/constants/app_assets.dart';
import 'package:isharaapp/features/home/presentation/screens/widgets/course_card.dart';

class PracticeFallbackCards extends StatelessWidget {
  final void Function(int) onSelect;

  const PracticeFallbackCards({super.key, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CourseCard(
          title: 'Level One',
          subtitle: 'letters A B C E L O V W U Y',
          completetext: '0 of 10 completed',
          value: 0.0,
          isPractice: true,
          assetName: Assets.catonbooks,
          showBadgeImage: true,
          onTap: () => onSelect(0),
        ),
        SizedBox(height: 38.h),
        CourseCard(
          title: 'Level Two',
          subtitle: 'letters D F K R S I T',
          completetext: '0 of 7 completed',
          value: 0.0,
          isPractice: true,
          showBadgeImage: true,
          assetName: Assets.boylookingglobal,
          onTap: () => onSelect(1),
        ),
        SizedBox(height: 38.h),
        CourseCard(
          title: 'Level Three',
          subtitle: 'letters G H M N X',
          completetext: '0 of 5 completed',
          value: 0.0,
          isPractice: true,
          showBadgeImage: true,
          assetName: Assets.booksandcup,
          onTap: () => onSelect(2),
        ),
        SizedBox(height: 38.h),
        CourseCard(
          title: 'Level Four',
          subtitle: 'letters P Q Z J',
          completetext: '0 of 4 completed',
          value: 0.0,
          isPractice: true,
          showBadgeImage: true,
          assetName: Assets.stackofbooks,
          onTap: () => onSelect(3),
        ),
      ],
    );
  }
}
