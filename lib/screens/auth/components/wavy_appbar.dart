import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../config/res.dart';

class WavyAppBar extends StatefulWidget {
  final bool withBackButton;

  const WavyAppBar({
    super.key,
    this.withBackButton = false,
  });

  @override
  State<WavyAppBar> createState() => _WavyAppBarState();
}

class _WavyAppBarState extends State<WavyAppBar> {
  bool _isLogoVisible = false;

  @override
  void initState() {
    super.initState();
    // Start animation after a short delay
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        _isLogoVisible = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height * 0.30;
    return Stack(
      clipBehavior: Clip.hardEdge,
      children: [
        CustomPaint(
          size: Size(
            MediaQuery.of(context).size.width,
            height,
          ), // Match SVG height
          painter: WavyPainter(),
        ),
        AnimatedPositionedDirectional(
          duration: Duration(milliseconds: 1000), // Animation duration
          curve: Curves.easeInOut, // Smooth transition
          bottom: _isLogoVisible ? 40 : -200, // Moves up from bottom
          top: 28,
          start: 0,
          end: 0,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 28),
              child: AnimatedOpacity(
                duration: Duration(seconds: 1), // Animation duration
                opacity: _isLogoVisible ? 1 : 0.5,
                child: Image.asset(
                  Res.authLogo,
                ),
              ),
            ),
          ),
        ),
        if (widget.withBackButton)
          PositionedDirectional(
            start: 12,
            top: kToolbarHeight,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: SvgPicture.asset(
                Res.backIcon,
              ),
            ),
          )
      ],
    );
  }
}

class WavyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..shader = RadialGradient(
        colors: [
          Color(0xFF42D99C),
          Color(0xFF3EBF80),
        ],
        center: Alignment(0.2, 0.2),
        radius: 1.5,
      ).createShader(
        Rect.fromLTWH(
          0,
          0,
          size.width,
          size.height,
        ),
      );

    Path path = Path();

    path.moveTo(size.width * 1.43, size.height * 0.91);
    path.cubicTo(
      size.width * 1.74,
      size.height * 1.16,
      size.width * 2.07,
      size.height * 0.76,
      size.width * 2.12,
      size.height * 0.63,
    );

    path.lineTo(size.width * 1.05, size.height * -1.28);
    path.lineTo(size.width * -0.23, size.height * 0.28);

    path.cubicTo(
      size.width * -0.22,
      size.height * 0.32,
      size.width * -0.18,
      size.height * 0.45,
      size.width * -0.04,
      size.height * 0.61,
    );

    path.cubicTo(
      size.width * 0.13,
      size.height * 0.82,
      size.width * 0.45,
      size.height * 1.01,
      size.width * 0.65,
      size.height * 0.86,
    );

    path.cubicTo(
      size.width * 1.13,
      size.height * 0.5,
      size.width * 1.03,
      size.height * 0.58,
      size.width * 1.43,
      size.height * 0.91,
    );

    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
