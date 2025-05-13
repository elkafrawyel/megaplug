import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:megaplug/config/clients/api/api_client.dart';
import 'package:megaplug/config/clients/api/api_result.dart';
import 'package:megaplug/config/helpers/logging_helper.dart';
import 'package:megaplug/config/res.dart';
import 'package:megaplug/data/api_responses/station_filter_response.dart';
import 'package:megaplug/domain/entities/firebase/firebase_station_model.dart';

import '../../domain/repositories/stations_repo.dart';

class StationsRepositoryImpl extends StationsRepository {
  final stationsCollectionId = 'stations';

  // Connect to 'mp-db' instead of the default database
  final FirebaseFirestore firestore = FirebaseFirestore.instanceFor(
    app: Firebase.app(),
    databaseId: 'mp-db',
  );

  @override
   Stream<QuerySnapshot<FirebaseStationModel>> listenToAllStations({
    List<String>? ids,
  })   {
    AppLogger.logWithGetX("""
        \n
        Listening to stations with : : :
        \nIds  => ${ids.toString()}
        \n
        """);

    final collection = firestore
        .collection(stationsCollectionId)
        .withConverter<FirebaseStationModel>(
          fromFirestore: (snap, _) =>
              FirebaseStationModel.fromJson(snap.data()!),
          toFirestore: (station, _) => station.toJson(),
        );

    if (ids == null || ids.isEmpty) {
      // Return ALL stations when ids is null or empty
      return collection.snapshots();
    } else {
      // Return only stations with matching IDs
      return collection.where(FieldPath.documentId, whereIn: ids).snapshots();
    }
  }

  @override
  Future<ApiResult<StationFilterResponse>> getStationFilter() async {
    return APIClient.instance.get<StationFilterResponse>(
      endPoint: Res.apiStationFilter,
      fromJson: StationFilterResponse.fromJson,
    );
  }
}
