import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isharaapp/core/constants/app_assets.dart';
import 'package:isharaapp/core/theme/styles.dart';
import 'package:isharaapp/core/theme/theme_controller.dart';
import 'package:isharaapp/core/widgets/app_asset.dart';
import 'package:isharaapp/core/widgets/custom_text.dart';
import 'package:isharaapp/features/home/presentation/screens/learn_level_four_screen.dart';
import 'package:isharaapp/features/home/presentation/screens/learn_level_one_screen.dart';
import 'package:isharaapp/features/home/presentation/screens/learn_level_three_screen.dart';
import 'package:isharaapp/features/home/presentation/screens/learn_level_two_screen.dart';
import 'package:isharaapp/features/home/presentation/screens/lesseon_details_screen.dart';
import 'package:isharaapp/features/home/presentation/screens/widgets/course_card.dart';
import 'package:isharaapp/features/home/presentation/screens/widgets/home_appbar.dart';
import 'package:isharaapp/features/home/presentation/screens/widgets/custom_nav_bar.dart';

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
      } else {
        final navBarState = CustomNavBar.of(context);
        navBarState?.onWillPop();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeController = ThemeController.of(context);

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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: HomeAppbar(title: appBarTitle, onBack: _goBackOneStep),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          AppAsset(
            assetName: themeController.themeMode == ThemeMode.dark
                ? Assets.splashdark
                : Assets.splashlight,
          ),

          /// Main Content
          SafeArea(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: _showLessonDetails
                  ? LesseonDetailsScreen(
                      onBack: _goBackOneStep,
                      letter: '',
                    )
                  : _showLevelOne
                      ? const LearnLevelOneScreen(ispractise: true)
                      : _showLevelTwo
                          ? const LearnLevelTwoScreen(ispractise: true)
                          : _showLevelThree
                              ? const LearnLevelThreeScreen(ispractise: true)
                              : _showLevelFour
                                  ? const LearnLevelFourScreen(ispractise: true)
                                  : SingleChildScrollView(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16.w),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          // AppText(
                                          //   'Practice with AI',
                                          //   style: font20w700.copyWith(
                                          //       // جعل النص يتأقلم مع الخلفية أو الثيم
                                          //       color:
                                          //           themeController.themeMode ==
                                          //                   ThemeMode.dark
                                          //               ? Colors.white
                                          //               : Colors.black),
                                          // ),
                                          // SizedBox(height: 8.h),
                                          // const TextRowStartLearning(
                                          //   title:
                                          //       'Use your camera to practice signs.',
                                          // ),
                                          // const TextRowStartLearning(
                                          //   title:
                                          //       'Our AI will give you instant feedback.',
                                          // ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              AppAsset(
                                                assetName: Assets
                                                    .youngwomanwritingnotebook,
                                                width: 100.w,
                                              ),
                                              SizedBox(
                                                width: 16.w,
                                              ),
                                              Column(
                                                children: [
                                                  AppText(
                                                    'Use your camera to',
                                                    style: font16w700,
                                                    alignment:
                                                        AlignmentDirectional
                                                            .center,
                                                  ),
                                                  AppText(
                                                    'practice signs.',
                                                    style: font16w700,
                                                    alignment:
                                                        AlignmentDirectional
                                                            .center,
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
                                          SizedBox(
                                            height: 38.h,
                                          ),
                                          CourseCard(
                                            title: 'Level One',
                                            subtitle:
                                                'letters A B C E L O V W U Y',
                                            completetext: '0 of 10 completed',
                                            value: 0.0,
                                            isPractice: true,
                                            assetName: Assets.catonbooks,
                                            onTap: () {
                                              setState(() {
                                                _showLevelOne = true;
                                              });
                                            },
                                            showBadgeImage: true,
                                          ),
                                          SizedBox(
                                            height: 38.h,
                                          ),
                                          CourseCard(
                                            title: 'Level Two',
                                            subtitle: 'letters D,F,K,R,S,I,T',
                                            completetext: '0 of 7 completed',
                                            value: 0.0,
                                            isPractice: true,
                                            showBadgeImage: true,
                                            assetName: Assets.boylookingglobal,
                                            onTap: () {
                                              setState(() {
                                                _showLevelTwo = true;
                                              });
                                            },
                                          ),
                                          SizedBox(
                                            height: 38.h,
                                          ),
                                          CourseCard(
                                            title: 'Level Three',
                                            subtitle: 'letters G,H,M,N,X',
                                            completetext: '0 of 5 completed',
                                            value: 0.0,
                                            isPractice: true,
                                            showBadgeImage: true,
                                            assetName: Assets.booksandcup,
                                            onTap: () {
                                              setState(() {
                                                _showLevelThree = true;
                                              });
                                            },
                                          ),
                                          SizedBox(
                                            height: 38.h,
                                          ),
                                          CourseCard(
                                            title: 'Level Four',
                                            subtitle: 'letters P,Q,Z,J',
                                            completetext: '0 of 4 completed',
                                            value: 0.0,
                                            isPractice: true,
                                            showBadgeImage: true,
                                            assetName: Assets.stackofbooks,
                                            onTap: () {
                                              setState(() {
                                                _showLevelFour = true;
                                              });
                                            },
                                          ),
                                          SizedBox(height: 38.h),
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
