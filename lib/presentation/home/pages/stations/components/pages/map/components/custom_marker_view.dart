import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:megaplug/config/extension/station_status.dart';
import 'package:megaplug/config/res.dart';
import 'package:megaplug/presentation/home/pages/stations/components/pages/map/components/marker_bg.dart';
import 'package:megaplug/widgets/app_widgets/app_text.dart';

class CustomMarkerView extends StatelessWidget {
  final String? count;
  final StationStatus stationStatus;
  final bool isDc;

  const CustomMarkerView({
    super.key,
    this.count,
    required this.stationStatus,
    this.isDc = false,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        MarkerBgShape(
          width: 70,
          height: 85,
          color: stationStatus.color,
        ),
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
                    isDc && count == null ? Res.xIcon : Res.strokeIcon,
                    width: count == null ? 20 : 13,
                    colorFilter: ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                  Offstage(
                    offstage: count == null,
                    child: AppText(
                      text: count ?? '',
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
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
