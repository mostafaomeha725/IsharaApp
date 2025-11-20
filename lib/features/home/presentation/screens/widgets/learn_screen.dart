import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isharaapp/core/constants/app_assets.dart';
import 'package:isharaapp/core/theme/styles.dart';
import 'package:isharaapp/core/theme/theme_controller.dart';
import 'package:isharaapp/core/widgets/custom_text.dart';
import 'package:isharaapp/features/home/presentation/screens/learn_level_four_screen.dart';
import 'package:isharaapp/features/home/presentation/screens/learn_level_one_screen.dart';
import 'package:isharaapp/features/home/presentation/screens/learn_level_three_screen.dart';
import 'package:isharaapp/features/home/presentation/screens/learn_level_two_screen.dart';
import 'package:isharaapp/features/home/presentation/screens/start_learning_screen.dart';
import 'package:isharaapp/features/home/presentation/screens/widgets/course_card.dart';
import 'package:isharaapp/features/home/presentation/screens/widgets/home_appbar.dart';

class LearnScreen extends StatefulWidget {
  const LearnScreen({super.key});

  @override
  State<LearnScreen> createState() => _LearnScreenState();
}

class _LearnScreenState extends State<LearnScreen> {
  int _currentIndex = 0;

  void _goTo(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _goBack() {
    setState(() {
      _currentIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeController = ThemeController.of(context);
    final bgColor = themeController.themeMode == ThemeMode.dark
        ? const Color(0xFF3A7CF2)
        : const Color(0xFFF24BB6);

    final pages = [
      _buildMainMenu(context),
      StartLearningScreen(onGoBack: _goBack, onPressed: () => _goTo(2)),
      LearnLevelOneScreen(ispractise: false, onBack: _goBack),
      LearnLevelTwoScreen(ispractise: false, onBack: _goBack),
      LearnLevelThreeScreen(ispractise: false, onBack: _goBack),
      LearnLevelFourScreen(ispractise: false, onBack: _goBack),
    ];

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: BoxDecoration(
              color: bgColor,
              image: const DecorationImage(
                image: AssetImage(Assets.splashlight),
                fit: BoxFit.cover,
                opacity: 0.7,
              ),
            ),
          ),
          SafeArea(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: pages[_currentIndex],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainMenu(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 76.h),
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  'Master the Sign Language Alphabet',
                  style: font16w700.copyWith(color: Colors.white),
                ),
                SizedBox(height: 16.h),
                AppText(
                  'Start with the easiest letters and build your skills step-by-step',
                  style: font16w400.copyWith(color: Colors.white),
                  overflow: TextOverflow.visible,
                ),
                SizedBox(
                  height: 12.h,
                ),
                AppText(
                  'Complete all lessons to form words and start communicating.',
                  style: font16w400.copyWith(color: Colors.white),
                  overflow: TextOverflow.visible,
                ),
                SizedBox(height: 12.h),
                CourseCard(
                  title: 'Introduction',
                  subtitle: 'How to start learning',
                  completetext: '0 of 1 completed',
                  value: 0.1,
                  isinto: false,
                  onTap: () => _goTo(1),
                ),
                CourseCard(
                  title: 'Level One',
                  subtitle: 'letters A,B,C,E,L,O,V,W,U,Y',
                  completetext: '0 of 10 completed',
                  value: 0.0,
                  onTap: () => _goTo(2),
                ),
                CourseCard(
                  title: 'Level Two',
                  subtitle: 'letters D,F,K,R,S,I,T',
                  completetext: '0 of 7 completed',
                  value: 0.0,
                  onTap: () => _goTo(3),
                ),
                CourseCard(
                  title: 'Level Three',
                  subtitle: 'letters G,H,M,N,X',
                  completetext: '0 of 5 completed',
                  value: 0.0,
                  onTap: () => _goTo(4),
                ),
                CourseCard(
                  title: 'Level Four',
                  subtitle: 'letters P,Q,Z,J',
                  completetext: '0 of 4 completed',
                  value: 0.0,
                  onTap: () => _goTo(5),
                ),
                SizedBox(height: 16.h),
              ],
            ),
          ),
        ),
        const Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: HomeAppbar(title: 'Learn'),
        ),
      ],
    );
  }
}
