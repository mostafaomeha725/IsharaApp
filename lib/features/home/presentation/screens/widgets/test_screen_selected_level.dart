import 'package:flutter/material.dart';
import 'package:isharaapp/features/home/presentation/screens/learn_level_four_screen.dart';
import 'package:isharaapp/features/home/presentation/screens/learn_level_one_screen.dart';
import 'package:isharaapp/features/home/presentation/screens/learn_level_three_screen.dart';
import 'package:isharaapp/features/home/presentation/screens/learn_level_two_screen.dart';
import 'package:isharaapp/features/home/presentation/screens/widgets/test_screen_level_data.dart';

Widget buildTestSelectedLevel({
  required TestScreenLevelData level,
  required VoidCallback onBack,
}) {
  switch (level.id) {
    case 1:
      return LearnLevelOneScreen(
        key: ValueKey(level.keyName),
        ispractise: true,
        onBack: onBack,
        items: level.words,
        itemType: 'Word',
        headerTitle: '',
        headerSubtitle: '',
      );
    case 2:
      return LearnLevelTwoScreen(
        key: ValueKey(level.keyName),
        ispractise: true,
        onBack: onBack,
        items: level.words,
        itemType: 'Word',
        headerTitle: '',
        headerSubtitle: '',
      );
    case 3:
      return LearnLevelThreeScreen(
        key: ValueKey(level.keyName),
        ispractise: true,
        onBack: onBack,
        items: level.words,
        itemType: 'Word',
        headerTitle: '',
        headerSubtitle: '',
      );
    case 4:
      return LearnLevelFourScreen(
        key: ValueKey(level.keyName),
        ispractise: true,
        onBack: onBack,
        items: level.words,
        itemType: 'Word',
        headerTitle: '',
        headerSubtitle: '',
      );
    default:
      return const SizedBox.shrink();
  }
}
