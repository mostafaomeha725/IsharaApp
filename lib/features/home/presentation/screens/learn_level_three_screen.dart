import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isharaapp/core/theme/styles.dart';
import 'package:isharaapp/core/widgets/custom_text.dart';
import 'package:isharaapp/features/home/presentation/screens/widgets/course_card.dart';

class LearnLevelThreeScreen extends StatelessWidget {
  const LearnLevelThreeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: [
          SizedBox(
            height: 8.h,
          ),
          AppText('letters G,H,M,N,X',
              style: font16w700.copyWith(color: Colors.white),
              alignment: AlignmentDirectional.center),
          SizedBox(
            height: 8.h,
          ),
          const CourseCard(
              title: 'level Three',
              subtitle: 'Letter G',
              completetext: '0 of 1 Completed',
              value: 0),
          const CourseCard(
              title: 'level Three',
              subtitle: 'Letter H',
              completetext: '0 of 1 Completed',
              value: 0),
          const CourseCard(
              title: 'level Three',
              subtitle: 'Letter M',
              completetext: '0 of 1 Completed',
              value: 0),
          const CourseCard(
              title: 'level Three',
              subtitle: 'Letter N',
              completetext: '0 of 1 Completed',
              value: 0),
          const CourseCard(
              title: 'level Three',
              subtitle: 'Letter X',
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
