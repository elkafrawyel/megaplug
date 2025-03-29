import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:megaplug/config/res.dart';
import 'package:megaplug/presentation/home/pages/stations/components/marker_bg.dart';
import 'package:megaplug/widgets/app_widgets/app_text.dart';

import '../../../../../config/helpers/logging_helper.dart';

class CustomMarkerView extends StatelessWidget {
  final String count;

  const CustomMarkerView({super.key, required this.count});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        MarkerBgShape(width: 70, height: 85),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Container(
            width: 62,
            height: 62,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
            ),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    Res.strokeIcon,
                    width: 13,
                  ),
                  AppText(
                    text: count,
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
