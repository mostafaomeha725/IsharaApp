import 'package:flutter/material.dart';
import 'package:isharaapp/features/home/presentation/screens/widgets/test_level_template.dart';

class TestLevelFourScreen extends StatelessWidget {
  const TestLevelFourScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TestLevelTemplate(
      title: "Level Four: Quiz",
      word: "Quiz",
      accuracy: "50%",
      onBackPressed: () {
        Navigator.pop(context);
      },
    );
  }
}
