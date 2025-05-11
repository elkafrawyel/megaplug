import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:megaplug/config/clients/api/api_result.dart';
import 'package:megaplug/data/api_responses/station_filter_response.dart';
import 'package:megaplug/domain/entities/charge_power_model.dart';
import 'package:megaplug/domain/entities/connector_type_model.dart';
import 'package:megaplug/domain/entities/station_model.dart';

import '../entities/firebase_station_model.dart';

abstract class StationsRepository {
  Future listenToStations({
    required Function(List<FirebaseStationModel>) onChange,
  });

  Future<ApiResult<List<StationModel>>> getAllStations();

  Future<ApiResult<StationFilterResponse>> getStationFilter();
}
