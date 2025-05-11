import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:megaplug/config/clients/api/api_result.dart';
import 'package:megaplug/data/api_responses/station_filter_response.dart';

import '../entities/firebase_station_model.dart';

abstract class StationsRepository {
  Future<Stream<QuerySnapshot<FirebaseStationModel>>> listenToStations({
    String? searchQuery,
  });

  Future<ApiResult<StationFilterResponse>> getStationFilter();
}
