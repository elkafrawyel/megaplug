import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:megaplug/config/extension/space_extension.dart';
import 'package:megaplug/config/theme/color_extension.dart';
import 'package:megaplug/domain/entities/api/amenity_model.dart';
import 'package:megaplug/presentation/station_details/controller/station_details_controller.dart';
import 'package:megaplug/widgets/app_widgets/app_network_image.dart';
import 'package:megaplug/widgets/app_widgets/app_text.dart';

import '../../../data/api_responses/station_details_response.dart';

class AmenitiesView extends StatelessWidget {
  const AmenitiesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GetBuilder<StationDetailsController>(
        builder: (stationDetailsController) {
          Station? stationModel = stationDetailsController.stationDetailsResponse?.data?.station;
          return Wrap(
              runSpacing: 20,
              children: (stationModel?.amenities ?? [])
                  .map(
                    (AmenityModel element) => SizedBox(
                      width: (MediaQuery.of(context).size.width - 34) / 2, // 2 per row with spacing
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.network(
                            element.imageUrl ?? '',
                            width: 40,
                            height: 40,
                          ),
                          10.pw,
                          Expanded(
                            child: AppText(
                              text: element.toString(),
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              maxLines: 3,
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                  .toList());
        },
      ),
    );
  }
}
