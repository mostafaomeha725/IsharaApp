import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:isharaapp/core/constants/app_assets.dart';
import 'package:isharaapp/core/theme/styles.dart';
import 'package:isharaapp/core/widgets/app_asset.dart';
import 'package:isharaapp/core/widgets/custom_text.dart';
import 'package:isharaapp/features/home/presentation/screens/lesseon_details_screen.dart';
import 'package:isharaapp/features/home/presentation/screens/widgets/course_card.dart';
import 'package:isharaapp/features/home/presentation/screens/widgets/home_appbar.dart';

class LearnLevelOneScreen extends StatefulWidget {
  const LearnLevelOneScreen({
    super.key,
    required this.ispractise,
    this.onBack,
  });

  final bool ispractise;
  final VoidCallback? onBack;

  @override
  State<LearnLevelOneScreen> createState() => _LearnLevelOneScreenState();
}

class _LearnLevelOneScreenState extends State<LearnLevelOneScreen> {
  bool _showLessonDetails = false;
  String? _selectedLetter;

  final List<String> _lettersList = [
    'A',
    'B',
    'C',
    'E',
    'L',
    'O',
    'V',
    'W',
    'U',
    'Y'
  ];

  void _openLesson(String letter) {
    final String fullLetterTitle = 'Level One Letter $letter';

    if (widget.ispractise) {
      context.push('/practisedetails', extra: fullLetterTitle);
    } else {
      setState(() {
        _selectedLetter = fullLetterTitle;
        _showLessonDetails = true;
      });
    }
  }

  void _goToNextLetter() {
    if (_selectedLetter == null) return;

    final String currentLetterChar = _selectedLetter!.split(' ').last;
    final int currentIndex = _lettersList.indexOf(currentLetterChar);

    if (currentIndex != -1 && currentIndex < _lettersList.length - 1) {
      final String nextLetter = _lettersList[currentIndex + 1];
      setState(() {
        _selectedLetter = 'Level One Letter $nextLetter';
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("You have completed all the letters!")),
      );
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
                    letter: _selectedLetter ?? 'Level One Letter A',
                    onBack: _goBackFromLesson,
                    onNext: _goToNextLetter,
                  )
                : SingleChildScrollView(
                    key: const ValueKey('levelOneList'),
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Column(
                      children: [
                        SizedBox(height: widget.onBack != null ? 76.h : 16.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AppAsset(
                              assetName: Assets.youngwomanwritingnotebook,
                              width: 100.w,
                            ),
                            SizedBox(
                              width: 16.w,
                            ),
                            Column(
                              children: [
                                AppText(
                                  'letters',
                                  style: font16w700,
                                  alignment: AlignmentDirectional.center,
                                ),
                                AppText(
                                  'A B C E L O V W U Y',
                                  style: font16w700,
                                  alignment: AlignmentDirectional.center,
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 16.w,
                            ),
                            AppAsset(
                              assetName: Assets
                                  .sideviewofyoungmanwearingsmartwatchandholdingbook,
                              width: 80.w,
                            ),
                          ],
                        ),
                        SizedBox(height: 8.h),
                        ..._lettersList
                            .map(
                              (letter) => CourseCard(
                                title: 'Level One',
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
                    ? (_selectedLetter ?? 'Level One')
                    : 'Level One',
                onBack:
                    _showLessonDetails ? _goBackFromLesson : _goBackToLevels,
              ),
            ),
        ],
      ),
    );
  }
}
