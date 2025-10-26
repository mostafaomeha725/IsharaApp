import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isharaapp/core/theme/styles.dart';
import 'package:isharaapp/core/widgets/custom_text.dart';
import 'package:isharaapp/features/home/presentation/screens/lesseon_details_screen.dart';
import 'package:isharaapp/features/home/presentation/screens/practise_lesson_details_screen.dart';
import 'package:isharaapp/features/home/presentation/screens/widgets/course_card.dart';

class LearnLevelOneScreen extends StatefulWidget {
  const LearnLevelOneScreen({super.key, required this.ispractise, this.onTap});
  final bool ispractise;
  final void Function(String letter)? onTap;

  @override
  State<LearnLevelOneScreen> createState() => _LearnLevelOneScreenState();
}

class _LearnLevelOneScreenState extends State<LearnLevelOneScreen> {
  bool _showLessonDetails = false;
  String? _selectedLetter;

  // فتح أي letter
  void _openLesson(String letter) {
    setState(() {
      _selectedLetter = letter;
      _showLessonDetails = true; // مهم جداً لعرض الشاشة
    });

    // لو ispractise = false وعايز ترجع letter كمان
    if (!widget.ispractise) {
      widget.onTap?.call(letter);
    }
  }

  // زر العودة
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
            ? widget.ispractise
                ? PractiseLessonDetailsScreen(onBack: _goBack) // لو practice
                : LesseonDetailsScreen(
                    letter: _selectedLetter ?? 'A',
                    onBack: _goBack, // لو normal lesson
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
