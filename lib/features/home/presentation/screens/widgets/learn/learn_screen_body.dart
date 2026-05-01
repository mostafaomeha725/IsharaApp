import 'package:flutter/material.dart';
import 'package:isharaapp/core/constants/app_assets.dart';
import 'package:isharaapp/core/theme/theme_controller.dart';
import 'package:isharaapp/core/widgets/app_asset.dart';
import 'package:isharaapp/features/home/presentation/cubit/learn_cubit.dart';
import 'package:isharaapp/features/home/presentation/screens/start_learning_screen.dart';

import 'learn_levels_home.dart';
import 'learn_level_page.dart';

class LearnScreenBody extends StatelessWidget {
  final int currentIndex;
  final LearnState state;
  final VoidCallback onGoBack;
  final void Function(int) onGoTo;
  final Future<void> Function(String) onCompletePracticeForLetter;

  const LearnScreenBody({
    super.key,
    required this.currentIndex,
    required this.state,
    required this.onGoBack,
    required this.onGoTo,
    required this.onCompletePracticeForLetter,
  });

  @override
  Widget build(BuildContext context) {
    final themeController = ThemeController.of(context);
    final pages = _buildPages(context, state);
    final pageIndex = currentIndex >= pages.length ? 0 : currentIndex;

    return Stack(
      fit: StackFit.expand,
      children: [
        AppAsset(
          assetName: themeController.themeMode == ThemeMode.dark
              ? Assets.splashdark
              : Assets.splashlight,
        ),
        SafeArea(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: pages[pageIndex],
          ),
        ),
      ],
    );
  }

  List<Widget> _buildPages(BuildContext context, LearnState state) {
    final levels = state.levels;

    return [
      LearnLevelsHome(state: state, onGoTo: onGoTo),
      StartLearningScreen(onGoBack: onGoBack, onPressed: () => onGoTo(2)),
      LearnLevelPage(
        level: levels.isNotEmpty ? levels[0] : null,
        index: 0,
        completingLessonId: state.completingLessonId,
        onGoBack: onGoBack,
        onCompletePracticeForLetter: onCompletePracticeForLetter,
      ),
      LearnLevelPage(
        level: levels.length > 1 ? levels[1] : null,
        index: 1,
        completingLessonId: state.completingLessonId,
        onGoBack: onGoBack,
        onCompletePracticeForLetter: onCompletePracticeForLetter,
      ),
      LearnLevelPage(
        level: levels.length > 2 ? levels[2] : null,
        index: 2,
        completingLessonId: state.completingLessonId,
        onGoBack: onGoBack,
        onCompletePracticeForLetter: onCompletePracticeForLetter,
      ),
      LearnLevelPage(
        level: levels.length > 3 ? levels[3] : null,
        index: 3,
        completingLessonId: state.completingLessonId,
        onGoBack: onGoBack,
        onCompletePracticeForLetter: onCompletePracticeForLetter,
      ),
    ];
  }
}
