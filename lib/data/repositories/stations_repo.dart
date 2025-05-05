import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:megaplug/config/clients/api/api_result.dart';
import 'package:megaplug/config/extension/station_status.dart';
import 'package:megaplug/domain/entities/charge_power_model.dart';
import 'package:megaplug/domain/entities/connector_type_model.dart';
import 'package:megaplug/domain/entities/station_model.dart';
import 'package:megaplug/domain/entities/station_main_filter_type_model.dart';

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
  Future<ApiResult<List<ConnectorTypeModel>>> getAllConnectorTypes() async {
    return ApiSuccess(
      [
        ConnectorTypeModel(
          id: '445',
          image: 'assets/icons/connector_type_1.svg',
          text: 'ABB Terra 53 CJG Type 1',
        ),
        ConnectorTypeModel(
          id: '5856',
          image: 'assets/icons/connector_type_1.svg',
          text: 'Tesla',
          isSelected: false,
        ),
        ConnectorTypeModel(
          id: '564646',
          image: 'assets/icons/connector_type_1.svg',
          text: 'EVBox Troniq 50 CCS2',
        ),
        ConnectorTypeModel(
          id: '564456',
          image: 'assets/icons/connector_type_1.svg',
          text: 'Tritium Veefil-RT Type 2',
        ),
      ],
    );
  }

  @override
  Future<ApiResult<List<ChargePowerModel>>> getAllChargePowers() async {
    return ApiSuccess(
      [
        ChargePowerModel(
          id: '0',
          name: 'power 0',
          power: 22,
        ),
        ChargePowerModel(
          id: '1',
          name: 'power 1',
          power: 50,
        ),

      ],
    );
  }

  @override
  Future<ApiResult<List<StationMainFilterTypeModel>>> getAllStationMainFilterTypes() async {
    return ApiSuccess(
      [
        StationMainFilterTypeModel(id: '0', name: 'all', slug: 'all'),
        StationMainFilterTypeModel(id: '1', name: 'available', slug: 'available'),
        StationMainFilterTypeModel(
          id: '2',
          name: 'available_and_in_use',
          slug: 'available_and_in_use',
        ),
      ],
    );
  }
}
