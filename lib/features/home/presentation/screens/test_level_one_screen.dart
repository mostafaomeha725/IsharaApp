import 'package:camera/camera.dart'; // استدعاء الكاميرا
import 'package:flutter/material.dart';
import 'package:isharaapp/features/home/presentation/screens/widgets/test_level_template.dart';

class TestLevelOneScreen extends StatelessWidget {
  final CameraDescription camera; // متغير للكاميرا

  const TestLevelOneScreen({
    super.key,
    required this.camera, // إضافته للـ Constructor
  });

  @override
  Widget build(BuildContext context) {
    return TestLevelTemplate(
      title: "Level One",
      word: "Able",
      camera: camera, // تمرير الكاميرا
      onBackPressed: () {
        Navigator.pop(context);
      },
    );
  }
}
