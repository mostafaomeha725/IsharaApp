import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isharaapp/core/constants/app_assets.dart';
import 'package:isharaapp/core/theme/gender_controller.dart';
import 'package:isharaapp/core/theme/styles.dart';
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
  bool _showStartLearning = false;
  bool _showLevelOne = false;
  bool _showLevelTwo = false;
  bool _showLevelThree = false;
  bool _showLevelFour = false;

  void _openLevelOne() {
    setState(() {
      _showStartLearning = false;
      _showLevelOne = true;
    });
  }

  void _closeAll() {
    setState(() {
      _showStartLearning = false;
      _showLevelOne = false;
      _showLevelTwo = false;
      _showLevelThree = false;
      _showLevelFour = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final gender = GenderController.of(context).genderTheme;
    final bgColor = gender == GenderTheme.boy
        ? const Color(0xFF3A7CF2)
        : const Color(0xFFF24BB6);

    String appBarTitle = 'Learn';
    if (_showStartLearning) appBarTitle = 'How to start learning';
    if (_showLevelOne) appBarTitle = 'Level One';
    if (_showLevelTwo) appBarTitle = 'Level Two';
    if (_showLevelThree) appBarTitle = 'Level Three';
    if (_showLevelFour) appBarTitle = 'Level Four';

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: HomeAppbar(title: appBarTitle, onBack: _closeAll),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: BoxDecoration(
              color: bgColor,
              image: const DecorationImage(
                image: AssetImage(Assets.girlsplash),
                fit: BoxFit.cover,
                opacity: 0.7,
              ),
            ),
          ),
          SafeArea(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: _showStartLearning
                  ? StartLearningScreen(
                      onGoBack: _closeAll,
                      onPressed: _openLevelOne,
                    )
                  : _showLevelOne
                      ? const LearnLevelOneScreen(ispractise: false)
                      : _showLevelTwo
                          ? const LearnLevelTwoScreen(
                              ispractise: false,
                            )
                          : _showLevelThree
                              ? const LearnLevelThreeScreen(
                                  ispractise: false,
                                )
                              : _showLevelFour
                                  ? const LearnLevelFourScreen(
                                      ispractise: false,
                                    )
                                  : SingleChildScrollView(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16.w),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          AppText(
                                            'Master the Sign Language Alphabet',
                                            style: font16w700.copyWith(
                                                color: Colors.white),
                                            overflow: TextOverflow.visible,
                                          ),
                                          SizedBox(height: 16.h),
                                          AppText(
                                            'Start with the easiest letters and build your skills step-by-step',
                                            style: font16w400.copyWith(
                                                color: Colors.white),
                                            overflow: TextOverflow.visible,
                                          ),
                                          SizedBox(height: 12.h),
                                          CourseCard(
                                            title: 'Introduction',
                                            subtitle: 'How to start learning',
                                            completetext: '0 of 1 completed',
                                            value: 0.1,
                                            isinto: false,
                                            onTap: () {
                                              setState(() {
                                                _showStartLearning = true;
                                              });
                                            },
                                          ),
                                          CourseCard(
                                            title: 'Level One',
                                            subtitle:
                                                'letters A,B,C,E,L,O,V,W,U,Y',
                                            completetext: '0 of 10 completed',
                                            value: 0.0,
                                            onTap: () {
                                              setState(() {
                                                _showLevelOne = true;
                                              });
                                            },
                                          ),
                                          CourseCard(
                                            title: 'Level Two',
                                            subtitle: 'letters D,F,K,R,S,I,T',
                                            completetext: '0 of 7 completed',
                                            value: 0.0,
                                            onTap: () {
                                              setState(() {
                                                _showLevelTwo = true;
                                              });
                                            },
                                          ),
                                          CourseCard(
                                            title: 'Level Three',
                                            subtitle: 'letters G,H,M,N,X',
                                            completetext: '0 of 5 completed',
                                            value: 0.0,
                                            onTap: () {
                                              setState(() {
                                                _showLevelThree = true;
                                              });
                                            },
                                          ),
                                          CourseCard(
                                            title: 'Level Four',
                                            subtitle: 'letters P,Q,Z,J',
                                            completetext: '0 of 4 completed',
                                            value: 0.0,
                                            onTap: () {
                                              setState(() {
                                                _showLevelFour = true;
                                              });
                                            },
                                          ),
                                          SizedBox(height: 16.h),
                                        ],
                                      ),
                                    ),
            ),
          ),
        ],
      ),
    );
  }
}
