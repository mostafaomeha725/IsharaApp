import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:isharaapp/features/home/presentation/screens/widgets/test_level_template.dart';

class PractiseLessonDetailsScreen extends StatelessWidget {
  final String letter;

  const PractiseLessonDetailsScreen({
    super.key,
    required this.letter,
  });

  @override
  Widget build(BuildContext context) {
    final String singleLetter = letter.split(' ').last;

    return TestLevelTemplate(
      title: letter,
      word: singleLetter,
      accuracy: 'Accuracy for $singleLetter',
      onBackPressed: () => GoRouter.of(context).pop(),
    );
  }
}
