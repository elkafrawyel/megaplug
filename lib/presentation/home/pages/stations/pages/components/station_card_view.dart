import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:megaplug/config/extension/space_extension.dart';
import 'package:megaplug/config/extension/station_status.dart';
import 'package:megaplug/config/helpers/map_helper.dart';
import 'package:megaplug/config/res.dart';
import 'package:megaplug/config/theme/color_extension.dart';
import 'package:megaplug/presentation/home/pages/stations/controller/stations_controller.dart';
import 'package:megaplug/presentation/home/pages/stations/pages/components/corder_banner.dart';
import 'package:megaplug/widgets/app_widgets/app_network_image.dart';

import '../../../../../../../domain/entities/firebase/firebase_station_model.dart';
import '../../../../../../../widgets/app_widgets/app_text.dart';
import '../../../../../station_details/station_details_screen.dart';

class StationCardView extends StatefulWidget {
  final FirebaseStationModel stationModel;
  final bool inMapView;

  const StationCardView({
    super.key,
    required this.stationModel,
    this.inMapView = false,
  });

  @override
  State<StationCardView> createState() => StationCardViewState();
}

class StationCardViewState extends State<StationCardView> {
  late FirebaseStationModel stationModel;
  FirebaseStationModel? stationInDialog;
  final StationsController _stationsController = Get.find<StationsController>();

  @override
  dispose() {
    //stop updating the dialog
    stationInDialog = null;
    _stationsController.stationModelInDialog = null;
    super.dispose();
  }

  //only used from maps dialog
  reBuild({FirebaseStationModel? model}) {
    setState(() {
      stationInDialog = model;
    });
  }

  @override
  Widget build(BuildContext context) {
    stationModel = stationInDialog ?? widget.stationModel;

    Color statusColor = stationModel.getStationStatus().color;
    bool isDc = stationModel.hasDcConnectors();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Card(
            margin: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            color: Colors.white,
            elevation: widget.inMapView ? 10 : 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.only(
                        start: 18,
                        end: 4,
                        top: 24,
                      ),
                      child: AppNetworkImage(
                        imageUrl: widget.stationModel.image ?? '',
                        height: 70,
                        width: 70,
                        fit: BoxFit.cover,
                        radius: 8,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          18.ph,
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: AppText(
                              text: stationModel.getName(),
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              maxLines: 3,
                            ),
                          ),
                          SizedBox(height: 8),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: AppText(
                              text: stationModel.getAddress(),
                              fontWeight: FontWeight.w400,
                              fontSize: 11,
                            ),
                          ),
                          SizedBox(height: 8),
                          Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            runSpacing: 8,
                            spacing: 8,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    size: 20,
                                    color: statusColor,
                                  ),
                                  SizedBox(width: 2),
                                  AppText(
                                    text: '${_stationsController.getDistance(
                                      stationModel.latitude!,
                                      stationModel.longitude!,
                                    )} ${'km'.tr}',
                                    fontSize: 11,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.power,
                                    size: 20,
                                    color: statusColor,
                                  ),
                                  SizedBox(width: 2),
                                  AppText(
                                    text:
                                        '${stationModel.getTotalConnectors()} ${stationModel.getTotalConnectors() == 1 ? 'connector'.tr : 'connectors'.tr}',
                                    fontSize: 11,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SvgPicture.asset(
                                    isDc ? Res.fastCharge2Icon : Res.lightningIcon,
                                    colorFilter: ColorFilter.mode(
                                      isDc ? Color(0xffFFA800) : statusColor,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                  SizedBox(width: 2),
                                  AppText(
                                    text: '${stationModel.getChargingPowerText()} ${'kw'.tr}',
                                    fontSize: 11,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                20.ph,
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              MapHelper.openMap(
                                stationModel.location.latitude,
                                stationModel.location.longitude,
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xff6C7E8E),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
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
                          ),
                        ),
                        10.pw,
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              // Get.find<StationsController>().showComingSoonDialog(Get.context!);
                              Get.to(
                                () => StationDetailsScreen(
                                  // stationId: '5',
                                  stationId: stationModel.id!,
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xff3EBF80),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SvgPicture.asset(
                                        Res.connectCarIcon,
                                      ),
                                      10.pw,
                                      Flexible(
                                        child: AppText(
                                          text: 'station_details'.tr,
                                          color: context.kColorOnPrimary,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                10.ph,
              ],
            ),
          ),
          PositionedDirectional(
            end: 0,
            top: 0,
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
                text: stationModel.getStationStatus().text.tr,
                color: context.kColorOnPrimary,
                fontSize: 12,
              ),
            ),
          ),
          if (isDc)
            PositionedDirectional(
              top: -5,
              start: -7,
              child: CornerBanner(text: 'fast_charge'.tr),
            ),
        ],
      ),
    );
  }
}
