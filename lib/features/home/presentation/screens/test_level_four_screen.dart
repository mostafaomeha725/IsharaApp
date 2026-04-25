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
  final String? letterOverride;

  const TestLevelFourScreen({
    super.key,
    required this.camera,
    this.letterOverride,
  });

  @override
  Widget build(BuildContext context) {
    final isLetterMode = letterOverride != null && letterOverride!.isNotEmpty;
    return LearnLevelFourScreen(
      ispractise: true,
      onBack: () => context.pop(),
      items: isLetterMode ? [letterOverride!] : _levelFourWords,
      itemType: isLetterMode ? 'Letter' : 'Word',
      headerTitle: isLetterMode ? 'Test Letter $letterOverride' : 'words',
      headerSubtitle: isLetterMode
          ? 'Sign the letter "$letterOverride" with your hand'
          : 'Choose a word from cards below',
    );
  }
}

