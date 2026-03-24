import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:isharaapp/features/home/presentation/screens/widgets/test_level_template.dart';

class TestLevelTwoScreen extends StatelessWidget {
  final CameraDescription camera;

  const TestLevelTwoScreen({
    super.key,
    required this.camera,
  });

  @override
  Widget build(BuildContext context) {
    return TestLevelTemplate(
      title: "Level Two: Risk",
      word: "Risk",
      camera: camera,
      onBackPressed: () {
        Navigator.pop(context);
      },
    );
  }
}
