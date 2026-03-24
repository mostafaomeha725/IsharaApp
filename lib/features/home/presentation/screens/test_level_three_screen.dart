import 'package:camera/camera.dart'; // 1. استدعاء الكاميرا
import 'package:flutter/material.dart';
import 'package:isharaapp/features/home/presentation/screens/widgets/test_level_template.dart';

class TestLevelThreeScreen extends StatelessWidget {
  final CameraDescription camera; // 2. متغير لاستقبال الكاميرا

  const TestLevelThreeScreen({
    super.key,
    required this.camera, // 3. إضافته للـ Constructor
  });

  @override
  Widget build(BuildContext context) {
    return TestLevelTemplate(
      title: "Level Three: Foxy",
      word: "Foxy",
      // accuracy: "50%", // <-- نحذف هذا السطر لأنه لم يعد موجوداً
      camera: camera, // 4. نمرر الكاميرا للـ Template
      onBackPressed: () {
        Navigator.pop(context);
      },
    );
  }
}
