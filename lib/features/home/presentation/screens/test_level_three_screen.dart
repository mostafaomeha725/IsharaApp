import 'package:flutter/material.dart';
import 'package:isharaapp/features/home/presentation/screens/widgets/test_level_template.dart';

class TestLevelThreeScreen extends StatelessWidget {
  const TestLevelThreeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TestLevelTemplate(
      title: "Level Three: Foxy",
      word: "Foxy",
      accuracy: "50%",
      onBackPressed: () {
        Navigator.pop(context);
      },
    );
  }
}
