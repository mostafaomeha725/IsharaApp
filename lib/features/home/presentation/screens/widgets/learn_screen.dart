import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isharaapp/core/constants/app_assets.dart';
import 'package:isharaapp/core/theme/gender_controller.dart';
import 'package:isharaapp/core/theme/styles.dart';
import 'package:isharaapp/core/widgets/custom_text.dart';
import 'package:isharaapp/features/home/presentation/screens/widgets/course_card.dart';
import 'package:isharaapp/features/home/presentation/screens/widgets/home_appbar.dart';
import 'package:isharaapp/features/home/presentation/screens/widgets/start_learning_screen_body.dart';

class LearnScreen extends StatefulWidget {
  const LearnScreen({super.key});

  @override
  State<LearnScreen> createState() => _LearnScreenState();
}

class _LearnScreenState extends State<LearnScreen> {
  bool _showStartLearning = false;

  void _closeStartLearning() {
    setState(() {
      _showStartLearning = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final gender = GenderController.of(context).genderTheme;

    final bgColor = gender == GenderTheme.boy
        ? const Color(0xFF3A7CF2)
        : const Color(0xFFF24BB6);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: HomeAppbar(
        title: _showStartLearning ? 'How to start learning' : 'Learn',
        onBack: _showStartLearning ? _closeStartLearning : null,
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
                opacity: 0.70,
              ),
            ),
          ),
          SafeArea(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: _showStartLearning
                  ? Padding(
                      padding: EdgeInsets.symmetric(horizontal: 22.0.w),
                      child: StartLearningScreenBody(
                        onGoBack: _closeStartLearning,
                      ),
                    )
                  : SingleChildScrollView(
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
                          SizedBox(height: 16.h),
                          AppText(
                            'Complete all lessons to form words and start communicating',
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
                            onTap: () {
                              setState(() {
                                _showStartLearning = true;
                              });
                            },
                          ),
                          const CourseCard(
                            title: 'Level One',
                            subtitle: 'letters A,B,C,E,L,O,V,W,U,Y',
                            completetext: '0 of 10 completed',
                            value: 0.0,
                          ),
                          const CourseCard(
                            title: 'Level Two',
                            subtitle: 'letters D,F,K,R,S,I,T',
                            completetext: '0 of 7 completed',
                            value: 0.0,
                          ),
                          const CourseCard(
                            title: 'Level Three',
                            subtitle: 'letters G,H,M,N,X',
                            completetext: '0 of 5 completed',
                            value: 0.0,
                          ),
                          const CourseCard(
                            title: 'Level Four',
                            subtitle: 'letters P,Q,Z,J',
                            completetext: '0 of 4 completed',
                            value: 0.0,
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
