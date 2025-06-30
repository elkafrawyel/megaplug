import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:megaplug/config/extension/space_extension.dart';
import 'package:megaplug/config/extension/station_status.dart';
import 'package:megaplug/config/res.dart';
import 'package:megaplug/config/theme/color_extension.dart';
import 'package:megaplug/presentation/station_details/components/banners.dart';
import 'package:megaplug/presentation/station_details/components/page_tab.dart';
import 'package:megaplug/presentation/station_details/controller/station_details_controller.dart';
import 'package:megaplug/widgets/app_widgets/app_text.dart';

import '../../config/helpers/map_helper.dart';

class StationDetailsScreen extends StatelessWidget {
  const StationDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    StationStatus stationStatus = StationStatus.available;
    Color statusColor = stationStatus.color;
    // Color statusColor = stationModel.getStationStatus().color;

    return GetBuilder<StationDetailsController>(builder: (stationDetailsController) {
      return Scaffold(
        backgroundColor: context.kBackgroundColor,
        extendBodyBehindAppBar: true,
        bottomNavigationBar: GestureDetector(
          onTap: () {
            // MapHelper.openMap(
            //   stationModel.location.latitude,
            //   stationModel.location.longitude,
            // );
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            decoration: BoxDecoration(
              color: context.kPrimaryColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    Res.directionsIcon,
                  ),
                  10.pw,
                  Flexible(
                    child: AppText(
                      text: 'get_directions'.tr,
                      color: context.kColorOnPrimary,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
              expandedHeight: MediaQuery.sizeOf(context).height * 0.3,

                backgroundColor: Colors.transparent,
                elevation: 0,
                floating: true,
                leading: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: InkWell(
                    onTap: Get.back,
                    child: SvgPicture.asset(Res.backIcon),
                  ),
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset(Res.shareIcon),
                  ),
                ],
                title: AppText(
                  text: 'station_details'.tr,
                  color: Colors.white,
                  centerText: true,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                centerTitle: true,
                flexibleSpace: StationBanners(
                  sliders: imgList, // Assuming imgList is defined somewhere
                ),
              ),

            ];
          },
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(18.0),
                    ),
                  ),
                  child: Column(
                    children: [
                      Align(
                        alignment: AlignmentDirectional.centerEnd,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: statusColor,
                            borderRadius: BorderRadiusDirectional.only(
                              topEnd: Radius.circular(12),
                              bottomStart: Radius.circular(12),
                            ),
                          ),
                          child: AppText(
                            text: stationStatus.text.tr,
                            color: context.kColorOnPrimary,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      20.ph,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Row(
                          children: [
                            AppText(
                              text: 'Chilout Madinaty',
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            Spacer(),
                            SvgPicture.asset(
                              Res.starIcon,
                            ),
                            5.pw,
                            AppText(
                              text: '4.9',
                              fontWeight: FontWeight.w500,
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0,vertical: 8.0),
                        child: Row(
                          children: [
                            SvgPicture.asset(Res.locationIcon),
                            5.pw,
                            AppText(
                              text: 'Cairo , nasser city , 31 abas el akad , behind kfc',
                              maxLines: 3,
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color(0xffFAFAFA),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  AppText(text: 'Open'),
                                  10.pw,
                                  Container(
                                    width: 7,
                                    height: 7,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: context.kPrimaryColor,
                                    ),
                                  ),
                                  10.pw,
                                  AppText(text: '10:00 - 23:00')
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0,vertical: 8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xffFAFAFA),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: PageTab(
                                    index: 0,
                                    title: 'details',
                                  ),
                                ),
                                20.pw,
                                Expanded(
                                  child: PageTab(
                                    index: 1,
                                    title: 'amenities',
                                  ),
                                ),
                                20.pw,
                                Expanded(
                                  child: PageTab(
                                    index: 2,
                                    title: 'reviews',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      10.ph,
                      stationDetailsController.pages[stationDetailsController.pageIndex],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

class _SliverHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  _SliverHeaderDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => true;
}
