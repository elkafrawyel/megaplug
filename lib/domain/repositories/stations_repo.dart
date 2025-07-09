import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:megaplug/config/clients/api/api_result.dart';
import 'package:megaplug/data/api_responses/station_details_response.dart';
import 'package:megaplug/data/api_responses/station_filter_response.dart';
import 'package:megaplug/domain/entities/api/charge_power_model.dart';
import 'package:megaplug/domain/entities/api/connector_type_model.dart';

import '../../data/api_responses/station_search_response.dart';
import '../../data/api_responses/stations_filter_result_response.dart';
import '../entities/api/status_filter_model.dart';
import '../entities/firebase/firebase_station_model.dart';

abstract class StationsRepository {
  Stream<QuerySnapshot<FirebaseStationModel>> listenToAllStations({List<String>? ids});

  Future<ApiResult<StationFilterResponse>> getStationFilter();

  Future<ApiResult<StationSearchResponse>> searchForStations({
    required String query,
  });

  Future<ApiResult<StationsFilterResultResponse>> filterStations({
    List<StatusFilterModel>? statusFilter,
    List<ConnectorTypeModel>? connectorTypesFilter,
    ChargePowerModel? chargePowerFilter,
  });

  Future<ApiResult<StationDetailsResponse>> getStationById({
    required String stationId,
  });
}
