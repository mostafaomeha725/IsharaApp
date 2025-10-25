import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isharaapp/core/theme/styles.dart';
import 'package:isharaapp/core/widgets/custom_text.dart';
import 'package:isharaapp/features/home/presentation/screens/widgets/course_card.dart';

class LearnLevelFourScreen extends StatelessWidget {
  const LearnLevelFourScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: [
          SizedBox(
            height: 8.h,
          ),
          AppText('letters P,Q,Z,J',
              style: font16w700, alignment: AlignmentDirectional.center),
          SizedBox(
            height: 8.h,
          ),
          const CourseCard(
              title: 'level Four',
              subtitle: 'Letter P',
              completetext: '0 of 1 Completed',
              value: 0),
          const CourseCard(
              title: 'level Four',
              subtitle: 'Letter Q',
              completetext: '0 of 1 Completed',
              value: 0),
          const CourseCard(
              title: 'level Four',
              subtitle: 'Letter Z',
              completetext: '0 of 1 Completed',
              value: 0),
          const CourseCard(
              title: 'level Four',
              subtitle: 'Letter J',
              completetext: '0 of 1 Completed',
              value: 0),
          SizedBox(
            height: 16.h,
          )
        ],
      ),
    );
  }
}
