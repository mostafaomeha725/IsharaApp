import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:isharaapp/core/routes/route_paths.dart';
import 'package:isharaapp/core/theme/styles.dart';
import 'package:isharaapp/core/widgets/custom_text.dart';
import 'package:isharaapp/features/home/presentation/screens/lesseon_details_screen.dart';
import 'package:isharaapp/features/home/presentation/screens/widgets/course_card.dart';

class LearnLevelOneScreen extends StatefulWidget {
  const LearnLevelOneScreen({
    super.key,
    required this.ispractise,
    this.onTap,
  });

  final bool ispractise;
  final void Function(String letter)? onTap;

  @override
  State<LearnLevelOneScreen> createState() => _LearnLevelOneScreenState();
}

class _LearnLevelOneScreenState extends State<LearnLevelOneScreen> {
  bool _showLessonDetails = false;
  String? _selectedLetter;

  void _openLesson(String letter) {
    final String fullLetterTitle = 'Level One Letter $letter';

    if (widget.ispractise) {
      context.push(
        Routes.practisedetails,
        extra: fullLetterTitle,
      );
    } else {
      setState(() {
        _selectedLetter = fullLetterTitle;
        _showLessonDetails = true;
      });

      widget.onTap?.call(fullLetterTitle);
    }
  }

  void _goBack() {
    setState(() {
      _showLessonDetails = false;
      _selectedLetter = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: _showLessonDetails
            ? LesseonDetailsScreen(
                letter: _selectedLetter ?? 'Level One Letter A',
                onBack: _goBack,
              )
            : SingleChildScrollView(
                key: const ValueKey('levelOneList'),
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  children: [
                    SizedBox(height: 16.h),
                    AppText(
                      'letters A,B,C,E,L,O,V,W,U,Y',
                      style: font16w700.copyWith(color: Colors.white),
                      alignment: AlignmentDirectional.center,
                    ),
                    SizedBox(height: 8.h),
                    ...['A', 'B', 'C', 'E', 'L', 'O', 'V', 'W', 'U', 'Y']
                        .map((letter) => CourseCard(
                              title: 'Level One',
                              subtitle: 'Letter $letter',
                              completetext: '0 of 1 Completed',
                              value: 0,
                              onTap: () => _openLesson(letter),
                              isPractice: widget.ispractise,
                            ))
                        .toList(),
                    SizedBox(height: 16.h),
                  ],
                ),
              ),
      ),
    );
  }
}
