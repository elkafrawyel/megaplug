import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:megaplug/config/theme/color_extension.dart';
import 'package:megaplug/widgets/app_transformation_view.dart';

import '../../../config/res.dart';
import '../../../widgets/app_widgets/app_text.dart';

class HomeAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String svgAssetPath;
  final double height;
  final String title;
  final List<Widget>? actions;
  final bool showBackButton;
  final Color? backgroundColor;
  final double svgOpacity;

  const HomeAppbar({
    super.key,
    required this.svgAssetPath,
    required this.title,
    this.height = 80,
    this.actions,
    this.showBackButton = false,
    this.backgroundColor,
    this.svgOpacity = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: kToolbarHeight,
      backgroundColor: backgroundColor ?? Colors.transparent,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      centerTitle: true,
      title: AppText(
        text: title,
        color: context.kColorOnPrimary,
        fontSize: 16,
        fontWeight: FontWeight.w700,
      ),
      actions: actions,
      leadingWidth: 50,
      leading: showBackButton
          ? GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: AppTransformationView(
                  child: SvgPicture.asset(
                    Res.backIcon,
                  ),
                ),
              ),
            )
          : SizedBox(),
      flexibleSpace: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: svgOpacity,
              child: CustomPaint(
                painter: EllipsePainter(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}

class EllipsePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);

    // Create a mask (though Flutter doesn't have exact SVG mask support)
    // We'll just draw the ellipse directly

    // Create the radial gradient
    final gradient = RadialGradient(
      center: const Alignment(0, -2.45),
      // Adjusted to match SVG positioning
      radius: 1.0,
      colors: const [
        Color(0xFF42D99C),
        Color(0xFF3EBF80),
      ],
      stops: const [0.0, 1.0],
      transform: const GradientRotation(
        90 * (3.1415926535 / 180),
      ),
    );

    // Create the paint with the gradient
    final paint = Paint()
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.fill;

    // Draw the ellipse
    // Note: The ellipse is positioned above the visible area (cy = -132.5)
    // So we adjust the position to make it partially visible
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(size.width / 2, -132.5),
        width: 1161, // rx * 2 = 580.5 * 2
        height: 530, // ry * 2 = 240.5 * 2
      ),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
