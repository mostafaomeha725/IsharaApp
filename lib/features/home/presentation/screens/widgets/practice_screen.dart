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
import 'package:isharaapp/features/home/presentation/screens/lesseon_details_screen.dart';
import 'package:isharaapp/features/home/presentation/screens/widgets/course_card.dart';
import 'package:isharaapp/features/home/presentation/screens/widgets/home_appbar.dart';
import 'package:isharaapp/features/home/presentation/screens/widgets/text_row_start_learning.dart';

class PracticeScreen extends StatefulWidget {
  const PracticeScreen({super.key});

  @override
  State<PracticeScreen> createState() => _PracticeScreenState();
}

class _PracticeScreenState extends State<PracticeScreen> {
  bool _showLevelOne = false;
  bool _showLevelTwo = false;
  bool _showLevelThree = false;
  bool _showLevelFour = false;
  bool _showLessonDetails = false;
  String? _selectedLetter;

  void _closeAll() {
    setState(() {
      _showLevelOne = false;
      _showLevelTwo = false;
      _showLevelThree = false;
      _showLevelFour = false;
      _showLessonDetails = false;
      _selectedLetter = null;
    });
  }

  void _goBackOneStep() {
    setState(() {
      if (_showLessonDetails) {
        _showLessonDetails = false;
      } else if (_showLevelOne ||
          _showLevelTwo ||
          _showLevelThree ||
          _showLevelFour) {
        _closeAll();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final gender = GenderController.of(context).genderTheme;
    final bgColor = gender == GenderTheme.boy
        ? const Color(0xFF3A7CF2)
        : const Color(0xFFF24BB6);

    String appBarTitle = 'Practice';
    if (_showLessonDetails) {
      appBarTitle = 'Letter ${_selectedLetter ?? ''}';
    } else if (_showLevelOne) {
      appBarTitle = 'Level One';
    } else if (_showLevelTwo) {
      appBarTitle = 'Level Two';
    } else if (_showLevelThree) {
      appBarTitle = 'Level Three';
    } else if (_showLevelFour) {
      appBarTitle = 'Level Four';
    }

    return Scaffold(
      extendBodyBehindAppBar: true, // ✅ الخلفية تمتد خلف الـ AppBar
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: HomeAppbar(title: appBarTitle, onBack: _goBackOneStep),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // ✅ خلفية موحدة تمتد خلف كل شيء
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

          // ✅ المحتوى الداخلي
          SafeArea(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: _showLessonDetails
                  ? LesseonDetailsScreen(
                      onBack: _goBackOneStep,
                      letter: '',
                    )
                  : _showLevelOne
                      ? LearnLevelOneScreen(
                          ispractise: true,
                          onTap: (letter) {
                            setState(() {
                              _showLessonDetails = true;
                              _selectedLetter = letter;
                            });
                          },
                        )
                      : _showLevelTwo
                          ? const LearnLevelTwoScreen()
                          : _showLevelThree
                              ? const LearnLevelThreeScreen()
                              : _showLevelFour
                                  ? const LearnLevelFourScreen()
                                  : Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16.w),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(height: 16.h),
                                          AppText(
                                            'Practice with AI',
                                            style: font20w700.copyWith(
                                                color: Colors.white),
                                          ),
                                          SizedBox(height: 8.h),
                                          const TextRowStartLearning(
                                            title:
                                                'Use your camera to practice signs.',
                                          ),
                                          const TextRowStartLearning(
                                            title:
                                                'Our AI will give you instant feedback.',
                                          ),
                                          SizedBox(height: 22.h),

                                          // ✅ كروت المستويات
                                          CourseCard(
                                            title: 'Level One',
                                            subtitle:
                                                'letters A,B,C,E,L,O,V,W,U,Y',
                                            completetext: '0 of 10 completed',
                                            value: 0.0,
                                            isPractice: true,
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
                                            isPractice: true,
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
                                            isPractice: true,
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
                                            isPractice: true,
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
