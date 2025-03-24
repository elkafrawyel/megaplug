import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:megaplug/widgets/app_widgets/app_network_image.dart';
import 'package:megaplug/widgets/app_widgets/app_text.dart';

import '../../../../../widgets/app_widgets/app_bars/home_appbar.dart';

class HeaderView extends StatelessWidget {
  final double imageHeight;
  final double height;

  const HeaderView({
    super.key,
    required this.imageHeight,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.loose,
      clipBehavior: Clip.none,
      children: [
        HomeAppbar(
          title: 'profile'.tr,
          height: height,
        ),
        PositionedDirectional(
          bottom: -imageHeight / 2,
          start: 0,
          end: 0,
          child: AppNetworkImage(
            imageUrl:
                'https://images.healthshots.com/healthshots/en/uploads/2020/12/08182549/positive-person.jpg',
            isCircular: true,
            height: imageHeight,
            width: imageHeight,
            fit: BoxFit.contain,
            borderColor: Color(0xff9DB2CE),
            borderWidth: 4,
          ),
        )
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
      ).createShader(
        Rect.fromCircle(
          center: Offset(183.5, -132.5),
          radius: 580.5,
        ),
      );

    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(183.5, -132.5),
        width: 580.5 * 2,
        height: size.height * 2,
      ),
      ellipsePaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
