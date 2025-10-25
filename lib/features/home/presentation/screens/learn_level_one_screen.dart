import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isharaapp/core/theme/styles.dart';
import 'package:isharaapp/core/widgets/custom_text.dart';
import 'package:isharaapp/features/home/presentation/screens/widgets/course_card.dart';

class LearnLevelOneScreen extends StatelessWidget {
  const LearnLevelOneScreen({super.key, this.onTap});
  final void Function()? onTap;
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
            AppText('letters A,B,C,E,L,O,V,W,U,Y',
                style: font16w700, alignment: AlignmentDirectional.center),
            SizedBox(
              height: 8.h,
            ),
            CourseCard(
              title: 'level one',
              subtitle: 'Letter A',
              completetext: '0 of 1 Completed',
              value: 0,
              onTap: onTap,
            ),
            CourseCard(
                title: 'level one',
                subtitle: 'Letter B',
                completetext: '0 of 1 Completed',
                onTap: onTap,
                value: 0),
            CourseCard(
                title: 'level one',
                subtitle: 'Letter C',
                completetext: '0 of 1 Completed',
                onTap: onTap,
                value: 0),
            CourseCard(
                title: 'level one',
                subtitle: 'Letter E',
                completetext: '0 of 1 Completed',
                onTap: onTap,
                value: 0),
            CourseCard(
                title: 'level one',
                subtitle: 'Letter L',
                completetext: '0 of 1 Completed',
                onTap: onTap,
                value: 0),
            CourseCard(
                title: 'level one',
                subtitle: 'Letter O',
                completetext: '0 of 1 Completed',
                onTap: onTap,
                value: 0),
            CourseCard(
                title: 'level one',
                subtitle: 'Letter V',
                completetext: '0 of 1 Completed',
                onTap: onTap,
                value: 0),
            CourseCard(
                title: 'level one',
                subtitle: 'Letter W',
                completetext: '0 of 1 Completed',
                onTap: onTap,
                value: 0),
            CourseCard(
                title: 'level one',
                subtitle: 'Letter U',
                completetext: '0 of 1 Completed',
                onTap: onTap,
                value: 0),
            CourseCard(
                title: 'level one',
                subtitle: 'Letter Y',
                completetext: '0 of 1 Completed',
                onTap: onTap,
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
