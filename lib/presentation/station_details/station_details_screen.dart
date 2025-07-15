import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:megaplug/config/extension/space_extension.dart';
import 'package:megaplug/config/extension/station_status.dart';
import 'package:megaplug/config/res.dart';
import 'package:megaplug/config/theme/color_extension.dart';
import 'package:megaplug/data/repositories/stations_repo.dart';
import 'package:megaplug/presentation/home/pages/stations/controller/stations_controller.dart';
import 'package:megaplug/presentation/station_details/components/banners.dart';
import 'package:megaplug/presentation/station_details/components/page_tab.dart';
import 'package:megaplug/presentation/station_details/controller/station_details_controller.dart';
import 'package:megaplug/widgets/app_widgets/app_text.dart';

import '../../config/helpers/map_helper.dart';
import '../../data/api_responses/station_details_response.dart';

class StationDetailsScreen extends StatelessWidget {
  final String stationId;

  const StationDetailsScreen({super.key, required this.stationId});

  @override
  Widget build(BuildContext context) {
    StationStatus stationStatus = StationStatus.available;
    Color statusColor = stationStatus.color;
    // Color statusColor = stationModel.getStationStatus().color;

    return GetBuilder<StationDetailsController>(
      init: StationDetailsController(
        stationId: stationId,
        stationsRepository: Get.find<StationsRepositoryImpl>(),
      ),
      builder: (stationDetailsController) {
        Station? stationModel = stationDetailsController.stationDetailsResponse?.data?.station;
        return stationDetailsController.loading
            ? Center(child: CircularProgressIndicator.adaptive())
            : Scaffold(
                backgroundColor: context.kBackgroundColor,
                extendBodyBehindAppBar: true,
                bottomNavigationBar: GestureDetector(
                  onTap: () {
                    if (stationModel?.latLng() != null) {
                      MapHelper.openMap(
                        stationModel!.latLng().latitude,
                        stationModel.latLng().longitude,
                      );
                    }
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
                        expandedHeight: MediaQuery.sizeOf(context).height * 0.23,
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
                          InkWell(
                            onTap: () {
                              Get.find<StationsController>().showComingSoonDialog(Get.context!);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SvgPicture.asset(Res.shareIcon),
                            ),
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
                          sliders: stationModel?.images ?? [],
                        ),
                      ),
                    ];
                  },
                  body: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(18.0),
                      ),
                    ),
                    child: SingleChildScrollView(
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
                          10.ph,
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 18.0),
                            child: Row(
                              children: [
                                AppText(
                                  text: stationModel?.toString() ?? '',
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                Spacer(),
                                SvgPicture.asset(
                                  Res.starIcon,
                                ),
                                5.pw,
                                AppText(
                                  text: stationModel?.averageRating?.toString() ?? '',
                                  fontWeight: FontWeight.w500,
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
                            child: Row(
                              children: [
                                SvgPicture.asset(Res.locationIcon),
                                5.pw,
                                AppText(
                                  text: stationModel?.address() ?? '',
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
                                      AppText(
                                        text: (stationModel?.todayWorkingHours?.isActive ?? false) ? 'open'.tr : 'close'.tr,
                                      ),
                                      10.pw,
                                      Container(
                                        width: 7,
                                        height: 7,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: (stationModel?.todayWorkingHours?.isActive ?? false) ? context.kPrimaryColor : context.kErrorColor,
                                        ),
                                      ),
                                      10.pw,
                                      AppText(
                                          text:
                                              '${stationModel?.todayWorkingHours?.startTime ?? ''} - ${stationModel?.todayWorkingHours?.endTime ?? ''}')
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
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
                  ),
                ),
              );
      },
    );
  }
}
