import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:megaplug/config/clients/api/api_client.dart';
import 'package:megaplug/config/clients/api/api_result.dart';
import 'package:megaplug/config/clients/firebase/firebase_fireStore_service.dart';
import 'package:megaplug/config/extension/station_status.dart';
import 'package:megaplug/config/helpers/logging_helper.dart';
import 'package:megaplug/config/res.dart';
import 'package:megaplug/data/api_responses/station_filter_response.dart';
import 'package:megaplug/domain/entities/firebase_station_model.dart';
import 'package:megaplug/domain/entities/charge_power_model.dart';
import 'package:megaplug/domain/entities/connector_type_model.dart';
import 'package:megaplug/domain/entities/station_model.dart';
import 'package:megaplug/domain/entities/status_filter_model.dart';

import '../../domain/repositories/stations_repo.dart';

class StationsRepositoryImpl extends StationsRepository {
  @override
  Future<ApiResult<List<StationModel>>> getAllStations() async {
    final List<StationModel> places = [
      StationModel(
        name: "Abou Tarek",
        latLng: LatLng(30.050194, 31.237896),
        stationStatus: StationStatus.down,
      ),
      StationModel(
        name: "Bab Al Qasr",
        latLng: LatLng(30.005493, 31.477898),
        stationStatus: StationStatus.busy,
      ),
      StationModel(
        name: "Andrea El Mariouteya",
        latLng: LatLng(30.013056, 31.208853),
        stationStatus: StationStatus.busy,
      ),
      StationModel(
        name: "Fasahet Somaya",
        latLng: LatLng(30.0444, 31.2357),
        stationStatus: StationStatus.busy,
      ),
      StationModel(
        name: "Kazoku",
        latLng: LatLng(30.0444, 31.2357),
        stationStatus: StationStatus.busy,
      ),
      StationModel(
        name: "Le Tarbouche",
        latLng: LatLng(30.0444, 31.2357),
        stationStatus: StationStatus.down,
      ),
      StationModel(
        name: "Nine Pyramids Lounge",
        latLng: LatLng(29.976480, 31.131302),
        stationStatus: StationStatus.down,
      ),
      StationModel(
        name: "Sachi",
        latLng: LatLng(30.0444, 31.2357),
        stationStatus: StationStatus.down,
      ),
      StationModel(
        name: "Zitouni",
        latLng: LatLng(30.0459, 31.2243),
        stationStatus: StationStatus.down,
      ),
      StationModel(
        name: "Zööba Zamalek",
        latLng: LatLng(30.0667, 31.2167),
      ),
      StationModel(
        name: "Cake Cafe",
        latLng: LatLng(30.0667, 31.2167),
        stationStatus: StationStatus.active,
      ),
      StationModel(
        name: "El Fishawy Cafe",
        latLng: LatLng(30.0475, 31.2622),
        stationStatus: StationStatus.active,
      ),
      StationModel(
        name: "Fresco Bakery",
        latLng: LatLng(30.090984, 31.322708),
        stationStatus: StationStatus.active,
      ),
      StationModel(
        name: "Tasa",
        latLng: LatLng(30.090984, 31.322708),
        stationStatus: StationStatus.active,
      ),
      StationModel(
        name: "Cafe Corniche",
        latLng: LatLng(30.0444, 31.2357),
        stationStatus: StationStatus.active,
      ),
      StationModel(
        name: "Antique Khana",
        latLng: LatLng(30.0667, 31.2167),
        stationStatus: StationStatus.active,
      ),
      StationModel(
        name: "Naguib Mahfouz Cafe",
        latLng: LatLng(30.0475, 31.2622),
        stationStatus: StationStatus.active,
      ),
      StationModel(
        name: "The Coffee Bean & Tea Leaf",
        latLng: LatLng(30.0444, 31.2357),
        stationStatus: StationStatus.active,
      ),
      StationModel(
        name: "Cafe Greco",
        latLng: LatLng(30.0444, 31.2357),
        stationStatus: StationStatus.active,
      ),
      StationModel(
        name: "Vinni Cafe & Deli",
        latLng: LatLng(30.013056, 31.208853),
        stationStatus: StationStatus.active,
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

  @override
  Future<ApiResult<StationFilterResponse>> getStationFilter() async {
    return APIClient.instance.get<StationFilterResponse>(
      endPoint: Res.apiStationFilter,
      fromJson: StationFilterResponse.fromJson,
    );
  }

  @override
  Future listenToStations({
    required Function(List<FirebaseStationModel>) onChange,
  }) async {
    final databaseName = 'mp-db';
    final collectionId = 'stations';
    // Connect to 'mp-db' instead of the default database
    final FirebaseFirestore firestore = FirebaseFirestore.instanceFor(
      app: Firebase.app(),
      databaseId: databaseName,
    );

    firestore.collection(collectionId).snapshots().listen(
      (event) {
        print('Received snapshot with ${event.docs.length} documents');
        if (event.docs.isEmpty) {
          print(
              'No documents found - check collection path and security rules');
        }

        final List<FirebaseStationModel> stations = event.docs
            .map(
              (doc) => FirebaseStationModel.fromJson(
                doc.data(),
              ),
            )
            .toList();
        onChange(stations);
      },
      onError: (error) => print("Listen failed: $error"), // Add error handler
    );
  }
}
