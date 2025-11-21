import 'package:flutter/material.dart';

class ThinArrowIcon extends StatelessWidget {
  final Color color;
  final double strokeWidth;
  final double size;

  const ThinArrowIcon({
    super.key,
    this.color = Colors.black,
    this.strokeWidth = 2,
    this.size = 40,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _ThinArrowPainter(color, strokeWidth),
      ),
    );
  }
}

class _ThinArrowPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;

  _ThinArrowPainter(this.color, this.strokeWidth);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final start = Offset(size.width * 0.05, size.height * 0.5);
    final end = Offset(size.width * 0.85, size.height * 0.5);
    canvas.drawLine(start, end, paint);

    final arrow1 = Offset(size.width * 0.65, size.height * 0.3);
    final arrow2 = Offset(size.width * 0.65, size.height * 0.7);
    canvas.drawLine(end, arrow1, paint);
    canvas.drawLine(end, arrow2, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
