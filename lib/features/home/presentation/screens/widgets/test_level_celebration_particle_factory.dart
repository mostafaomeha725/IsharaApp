import 'dart:math';

import 'package:flutter/material.dart';
import 'package:isharaapp/features/home/presentation/screens/widgets/test_level_celebration_particle.dart';

class TestLevelCelebrationParticleFactory {
  static List<TestLevelCelebrationParticle> generate({
    required bool burstMode,
    Random? random,
  }) {
    final rand = random ?? Random();
    final int count = burstMode ? 100 : 70;

    const palette = <Color>[
      Colors.amber,
      Colors.pink,
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.cyan,
    ];

    return List.generate(count, (_) {
      return TestLevelCelebrationParticle(
        angle: rand.nextDouble() * 2 * pi,
        speed: 2 + rand.nextDouble() * 4,
        size: 6 + rand.nextDouble() * 10,
        color: palette[rand.nextInt(palette.length)],
        rotationSpeed: rand.nextDouble() * 3,
        isCircle: rand.nextBool(),
        phase: rand.nextDouble(),
      );
    });
  }
}
