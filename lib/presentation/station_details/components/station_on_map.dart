import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:widget_to_marker/widget_to_marker.dart';

class StationOnMap extends StatefulWidget {

  final LatLng location;
  const StationOnMap({super.key, required this.location});

  @override
  State<StationOnMap> createState() => _StationOnMapState();
}

class _StationOnMapState extends State<StationOnMap> {
  late GoogleMapController _controller;

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
        position: widget.location,
        anchor: Offset(0.5, 0.5), // Center of the icon
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
          logicalSize: const Size(150, 150),
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
        center: widget.location,
        radius: 500,
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
      height: 350,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(38),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GoogleMap(
            scrollGesturesEnabled: true,
            zoomGesturesEnabled: true,
            zoomControlsEnabled: false,
            initialCameraPosition: CameraPosition(
              target: widget.location,
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
