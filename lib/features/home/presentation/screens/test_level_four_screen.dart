import 'package:camera/camera.dart'; // 1. استدعاء الكاميرا
import 'package:flutter/material.dart';
import 'package:isharaapp/features/home/presentation/screens/widgets/test_level_template.dart';

class TestLevelFourScreen extends StatelessWidget {
  final CameraDescription camera; // 2. متغير للكاميرا

  const TestLevelFourScreen({
    super.key,
    required this.camera, // 3. إضافته للـ Constructor
  });

  @override
  Widget build(BuildContext context) {
    return TestLevelTemplate(
      title: "Level Four: Quiz",
      word: "Quiz",
      // accuracy: "50%", // <-- حذفناها
      camera: camera, // 4. تمرير الكاميرا
      onBackPressed: () {
        Navigator.pop(context);
      },
    );
  }
}
