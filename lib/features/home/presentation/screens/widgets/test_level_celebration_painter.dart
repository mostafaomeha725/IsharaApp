import 'dart:math';

import 'package:flutter/material.dart';
import 'package:isharaapp/features/home/presentation/screens/widgets/test_level_celebration_particle.dart';

class TestLevelCelebrationPainter extends CustomPainter {
  TestLevelCelebrationPainter({
    required this.progress,
    required this.particles,
  });

  final double progress;
  final List<TestLevelCelebrationParticle> particles;

  @override
  void paint(Canvas canvas, Size size) {
    _paintGlow(canvas, size);
    _paintParticles(canvas, size);
  }

  void _paintGlow(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final glowOpacity = (1 - progress).clamp(0.0, 1.0);
    final glowRadius = 110 * (1 + progress);

    final paint = Paint()
      ..shader = RadialGradient(
        colors: [
          Colors.yellow.withOpacity(0.4 * glowOpacity),
          Colors.transparent,
        ],
      ).createShader(Rect.fromCircle(center: center, radius: glowRadius));

    canvas.drawCircle(center, glowRadius, paint);
  }

  void _paintParticles(Canvas canvas, Size size) {
    final centerX = size.width / 2;

    for (final particle in particles) {
      final loopProgress = (progress + particle.phase) % 1.0;

      final dx =
          cos(particle.angle) * particle.speed * (0.35 + loopProgress) * 170;
      final x = centerX + dx;
      final y =
          size.height - ((size.height + particle.size * 2) * loopProgress);

      final opacity = 0.35 + (0.55 * (1 - (loopProgress - 0.5).abs() * 2));
      final color = particle.color.withOpacity(opacity.clamp(0.0, 1.0));
      final rotation = progress * particle.rotationSpeed * 10;

      if (particle.isCircle) {
        final paint = Paint()..color = color;
        canvas.drawCircle(Offset(x, y), particle.size / 2, paint);
        continue;
      }

      final rect = Rect.fromCenter(
        center: Offset.zero,
        width: particle.size,
        height: particle.size,
      );
      final rrect = RRect.fromRectAndRadius(rect, const Radius.circular(3));
      final paint = Paint()..color = color;

      canvas.save();
      canvas.translate(x, y);
      canvas.rotate(rotation);
      canvas.drawRRect(rrect, paint);
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant TestLevelCelebrationPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.particles != particles;
  }
}
