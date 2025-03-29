import 'package:flutter/material.dart';

class MarkerBgShape extends StatelessWidget {
  final double width;
  final double height;
  final Color color;

  const MarkerBgShape({
    super.key,
    this.width = 48,
    this.height = 59,
    this.color = const Color(0xFF3EBF80),
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(width, height),
      painter: _UnionPainter(color),
    );
  }
}

class _UnionPainter extends CustomPainter {
  final Color color;

  _UnionPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(size.width * 0.5, 0)
      ..cubicTo(
        size.width * 0.2192, 0,
        0, size.height * 0.1785,
        0, size.height * 0.3985,
      )
      ..cubicTo(
        0, size.height * 0.7023,
        size.width * 0.5, size.height * 0.9984,
        size.width * 0.5, size.height * 0.9984,
      )
      ..cubicTo(
        size.width * 0.5, size.height * 0.9984,
        size.width, size.height * 0.7023,
        size.width, size.height * 0.3985,
      )
      ..cubicTo(
        size.width, size.height * 0.1785,
        size.width * 0.7808, 0,
        size.width * 0.5, 0,
      )
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
