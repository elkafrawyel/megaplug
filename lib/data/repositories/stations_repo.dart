import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:megaplug/config/clients/api/api_client.dart';
import 'package:megaplug/config/clients/api/api_result.dart';
import 'package:megaplug/config/helpers/logging_helper.dart';
import 'package:megaplug/config/res.dart';
import 'package:megaplug/data/api_responses/station_filter_response.dart';
import 'package:megaplug/domain/entities/firebase_station_model.dart';

import '../../domain/repositories/stations_repo.dart';

class StationsRepositoryImpl extends StationsRepository {
  @override
  Future<ApiResult<StationFilterResponse>> getStationFilter() async {
    return APIClient.instance.get<StationFilterResponse>(
      endPoint: Res.apiStationFilter,
      fromJson: StationFilterResponse.fromJson,
    );
  }

  final databaseName = 'mp-db';
  final collectionId = 'stations';

  @override
  Future<Stream<QuerySnapshot<FirebaseStationModel>>> listenToStations({
    String? searchQuery,
  }) async {
    // Connect to 'mp-db' instead of the default database
    final FirebaseFirestore firestore = FirebaseFirestore.instanceFor(
      app: Firebase.app(),
      databaseId: databaseName,
    );

    return firestore
        .collection(collectionId)
        // .where('id',isEqualTo: searchQuery)
        .where('name_en', isGreaterThanOrEqualTo: searchQuery)
        // .where('name_en', isLessThan: '${searchQuery}z')
        // .where('name_ar', isGreaterThanOrEqualTo: searchQuery)
        // .where('name_ar', isLessThan: '${searchQuery}z')
        .withConverter<FirebaseStationModel>(
          fromFirestore: (snap, _) =>
              FirebaseStationModel.fromJson(snap.data()!),
          toFirestore: (station, _) => station.toJson(),
        )
        .snapshots();
  }
}
