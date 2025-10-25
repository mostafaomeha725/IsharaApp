import 'package:flutter/material.dart';
import 'package:isharaapp/features/home/presentation/screens/widgets/test_level_template.dart';

class TestLevelTwoScreen extends StatelessWidget {
  const TestLevelTwoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TestLevelTemplate(
      title: "Level Two: Risk",
      word: "Risk",
      accuracy: "50%",
      onBackPressed: () {
        Navigator.pop(context);
      },
    );
  }
}
