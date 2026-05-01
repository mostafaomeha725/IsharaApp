import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isharaapp/features/home/presentation/cubit/practice_cubit.dart';
import 'package:isharaapp/features/home/presentation/screens/learn_level_four_screen.dart';
import 'package:isharaapp/features/home/presentation/screens/learn_level_one_screen.dart';
import 'package:isharaapp/features/home/presentation/screens/learn_level_three_screen.dart';
import 'package:isharaapp/features/home/presentation/screens/learn_level_two_screen.dart';
import 'practice_helper.dart';

class PracticeLevelPage extends StatelessWidget {
  final PracticeState state;
  final int index;
  final VoidCallback onGoBackOneStep;

  const PracticeLevelPage({
    super.key,
    required this.state,
    required this.index,
    required this.onGoBackOneStep,
  });

  @override
  Widget build(BuildContext context) {
    final levels = state.levels;
    final level = index < levels.length ? levels[index] : null;

    final items = PracticeHelper.getItems(level);
    final idsByItem = PracticeHelper.getIdsByItem(level);
    final completedItems = PracticeHelper.getCompletedItems(level);

    Future<void> onComplete(int lessonId) {
      return context.read<PracticeCubit>().completeLesson(lessonId);
    }

    switch (index) {
      case 0:
        return LearnLevelOneScreen(
          key: const ValueKey('practiceLevelOne'),
          ispractise: true,
          onBack: onGoBackOneStep,
          items: items,
          lessonIdsByItem: idsByItem,
          completedItems: completedItems,
          completionType: 'practice',
          onCompleteLesson: onComplete,
        );
      case 1:
        return LearnLevelTwoScreen(
          key: const ValueKey('practiceLevelTwo'),
          ispractise: true,
          onBack: onGoBackOneStep,
          items: items,
          lessonIdsByItem: idsByItem,
          completedItems: completedItems,
          completionType: 'practice',
          onCompleteLesson: onComplete,
        );
      case 2:
        return LearnLevelThreeScreen(
          key: const ValueKey('practiceLevelThree'),
          ispractise: true,
          onBack: onGoBackOneStep,
          items: items,
          lessonIdsByItem: idsByItem,
          completedItems: completedItems,
          completionType: 'practice',
          onCompleteLesson: onComplete,
        );
      case 3:
        return LearnLevelFourScreen(
          key: const ValueKey('practiceLevelFour'),
          ispractise: true,
          onBack: onGoBackOneStep,
          items: items,
          lessonIdsByItem: idsByItem,
          completedItems: completedItems,
          completionType: 'practice',
          onCompleteLesson: onComplete,
        );
      default:
        return const SizedBox.shrink();
    }
  }
}
