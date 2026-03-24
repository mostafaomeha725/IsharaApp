import 'package:camera/camera.dart'; // 1. استدعاء مكتبة الكاميرا
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:isharaapp/features/home/presentation/screens/widgets/test_level_template.dart';

class PractiseLessonDetailsScreen extends StatelessWidget {
  final String letter;
  final CameraDescription camera; // 2. متغير للكاميرا

  const PractiseLessonDetailsScreen({
    super.key,
    required this.letter,
    required this.camera, // 3. استقبال الكاميرا
  });

  @override
  Widget build(BuildContext context) {
    final String singleLetter = letter.split(' ').last;

    return TestLevelTemplate(
      title: letter,
      word: singleLetter,
      // accuracy: ... قمنا بإزالتها لأن القالب يحسبها تلقائياً الآن
      onBackPressed: () => GoRouter.of(context).pop(),
      camera: camera, // 4. تمرير الكاميرا للقالب
    );
  }
}
