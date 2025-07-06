import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:megaplug/config/theme/color_extension.dart';
import 'package:widget_to_marker/widget_to_marker.dart';

class StationOnMap extends StatefulWidget {
  const StationOnMap({super.key});

  @override
  State<StationOnMap> createState() => _StationOnMapState();
}

class _StationOnMapState extends State<StationOnMap> {
  late GoogleMapController _controller;
  final LatLng _circleCenter = LatLng(30.0444, 31.2357); // Example: Cairo, Egypt

  final Set<Circle> _circles = {};
  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _addCircle();
    _addMarker();
  }

  _addMarker() async {
    _markers.add(
      Marker(
        markerId: MarkerId('station_id'),
        position: _circleCenter,
        icon: await Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.black,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ).toBitmapDescriptor(
          logicalSize: const Size(100, 100),
          imageSize: const Size(200, 200),
        ),
      ),
    );
    setState(() {});
  }

  void _addCircle() {
    _circles.add(
      Circle(
        circleId: CircleId('cairo_circle'),
        center: _circleCenter,
        radius: 1000,
        // in meters
        fillColor: Color.fromRGBO(62, 191, 128, 0.08),
        strokeColor: Colors.green,
        strokeWidth: 2,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(38),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GoogleMap(
            scrollGesturesEnabled: true,
            zoomGesturesEnabled: true,
            zoomControlsEnabled: false,
            initialCameraPosition: CameraPosition(
              target: _circleCenter,
              zoom: 14,
            ),
            onMapCreated: (GoogleMapController controller) {
              _controller = controller;
            },
            circles: _circles,
            markers: _markers,
          ),
        ),
      ),
    );
  }
}
