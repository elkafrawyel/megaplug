import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'components/pages/map/map_view.dart';
import 'components/pages/components/stations_appbar.dart';
import 'components/pages/stations_list/stations_list.dart';
import 'controller/stations_controller.dart';

class StationsScreen extends StatefulWidget {
  const StationsScreen({super.key});

  @override
  State<StationsScreen> createState() => _StationsScreenState();
}

class _StationsScreenState extends State<StationsScreen>
    with AutomaticKeepAliveClientMixin {
  final stationsController = Get.find<StationsController>();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: StationsAppbar(
        height: 100,
      ),
      body: GetBuilder<StationsController>(
        id: StationsController.stationsControllerId,
        builder: (_) => IndexedStack(
          index: stationsController.mapView ? 0 : 1,
          children: [
            MapView(),
            StationsList(),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
