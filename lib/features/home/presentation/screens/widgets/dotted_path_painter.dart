import 'package:flutter/material.dart';

class DottedPathPainter extends CustomPainter {
  final ThemeMode themeMode;

  const DottedPathPainter({required this.themeMode});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = themeMode == ThemeMode.dark ? Colors.white : Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    final path = Path();

    final start = Offset(size.width * 0.06 + 140, size.height * 0.05 + 30);

    final p2 = Offset(size.width * 0.8, size.height * 0.23);
    final p3 = Offset(size.width * 0.18, size.height * 0.38);
    final p4 = Offset(size.width * 0.78, size.height * 0.58);
    final p5 = Offset(size.width * 0.50, size.height * 0.87);

    path.moveTo(start.dx, start.dy);

    path.quadraticBezierTo(size.width * 0.45, size.height * 0.10, p2.dx, p2.dy);

    path.quadraticBezierTo(size.width * 0.55, size.height * 0.30, p3.dx, p3.dy);

    path.quadraticBezierTo(size.width * 0.48, size.height * 0.50, p4.dx, p4.dy);

    path.quadraticBezierTo(size.width * 0.52, size.height * 0.75, p5.dx, p5.dy);

    // dotted effect
    const dashWidth = 8.0;
    const dashSpace = 6.0;

    for (final metric in path.computeMetrics()) {
      double distance = 0.0;
      while (distance < metric.length) {
        final extract = metric.extractPath(distance, distance + dashWidth);
        canvas.drawPath(extract, paint);
        distance += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    if (oldDelegate is DottedPathPainter) {
      return oldDelegate.themeMode != themeMode;
    }
    return true;
  }
}
