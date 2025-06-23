import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:megaplug/config/res.dart';
import 'package:megaplug/presentation/station_details/components/banners.dart';
import 'package:megaplug/widgets/app_widgets/app_text.dart';

class StationDetailsScreen extends StatelessWidget {
  const StationDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              StationBanners(
                sliders: imgList,
              ),
              PositionedDirectional(
                top: kToolbarHeight,
                end: 12,
                start: 12,
                child: Row(
                  children: [
                    InkWell(
                      onTap: Get.back,
                      child: SvgPicture.asset(Res.backIcon),
                    ),
                    Spacer(),
                    AppText(
                      text: 'station_details'.tr,
                      color: Colors.white,
                      centerText: true,
                      fontWeight: FontWeight.bold,
                    ),
                    Spacer(),
                    SvgPicture.asset(Res.shareIcon),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
