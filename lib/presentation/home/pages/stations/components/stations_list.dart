import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../../config/res.dart';
import '../../../../../domain/controllers/stations_controller.dart';

class StationsList extends StatelessWidget {
  const StationsList({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StationsController>(
      builder: (stationsController) => Stack(
        children: [
          Center(
            child: Text(
              'List View',
            ),
          ),
          PositionedDirectional(
            end: 18,
            top: MediaQuery.sizeOf(context).height * 0.8,
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
      ),
    );
  }
}
