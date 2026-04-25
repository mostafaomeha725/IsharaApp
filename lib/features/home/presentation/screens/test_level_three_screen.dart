import 'package:camera/camera.dart'; // 1. استدعاء الكاميرا
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:isharaapp/features/home/presentation/screens/learn_level_three_screen.dart';

const List<String> _levelThreeWords = [
  'foxy',
  'onyx',
  'gown',
  'honk',
  'minx',
  'hack',
  'claw',
  'hawk',
  'hack',
  'numb',
];

class TestLevelThreeScreen extends StatelessWidget {
  final CameraDescription camera;
  final String? letterOverride;

  const TestLevelThreeScreen({
    super.key,
    required this.camera,
    this.letterOverride,
  });

  @override
  Widget build(BuildContext context) {
    final isLetterMode = letterOverride != null && letterOverride!.isNotEmpty;
    return LearnLevelThreeScreen(
      ispractise: true,
      onBack: () => context.pop(),
      items: isLetterMode ? [letterOverride!] : _levelThreeWords,
      itemType: isLetterMode ? 'Letter' : 'Word',
      headerTitle: isLetterMode ? 'Test Letter $letterOverride' : 'words',
      headerSubtitle: isLetterMode
          ? 'Sign the letter "$letterOverride" with your hand'
          : 'Choose a word from cards below',
    );
  }
}

