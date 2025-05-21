import 'dart:math';

import 'package:flutter/material.dart';

class RoundedCirclePainter extends CustomPainter {
  final double percentage;
  final Color backgroundColor;
  final Color foregroundColor;

  RoundedCirclePainter({
    required this.backgroundColor,
    required this.foregroundColor,
    required this.percentage,
  });

  @override
  void paint(Canvas canvas, Size size) {
    double strokeWidth = 20;
    double radius = size.width / 2;

    final center = Offset(size.width / 2, size.height / 2);
    final backgroundPaint = Paint()
      ..color = backgroundColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final foregroundPaint = Paint()
      ..shader = LinearGradient(
        colors: [
          foregroundColor,
          foregroundColor,
        ],
      ).createShader(Rect.fromCircle(center: center, radius: radius))
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    // Background Circle
    canvas.drawCircle(center, radius - strokeWidth / 2, backgroundPaint);

    // Foreground Arc
    double startAngle = -pi / 2;
    double sweepAngle = 2 * pi * percentage;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - strokeWidth / 2),
      startAngle,
      sweepAngle,
      false,
      foregroundPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
