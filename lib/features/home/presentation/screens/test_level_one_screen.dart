import 'package:flutter/material.dart';
import 'package:isharaapp/features/home/presentation/screens/widgets/test_level_template.dart';

class TestLevelOneScreen extends StatelessWidget {
  const TestLevelOneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TestLevelTemplate(
      title: "Level One",
      word: "Able",
      accuracy: "50%",
      onBackPressed: () {
        Navigator.pop(context);
      },
    );
  }
}
