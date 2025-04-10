import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:megaplug/config/clients/api/api_result.dart';
import 'package:megaplug/presentation/home/pages/stations/data/place_model.dart';

class StationsRepository {
  Future<ApiResult<List<StationModel>>> getAllStations() async {
    final List<StationModel> places = [
      StationModel(
        name: "Abou Tarek",
        latLng: LatLng(30.050194, 31.237896),
      ),
      StationModel(
        name: "Bab Al Qasr",
        latLng: LatLng(30.005493, 31.477898),
      ),
      StationModel(
        name: "Andrea El Mariouteya",
        latLng: LatLng(30.013056, 31.208853),
      ),
      StationModel(
        name: "Fasahet Somaya",
        latLng: LatLng(30.0444, 31.2357),
      ),
      StationModel(
        name: "Kazoku",
        latLng: LatLng(30.0444, 31.2357),
      ),
      StationModel(
        name: "Le Tarbouche",
        latLng: LatLng(30.0444, 31.2357),
      ),
      StationModel(
        name: "Nine Pyramids Lounge",
        latLng: LatLng(29.976480, 31.131302),
      ),
      StationModel(
        name: "Sachi",
        latLng: LatLng(30.0444, 31.2357),
      ),
      StationModel(
        name: "Zitouni",
        latLng: LatLng(30.0459, 31.2243),
      ),
      StationModel(
        name: "Zööba Zamalek",
        latLng: LatLng(30.0667, 31.2167),
      ),
      StationModel(
        name: "Cake Cafe",
        latLng: LatLng(30.0667, 31.2167),
      ),
      StationModel(
        name: "El Fishawy Cafe",
        latLng: LatLng(30.0475, 31.2622),
      ),
      StationModel(
        name: "Fresco Bakery",
        latLng: LatLng(30.090984, 31.322708),
      ),
      StationModel(
        name: "Tasa",
        latLng: LatLng(30.090984, 31.322708),
      ),
      StationModel(
        name: "Cafe Corniche",
        latLng: LatLng(30.0444, 31.2357),
      ),
      StationModel(
        name: "Antique Khana",
        latLng: LatLng(30.0667, 31.2167),
      ),
      StationModel(
        name: "Naguib Mahfouz Cafe",
        latLng: LatLng(30.0475, 31.2622),
      ),
      StationModel(
        name: "The Coffee Bean & Tea Leaf",
        latLng: LatLng(30.0444, 31.2357),
      ),
      StationModel(
        name: "Cafe Greco",
        latLng: LatLng(30.0444, 31.2357),
      ),
      StationModel(
        name: "Vinni Cafe & Deli",
        latLng: LatLng(30.013056, 31.208853),
      ),
      StationModel(
        name: "Origo Cafe",
        latLng: LatLng(30.0667, 31.2167),
      ),
      StationModel(
        name: "Blaze Restaurant & Cafe",
        latLng: LatLng(30.090984, 31.322708),
      ),
      StationModel(
        name: "Garden Promenade Cafe",
        latLng: LatLng(30.0444, 31.2357),
      ),
      StationModel(
        name: "Koshary Abou Tarek",
        latLng: LatLng(30.050194, 31.237896),
      ),
      StationModel(
        name: "Seekh Mashwy Dokki",
        latLng: LatLng(30.013056, 31.208853),
      ),
      StationModel(
        name: "Tante",
        latLng: LatLng(30.0444, 31.2357),
      ),
      StationModel(
        name: "Mandarine Koueider",
        latLng: LatLng(30.0444, 31.2357),
      ),
      StationModel(
        name: "Al-Azhar Mosque",
        latLng: LatLng(30.0469, 31.2625),
      )
    ];

    return ApiSuccess(places);
  }
}