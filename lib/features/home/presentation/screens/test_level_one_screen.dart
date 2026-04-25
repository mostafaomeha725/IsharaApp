import 'package:camera/camera.dart'; // استدعاء الكاميرا
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:isharaapp/features/home/presentation/screens/learn_level_one_screen.dart';

const List<String> _levelOneWords = [
  'risk',
  'sir',
  'dirt',
  'kids',
  'verb',
  'dark',
  'four',
  'draw',
  'feud',
  'cake',
];

class TestLevelOneScreen extends StatelessWidget {
  final CameraDescription camera;
  final String? letterOverride;

  const TestLevelOneScreen({
    super.key,
    required this.camera,
    this.letterOverride,
  });

  @override
  Widget build(BuildContext context) {
    final isLetterMode = letterOverride != null && letterOverride!.isNotEmpty;
    return LearnLevelOneScreen(
      ispractise: true,
      onBack: () => context.pop(),
      items: isLetterMode ? [letterOverride!] : _levelOneWords,
      itemType: isLetterMode ? 'Letter' : 'Word',
      headerTitle: isLetterMode ? 'Test Letter $letterOverride' : 'words',
      headerSubtitle: isLetterMode
          ? 'Sign the letter "$letterOverride" with your hand'
          : 'Choose a word from cards below',
    );
  }
}

