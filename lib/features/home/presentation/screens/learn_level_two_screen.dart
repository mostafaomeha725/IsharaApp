import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isharaapp/core/theme/styles.dart';
import 'package:isharaapp/core/widgets/custom_text.dart';
import 'package:isharaapp/features/home/presentation/screens/widgets/course_card.dart';

class LearnLevelTwoScreen extends StatelessWidget {
  const LearnLevelTwoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            SizedBox(
              height: 8.h,
            ),
            AppText('letters D,F,K,R,S,I,T',
                style: font16w700.copyWith(color: Colors.white),
                alignment: AlignmentDirectional.center),
            SizedBox(
              height: 8.h,
            ),
            const CourseCard(
                title: 'level Two',
                subtitle: 'Letter D',
                completetext: '0 of 1 Completed',
                value: 0),
            const CourseCard(
                title: 'level Two',
                subtitle: 'Letter F',
                completetext: '0 of 1 Completed',
                value: 0),
            const CourseCard(
                title: 'level Two',
                subtitle: 'Letter K',
                completetext: '0 of 1 Completed',
                value: 0),
            const CourseCard(
                title: 'level Two',
                subtitle: 'Letter R',
                completetext: '0 of 1 Completed',
                value: 0),
            const CourseCard(
                title: 'level Two',
                subtitle: 'Letter S',
                completetext: '0 of 1 Completed',
                value: 0),
            const CourseCard(
                title: 'level Two',
                subtitle: 'Letter I',
                completetext: '0 of 1 Completed',
                value: 0),
            const CourseCard(
                title: 'level Two',
                subtitle: 'Letter T',
                completetext: '0 of 1 Completed',
                value: 0),
            SizedBox(
              height: 16.h,
            )
          ],
        ),
      ),
    );
  }
}
