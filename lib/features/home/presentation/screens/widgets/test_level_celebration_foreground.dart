import 'package:flutter/material.dart';

class TestLevelCelebrationForeground extends StatelessWidget {
  const TestLevelCelebrationForeground({
    super.key,
    required this.progress,
  });

  final double progress;

  @override
  Widget build(BuildContext context) {
    final acceleratedProgress = (progress * 1.35).clamp(0.0, 1.0);
    final rise = Curves.easeOutCubic.transform(acceleratedProgress);
    final fadeOutProgress = ((progress - 0.78) / 0.22).clamp(0.0, 1.0);
    final opacity = 1 - Curves.easeIn.transform(fadeOutProgress);

    return Align(
      alignment: Alignment.bottomCenter,
      child: Transform.translate(
        // Start below the viewport then rise upward.
        offset: Offset(0, 70 - (rise * 340)),
        child: Opacity(
          opacity: opacity,
          child: Transform.scale(
            scale: 0.95 + (rise * 0.35),
            child: const Text(
              '🎉',
              style: TextStyle(fontSize: 72),
            ),
          ),
        ),
      ),
    );
  }
}
