import 'package:camera/camera.dart'; // 1. استدعاء الكاميرا
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:isharaapp/features/home/presentation/screens/learn_level_four_screen.dart';

const List<String> _levelFourWords = [
  'quiz',
  'mazy',
  'jive',
  'vape',
  'jump',
  'quiz',
  'squiz',
  'equip',
  'czar',
  'pivot',
];

class TestLevelFourScreen extends StatelessWidget {
  final CameraDescription camera;

  const TestLevelFourScreen({
    super.key,
    required this.camera,
  });

  @override
  Widget build(BuildContext context) {
    return LearnLevelFourScreen(
      ispractise: true,
      onBack: () => context.pop(),
      items: _levelFourWords,
      itemType: 'Word',
      headerTitle: 'words',
      headerSubtitle: 'Choose a word from cards below',
    );
  }
}
