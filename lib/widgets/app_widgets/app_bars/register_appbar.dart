import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:megaplug/config/theme/color_extension.dart';
import 'package:megaplug/widgets/custom_painter/home_header.dart';

import '../../../config/res.dart';
import '../app_text.dart';

class RegisterAppbar extends StatefulWidget {
  final String title;
  final List<Widget>? actions;
  final bool withBackButton;

  const RegisterAppbar({
    super.key,
    required this.title,
    this.actions,
    this.withBackButton = false,
  });

  @override
  State<RegisterAppbar> createState() => _AppAppbarState();
}

class _AppAppbarState extends State<RegisterAppbar> {
  bool _isBackVisible = false;
  bool _isTitleVisible = false;

  @override
  void initState() {
    super.initState();

    // Start animation after a short delay
    Future.delayed(Duration(milliseconds: 300), () {
      setState(() {
        _isTitleVisible = true;
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
    double height = MediaQuery.sizeOf(context).height * 0.15;
    double width = MediaQuery.sizeOf(context).width;

    return Stack(
      children: [
        SvgPicture.asset(
          Res.registerAppBarBgIcon,
          width: width,
          fit: BoxFit.fitHeight,
        ),
        // CustomPaint(
        //   size: Size(MediaQuery.of(context).size.width, height),
        //   painter: RegisterAppBarPainter(),
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
                width: 28,
                height: 28,
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
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

class RegisterAppBarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Path path = Path();
    path.moveTo(763.217, -104.4);
    path.cubicTo(937.037, -91.6304, 1032.68, -283.113, 1037.41,
        -384.237); // Increased height
    path.lineTo(96.666, -739.107); // Adjusted height
    path.lineTo(-75.9584, 49.7504);
    path.cubicTo(-68.2026, 60.9334, -31.6356, 88.9059, 52.5853, 111.332);
    path.cubicTo(157.861, 139.364, 328.331, 130.868, 400.769, 41.3316);
    path.cubicTo(569.459, -167.175, 534.309, -121.217, 763.217, -104.4);
    path.close();

    final Paint paint = Paint()
      ..color = Colors.blueAccent; // Adjust color as needed
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
