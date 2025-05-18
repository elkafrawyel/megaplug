import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:megaplug/config/res.dart';

import '../../../../../../widgets/app_widgets/app_text.dart';

class CornerBanner extends StatelessWidget {
  final String text;
  final Color color;
  final double height;

  const CornerBanner({
    super.key,
    required this.text,
    this.color = const Color(0xffFFA800),
    this.height = 32,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: 85,
          height: 85,
          child: SvgPicture.asset(
            Res.fastChargeBannerIcon,
          ),
        ),
        PositionedDirectional(
          top: 20,
          child: Transform.rotate(
            angle: -0.785,
            child: AppText(
              text: text,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 11,
            ),
          ),
        )
      ],
    );
  }
}
