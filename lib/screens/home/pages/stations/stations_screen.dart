import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:megaplug/screens/home/pages/stations/components/map_view.dart';
import 'package:megaplug/screens/home/pages/stations/components/stations_appbar.dart';
import 'package:megaplug/screens/home/pages/stations/components/stations_list.dart';
import 'package:megaplug/screens/home/pages/stations/controller/stations_controller.dart';

import '../../../../widgets/app_widgets/app_text.dart';

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
        height: 120,
      ),
      body: GetBuilder<StationsController>(
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
