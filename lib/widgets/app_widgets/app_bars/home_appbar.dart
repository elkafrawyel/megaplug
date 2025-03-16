import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:megaplug/config/theme/color_extension.dart';
import 'package:megaplug/widgets/custom_painter/home_header.dart';

import '../../../config/res.dart';
import '../app_text.dart';

class HomeAppbar extends StatefulWidget {
  final String title;
  final List<Widget>? actions;
  final bool withBackButton;

  const HomeAppbar({
    super.key,
    required this.title,
    this.actions,
    this.withBackButton = false,
  });

  @override
  State<HomeAppbar> createState() => _AppAppbarState();
}

class _AppAppbarState extends State<HomeAppbar> {
  bool _isBackVisible = false;
  bool _isTitleVisible = false;

  @override
  void initState() {
    super.initState();

    if (widget.withBackButton) {
      Future.delayed(Duration(milliseconds: 800), () {
        setState(() {
          _isBackVisible = true;
        });
      });
    }

    // Start animation after a short delay
    Future.delayed(Duration(milliseconds: 300), () {
      setState(() {
        _isTitleVisible = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height * 0.15;
    double width = MediaQuery.sizeOf(context).width;

    return Stack(
      children: [
        CustomPaint(
          size: Size(
            width,
            height,
          ),
          painter: AppBarPainter(),
        ),
        // SvgPicture.asset(
        //   Res.homeAppBarBg,
        //   width: width,
        //   fit: BoxFit.fitHeight,
        // ),
        if (widget.withBackButton)
          AnimatedPositionedDirectional(
            duration: Duration(milliseconds: 1000),
            curve: Curves.easeInOut,
            start: _isBackVisible ? 12 : -50,
            top: 0,
            bottom: 0,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: SvgPicture.asset(
                Res.backIcon,
              ),
            ),
          ),
        AnimatedPositionedDirectional(
          duration: Duration(milliseconds: 1500),
          // Animation duration
          curve: Curves.easeInOut,
          // Smooth transition
          top: _isTitleVisible ? 0 : -300,
          bottom: 0,
          // Moves up from bottom
          start: 0,
          end: 0,
          child: Center(
            child: AppText(
              text: widget.title,
              color: context.kColorOnPrimary,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}

class AppBarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint ellipsePaint = Paint()
      ..shader = RadialGradient(
        colors: [
          Color(0xff42D99C),
          Color(0xff3EBF80),
        ],
      ).createShader(Rect.fromCircle(
        center: Offset(183.5, -132.5),
        radius: 580.5,
      ));

    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(183.5, -132.5),
        width: 580.5 * 2,
        height: 240.5 * 2,
      ),
      ellipsePaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
