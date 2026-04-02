import 'package:flutter/material.dart';
import 'package:isharaapp/features/home/presentation/screens/widgets/test_level_celebration_foreground.dart';
import 'package:isharaapp/features/home/presentation/screens/widgets/test_level_celebration_painter.dart';
import 'package:isharaapp/features/home/presentation/screens/widgets/test_level_celebration_particle.dart';
import 'package:isharaapp/features/home/presentation/screens/widgets/test_level_celebration_particle_factory.dart';

class TestLevelCelebrationOverlay extends StatefulWidget {
  const TestLevelCelebrationOverlay({
    super.key,
    required this.burstMode,
  });

  final bool burstMode;

  @override
  State<TestLevelCelebrationOverlay> createState() =>
      _TestLevelCelebrationOverlayState();
}

class _TestLevelCelebrationOverlayState
    extends State<TestLevelCelebrationOverlay>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  List<TestLevelCelebrationParticle> _particles = const [];

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.burstMode ? 2200 : 3200),
    )..repeat();

    _particles = TestLevelCelebrationParticleFactory.generate(
      burstMode: widget.burstMode,
    );
  }

  @override
  void didUpdateWidget(covariant TestLevelCelebrationOverlay oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.burstMode != widget.burstMode) {
      _controller.duration =
          Duration(milliseconds: widget.burstMode ? 2200 : 3200);
      _particles = TestLevelCelebrationParticleFactory.generate(
        burstMode: widget.burstMode,
      );
      _controller
        ..reset()
        ..repeat();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: RepaintBoundary(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (_, __) {
            final progress = _controller.value;

            return Stack(
              children: [
                Positioned.fill(
                  child: CustomPaint(
                    painter: TestLevelCelebrationPainter(
                      progress: progress,
                      particles: _particles,
                    ),
                  ),
                ),
                TestLevelCelebrationForeground(progress: progress),
              ],
            );
          },
        ),
      ),
    );
  }
}
