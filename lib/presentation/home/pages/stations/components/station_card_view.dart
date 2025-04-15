import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:megaplug/config/extension/space_extension.dart';
import 'package:megaplug/config/res.dart';
import 'package:megaplug/config/theme/color_extension.dart';
import 'package:megaplug/domain/controllers/stations_controller.dart';
import 'package:megaplug/presentation/station_details/station_details_screen.dart';
import 'package:megaplug/widgets/app_widgets/app_network_image.dart';

import '../../../../../domain/entities/station_model.dart';
import '../../../../../widgets/app_widgets/app_text.dart';

class StationCardView extends StatelessWidget {
  final StationModel stationModel;

  StationCardView({
    super.key,
    required this.stationModel,
  });

  final StationsController stationsController = Get.find<StationsController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Card(
            margin: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            color: Colors.white,
            elevation: 10,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 8.0),
                      child: AppNetworkImage(
                        imageUrl:
                            'https://img.freepik.com/free-vector/cartoon-style-gas-station-background_52683-79920.jpg',
                        height: 90,
                        width: 90,
                        fit: BoxFit.cover,
                        radius: 8,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: AppText(
                                  text: stationModel.name,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 4),
                          AppText(
                            text: 'Cairo , nasser city , 31 abas el akad',
                            fontWeight: FontWeight.w400,
                            fontSize: 13,
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                size: 20,
                                color: context.kPrimaryColor,
                              ),
                              SizedBox(width: 4),
                              Text('${'10'} Km'),
                              SizedBox(width: 8),
                              Icon(
                                Icons.power,
                                size: 20,
                                color: context.kPrimaryColor,
                              ),
                              SizedBox(width: 4),
                              Text('${8} connectors'),
                              SizedBox(width: 8),
                              Icon(
                                Icons.bolt,
                                size: 20,
                                color: context.kPrimaryColor,
                              ),
                              SizedBox(width: 4),
                              Text('${'22-50 W'}'),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          icon: SvgPicture.asset(
                            Res.directionsIcon,
                          ),
                          label: AppText(
                            text: 'Get Directions',
                            color: context.kColorOnPrimary,
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff6C7E8E),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () {},
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton.icon(
                          icon: SvgPicture.asset(
                            Res.connectCarIcon,
                          ),
                          label: AppText(
                            text: 'Station Details',
                            color: context.kColorOnPrimary,
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff3EBF80),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () {
                            Get.to(() => StationDetailsScreen());
                          },
                        ),
                      ),
                    ],
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
                horizontal: 8,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                color: context.kPrimaryColor,
                borderRadius: BorderRadiusDirectional.only(
                  topEnd: Radius.circular(12),
                  bottomStart: Radius.circular(12),
                ),
              ),
              child: AppText(
                text: 'Available',
                color: context.kColorOnPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
