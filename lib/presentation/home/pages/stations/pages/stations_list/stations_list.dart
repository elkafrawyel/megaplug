import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:megaplug/config/extension/space_extension.dart';
import '../../../../../../../config/res.dart';
import '../../../../../../config/helpers/logging_helper.dart';
import '../../controller/stations_controller.dart';
import '../components/station_card_view.dart';
import 'components/empty_view.dart';

class StationsList extends StatelessWidget {
  const StationsList({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StationsController>(
        id: StationsController.stationsControllerId,
        builder: (stationsController) {
          return Stack(
            children: [
              stationsController.stations.isEmpty
                  ? EmptyView()
                  : Padding(
                      padding: const EdgeInsets.only(
                        top: 24,
                        left: 12,
                        right: 12,
                      ),
                      child: ListView.separated(
                        itemBuilder: (context, index) => StationCardView(stationModel: stationsController.stations[index]),
                        separatorBuilder: (context, index) => 5.ph,
                        itemCount: stationsController.stations.length,
                      ),
                    ),
              PositionedDirectional(
                end: 18,
                top: MediaQuery.sizeOf(context).height * 0.80,
                child: GestureDetector(
                  onTap: () {
                    stationsController.toggleMapView();
                  },
                  child: SvgPicture.asset(
                    Res.mapIcon,
                    width: 40,
                    height: 40,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ],
          );
        });
  }
}
