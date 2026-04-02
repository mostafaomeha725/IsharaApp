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

  const TestLevelThreeScreen({
    super.key,
    required this.camera,
  });

  @override
  Widget build(BuildContext context) {
    return LearnLevelThreeScreen(
      ispractise: true,
      onBack: () => context.pop(),
      items: _levelThreeWords,
      itemType: 'Word',
      headerTitle: 'words',
      headerSubtitle: 'Choose a word from cards below',
    );
  }
}
