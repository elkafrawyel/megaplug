import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:megaplug/config/clients/api/api_client.dart';
import 'package:megaplug/config/clients/api/api_result.dart';
import 'package:megaplug/config/helpers/logging_helper.dart';
import 'package:megaplug/config/res.dart';
import 'package:megaplug/data/api_responses/station_filter_response.dart';
import 'package:megaplug/domain/entities/firebase/firebase_connector_type_model.dart';
import 'package:megaplug/domain/entities/firebase/firebase_station_model.dart';

import '../../domain/repositories/stations_repo.dart';

class StationsRepositoryImpl extends StationsRepository {
  @override
  Future<ApiResult<StationFilterResponse>> getStationFilter() async {
    return APIClient.instance.get<StationFilterResponse>(
      endPoint: Res.apiStationFilter,
      fromJson: StationFilterResponse.fromJson,
    );
  }

  final stationsCollectionId = 'stations';
  final chargingPointCollectionId = 'chargingpoints';
  final connectorsCollectionId = 'connectors';

  // Connect to 'mp-db' instead of the default database
  final FirebaseFirestore firestore = FirebaseFirestore.instanceFor(
    app: Firebase.app(),
    databaseId: 'mp-db',
  );

  @override
  Future<Stream<QuerySnapshot<FirebaseStationModel>>> listenToStations({
    String? searchQuery,
  }) async {
    return firestore
        .collection(stationsCollectionId)
        // .where('name_en',isGreaterThan: )
        .withConverter<FirebaseStationModel>(
          fromFirestore: (snap, _) =>
              FirebaseStationModel.fromJson(snap.data()!),
          toFirestore: (station, _) => station.toJson(),
        )
        .snapshots();
  }

  @override
  Future<List<FirebaseStationModel>> mapConnectorsToStations({
    required List<FirebaseStationModel> stations,
  }) async {
    print('Event Fired Before calculation on sec :: ${DateTime.now().second}');

    for (var station in stations) {
      QuerySnapshot<Map> chargingPointQuery = await firestore
          .collection(stationsCollectionId)
          .doc(station.id)
          .collection(chargingPointCollectionId)
          .get();

      for (var doc in chargingPointQuery.docs) {
        QuerySnapshot<FirebaseConnectorTypeModel> connectorSnap =
            await firestore
                .collection(stationsCollectionId)
                .doc(station.id)
                .collection(chargingPointCollectionId)
                .doc(doc.id)
                .collection(connectorsCollectionId)
                .withConverter<FirebaseConnectorTypeModel>(
                    fromFirestore: (snap, _) =>
                        FirebaseConnectorTypeModel.fromJson(snap.data()),
                    toFirestore: (connector, _) => connector.toJson())
                .get();

        station.connectors =
            connectorSnap.docs.map((doc) => doc.data()).toList();
      }
    }
    print('Event Fired After calculation on sec :: ${DateTime.now().second}');
    return stations;
  }
}
