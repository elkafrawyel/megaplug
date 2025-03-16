import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../config/res.dart';

class WavyAppBar extends StatefulWidget {
  final bool withBackButton;

  const WavyAppBar({
    super.key,
    this.withBackButton = true,
  });

  @override
  State<WavyAppBar> createState() => _WavyAppBarState();
}

class _WavyAppBarState extends State<WavyAppBar> {
  bool _isLogoVisible = false;
  bool _isBackVisible = false;

  @override
  void initState() {
    super.initState();
    // Start animation after a short delay
    Future.delayed(Duration(milliseconds: 300), () {
      setState(() {
        _isLogoVisible = true;
      });
    });
    if (widget.withBackButton) {
      Future.delayed(Duration(milliseconds: 800), () {
        setState(() {
          _isBackVisible = true;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height * 0.30;
    double width = MediaQuery.sizeOf(context).width;
    return Stack(
      clipBehavior: Clip.hardEdge,
      children: [
        SvgPicture.asset(
          Res.wavyAppBarBgIcon,
          width: width,
          fit: BoxFit.fitHeight,
        ),
        // CustomPaint(
        //   size: Size(MediaQuery.of(context).size.width, 150),
        //   painter: AppBarPainter(),
        // ),
        AnimatedPositionedDirectional(
          duration: Duration(milliseconds: 1500),
          // Animation duration
          curve: Curves.easeInOut,
          // Smooth transition
          top: _isLogoVisible ? kToolbarHeight : -300,
          // Moves up from bottom
          start: 0,
          end: 0,
          child: AnimatedOpacity(
            duration: Duration(seconds: 1),
            opacity: _isLogoVisible ? 1 : 0.5,
            child: Image.asset(
              Res.authLogo,
              width: 150,
              height: 150,
            ),
          ),
        ),
        if (widget.withBackButton)
          AnimatedPositionedDirectional(
            duration: Duration(milliseconds: 1000),
            curve: Curves.easeInOut,
            start: _isBackVisible ? 12 : -50,
            top: kToolbarHeight,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: SvgPicture.asset(
                Res.backIcon,
                matchTextDirection: true,
              ),
            ),
          )
      ],
    );
  }
}

class AppBarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    Path path = Path();


    // Path number 1


    paint.color = Color(0xff001cd4);
    path = Path();
    path.lineTo(size.width * 0.61, size.height * 0.4);
    path.cubicTo(size.width * 0.74, size.height * 0.51, size.width * 0.88, size.height * 0.34, size.width * 0.9, size.height * 0.28);
    path.cubicTo(size.width * 0.9, size.height * 0.28, size.width * 0.45, -0.56, size.width * 0.45, -0.56);
    path.cubicTo(size.width * 0.45, -0.56, -0.1, size.height * 0.12, -0.1, size.height * 0.12);
    path.cubicTo(-0.09, size.height * 0.14, -0.08, size.height / 5, -0.02, size.height * 0.27);
    path.cubicTo(size.width * 0.05, size.height * 0.36, size.width * 0.19, size.height * 0.45, size.width * 0.28, size.height * 0.38);
    path.cubicTo(size.width * 0.48, size.height * 0.22, size.width * 0.44, size.height * 0.26, size.width * 0.61, size.height * 0.4);
    path.cubicTo(size.width * 0.61, size.height * 0.4, size.width * 0.61, size.height * 0.4, size.width * 0.61, size.height * 0.4);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
