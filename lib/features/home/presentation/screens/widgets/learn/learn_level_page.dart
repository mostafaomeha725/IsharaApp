import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isharaapp/features/home/domain/entities/learn_level_entity.dart';
import 'package:isharaapp/features/home/presentation/cubit/learn_cubit.dart';
import 'package:isharaapp/features/home/presentation/screens/learn_level_four_screen.dart';
import 'package:isharaapp/features/home/presentation/screens/learn_level_one_screen.dart';
import 'package:isharaapp/features/home/presentation/screens/learn_level_three_screen.dart';
import 'package:isharaapp/features/home/presentation/screens/learn_level_two_screen.dart';
import 'learn_helper.dart';

class LearnLevelPage extends StatelessWidget {
  final LearnLevelEntity? level;
  final int index;
  final int? completingLessonId;
  final VoidCallback onGoBack;
  final Future<void> Function(String) onCompletePracticeForLetter;

  const LearnLevelPage({
    super.key,
    required this.level,
    required this.index,
    required this.completingLessonId,
    required this.onGoBack,
    required this.onCompletePracticeForLetter,
  });

  @override
  Widget build(BuildContext context) {
    final items = level == null ? null : LearnHelper.buildLessonItems(level!);
    final lessonIdsByItem = level == null
        ? const <String, int>{}
        : LearnHelper.buildLessonIdMap(level!);
    final completedItems = level == null
        ? const <String>{}
        : LearnHelper.buildCompletedItems(level!);

    final Future<void> Function(int lessonId)? onCompleteLesson = level == null
        ? null
        : (lessonId) async {
            await context.read<LearnCubit>().completeLesson(lessonId);
          };

    final Future<void> Function(int lessonId)? onCompleteTest = level == null
        ? null
        : (lessonId) async {
            await context.read<LearnCubit>().completeLesson(lessonId);
            final letter = lessonIdsByItem.entries
                .where((e) => e.value == lessonId)
                .map((e) => e.key)
                .firstOrNull;
            if (letter != null) {
              await onCompletePracticeForLetter(letter);
            }
          };

    switch (index) {
      case 0:
        return LearnLevelOneScreen(
          ispractise: false,
          onBack: onGoBack,
          items: items,
          lessonIdsByItem: lessonIdsByItem,
          completedItems: completedItems,
          completingLessonId: completingLessonId,
          onCompleteLesson: onCompleteLesson,
          onCompleteTest: onCompleteTest,
        );
      case 1:
        return LearnLevelTwoScreen(
          ispractise: false,
          onBack: onGoBack,
          items: items,
          lessonIdsByItem: lessonIdsByItem,
          completedItems: completedItems,
          completingLessonId: completingLessonId,
          onCompleteLesson: onCompleteLesson,
          onCompleteTest: onCompleteTest,
        );
      case 2:
        return LearnLevelThreeScreen(
          ispractise: false,
          onBack: onGoBack,
          items: items,
          lessonIdsByItem: lessonIdsByItem,
          completedItems: completedItems,
          completingLessonId: completingLessonId,
          onCompleteLesson: onCompleteLesson,
          onCompleteTest: onCompleteTest,
        );
      case 3:
        return LearnLevelFourScreen(
          ispractise: false,
          onBack: onGoBack,
          items: items,
          lessonIdsByItem: lessonIdsByItem,
          completedItems: completedItems,
          completingLessonId: completingLessonId,
          onCompleteLesson: onCompleteLesson,
          onCompleteTest: onCompleteTest,
        );
      default:
        return LearnLevelOneScreen(ispractise: false, onBack: onGoBack);
    }
  }
}
