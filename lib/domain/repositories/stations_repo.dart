import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:megaplug/config/clients/api/api_result.dart';
import 'package:megaplug/data/api_responses/station_filter_response.dart';

import '../../config/extension/station_status.dart';
import '../entities/api/status_filter_model.dart';
import '../entities/firebase/firebase_station_model.dart';

abstract class StationsRepository {
  Stream<QuerySnapshot<FirebaseStationModel>> listenToAllStations({
    List<String>? ids
  });

  Future<ApiResult<StationFilterResponse>> getStationFilter();

}
