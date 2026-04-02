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

  const TestLevelOneScreen({
    super.key,
    required this.camera,
  });

  @override
  Widget build(BuildContext context) {
    return LearnLevelOneScreen(
      ispractise: true,
      onBack: () => context.pop(),
      items: _levelOneWords,
      itemType: 'Word',
      headerTitle: 'words',
      headerSubtitle: 'Choose a word from cards below',
    );
  }
}
