import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class HomeHeader extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..shader = ui.Gradient.linear(
        Offset(0, 0),
        Offset(size.width, size.height),
        [Color(0xFF3EBF80), Color(0xFF42D99C)],
      )
      ..style = PaintingStyle.fill;

    Path path = Path()
      ..moveTo(784.971, -83.0116)
      ..cubicTo(900, -75, 1000, -220, 1050, -280)
      ..lineTo(318.42, -500)
      ..lineTo(-54.2044, 50)
      ..cubicTo(-40, 70, -10, 90, 70, 110)
      ..cubicTo(160, 130, 330, 120, 400, 50)
      ..cubicTo(550, -100, 530, -80, 750, -70)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}