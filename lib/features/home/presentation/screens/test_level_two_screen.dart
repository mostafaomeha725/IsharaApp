import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:isharaapp/features/home/presentation/screens/learn_level_two_screen.dart';

const List<String> _levelTwoWords = [
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

class TestLevelTwoScreen extends StatelessWidget {
  final CameraDescription camera;
  final String? letterOverride;

  const TestLevelTwoScreen({
    super.key,
    required this.camera,
    this.letterOverride,
  });

  @override
  Widget build(BuildContext context) {
    final isLetterMode = letterOverride != null && letterOverride!.isNotEmpty;
    return LearnLevelTwoScreen(
      ispractise: true,
      onBack: () => context.pop(),
      items: isLetterMode ? [letterOverride!] : _levelTwoWords,
      itemType: isLetterMode ? 'Letter' : 'Word',
      headerTitle: isLetterMode ? 'Test Letter $letterOverride' : 'words',
      headerSubtitle: isLetterMode
          ? 'Sign the letter "$letterOverride" with your hand'
          : 'Choose a word from cards below',
    );
  }
}

