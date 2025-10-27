import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:isharaapp/core/theme/styles.dart';
import 'package:isharaapp/core/widgets/custom_text.dart';
import 'package:isharaapp/features/home/presentation/screens/lesseon_details_screen.dart';
import 'package:isharaapp/features/home/presentation/screens/widgets/course_card.dart';
import 'package:isharaapp/features/home/presentation/screens/widgets/home_appbar.dart';

class LearnLevelFourScreen extends StatefulWidget {
  const LearnLevelFourScreen({
    super.key,
    required this.ispractise,
    this.onBack,
  });

  final bool ispractise;
  final VoidCallback? onBack;

  @override
  State<LearnLevelFourScreen> createState() => _LearnLevelFourScreenState();
}

class _LearnLevelFourScreenState extends State<LearnLevelFourScreen> {
  bool _showLessonDetails = false;
  String? _selectedLetter;

  void _openLesson(String letter) {
    final String fullLetterTitle = 'Level Four Letter $letter';

    if (widget.ispractise) {
      context.push('/practisedetails', extra: fullLetterTitle);
    } else {
      setState(() {
        _selectedLetter = fullLetterTitle;
        _showLessonDetails = true;
      });
    }
  }

  void _goBackFromLesson() {
    setState(() {
      _showLessonDetails = false;
      _selectedLetter = null;
    });
  }

  void _goBackToLevels() {
    if (widget.onBack != null) {
      widget.onBack!();
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: _showLessonDetails
                ? LesseonDetailsScreen(
                    letter: _selectedLetter ?? 'Level Four Letter P',
                    onBack: _goBackFromLesson,
                  )
                : SingleChildScrollView(
                    key: const ValueKey('levelFourList'),
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Column(
                      children: [
                        SizedBox(height: widget.onBack != null ? 76.h : 16.h),
                        AppText(
                          'letters P,Q,Z,J',
                          style: font16w700.copyWith(color: Colors.white),
                          alignment: AlignmentDirectional.center,
                        ),
                        SizedBox(height: 8.h),
                        ...['P', 'Q', 'Z', 'J']
                            .map(
                              (letter) => CourseCard(
                                title: 'Level Four',
                                subtitle: 'Letter $letter',
                                completetext: '0 of 1 Completed',
                                value: 0,
                                onTap: () => _openLesson(letter),
                                isPractice: widget.ispractise,
                              ),
                            )
                            .toList(),
                        SizedBox(height: 16.h),
                      ],
                    ),
                  ),
          ),
          if (widget.onBack != null)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: HomeAppbar(
                title: _showLessonDetails
                    ? (_selectedLetter ?? 'Level Four')
                    : 'Level Four',
                onBack:
                    _showLessonDetails ? _goBackFromLesson : _goBackToLevels,
              ),
            ),
        ],
      ),
    );
  }
}
