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
    return Scaffold(
      body: Stack(
        clipBehavior: Clip.none,
        fit: StackFit.expand,
        children: [
          PositionedDirectional(
            top: 0,
            end: 0,
            start: 0,
            child: StationBanners(
              sliders: imgList,
            ),
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
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                Spacer(),
                SvgPicture.asset(Res.shareIcon),
              ],
            ),
          ),
          PositionedDirectional(
            top: (MediaQuery.sizeOf(context).height * 0.4) - 50,
            end: 0,
            start: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(18.0),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: AppText(
                        text: 'Chilout Madinaty',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: AppText(
                        text: 'Chilout Madinaty',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: AppText(
                        text: 'Chilout Madinaty',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: AppText(
                        text: 'Chilout Madinaty',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: AppText(
                        text: 'Chilout Madinaty',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: AppText(
                        text: 'Chilout Madinaty',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: AppText(
                        text: 'Chilout Madinaty',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: AppText(
                        text: 'Chilout Madinaty',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: AppText(
                        text: 'Chilout Madinaty',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: AppText(
                        text: 'Chilout Madinaty',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: AppText(
                        text: 'Chilout Madinaty',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: AppText(
                        text: 'Chilout Madinaty',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: AppText(
                        text: 'Chilout Madinaty',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: AppText(
                        text: 'Chilout Madinaty',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: AppText(
                        text: 'Chilout Madinaty',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: AppText(
                        text: 'Chilout Madinaty',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
