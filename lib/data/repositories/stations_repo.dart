import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:megaplug/config/clients/api/api_client.dart';
import 'package:megaplug/config/clients/api/api_result.dart';
import 'package:megaplug/config/helpers/logging_helper.dart';
import 'package:megaplug/config/res.dart';
import 'package:megaplug/data/api_responses/station_details_response.dart';
import 'package:megaplug/data/api_responses/station_filter_response.dart';
import 'package:megaplug/domain/entities/api/charge_power_model.dart';
import 'package:megaplug/domain/entities/api/connector_type_model.dart';
import 'package:megaplug/domain/entities/api/status_filter_model.dart';
import 'package:megaplug/domain/entities/firebase/firebase_station_model.dart';

import '../../domain/repositories/stations_repo.dart';
import '../api_responses/station_search_response.dart';
import '../api_responses/stations_filter_result_response.dart';

class StationsRepositoryImpl extends StationsRepository {
  // // Connect to 'mp-db' instead of the default database
  // final FirebaseFirestore firestore = FirebaseFirestore.instanceFor(
  //   app: Firebase.app(),
  //   databaseId: 'mp-db',
  // );

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Stream<QuerySnapshot<FirebaseStationModel>> listenToAllStations({
    List<String>? ids,
  }) {
    AppLogger.logWithGetX("""\nListening to stations with : : :
                                      \nIds  => ${ids.toString()}
                                   """);

    final collection =
        _firestore.collection('stations').withConverter<FirebaseStationModel>(
              fromFirestore: (snap, _) =>
                  FirebaseStationModel.fromJson(snap.data()!),
              toFirestore: (station, _) => station.toJson(),
            );

    if (ids == null) {
      // Return empty stream if ids is null
      return const Stream.empty();
    } else if (ids.isEmpty) {
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
      endPoint: Res.apiGetStationFilter,
      fromJson: StationFilterResponse.fromJson,
    );
  }

  @override
  Future<ApiResult<StationSearchResponse>> searchForStations({
    required String query,
  }) async {
    return APIClient.instance.get<StationSearchResponse>(
      endPoint: "${Res.apiStationSearch}?query=$query",
      fromJson: StationSearchResponse.fromJson,
    );
  }

  @override
  Future<ApiResult<StationsFilterResultResponse>> filterStations({
    List<StatusFilterModel>? statusFilter,
    List<ConnectorTypeModel>? connectorTypesFilter,
    ChargePowerModel? chargePowerFilter,
  }) async {
    AppLogger.logWithGetX('Status Filter ids'
        ' => ${statusFilter?.map((e) => e.key).toList()}');
    AppLogger.logWithGetX('Connector Types Filter ids'
        ' => ${connectorTypesFilter?.map((e) => e.id).toList()}');
    AppLogger.logWithGetX('Charge Power Filter id'
        ' => ${chargePowerFilter?.id}');

    return APIClient.instance.get<StationsFilterResultResponse>(
      endPoint: Res.apiStationFilter,
      fromJson: StationsFilterResultResponse.fromJson,
      queryParameters: {
        if ((statusFilter?.isNotEmpty ?? false) &&
            statusFilter?.first.key != 'ALL')
          'statuses[]': statusFilter?.map((e) => e.key).toList(),
        if (connectorTypesFilter?.isNotEmpty ?? false)
          'connector_types[]': connectorTypesFilter?.map((e) => e.id).toList(),
        if (chargePowerFilter != null)
          'charging_powers[]': [chargePowerFilter.id],
      },
    );
  }

  @override
  Future<ApiResult<StationDetailsResponse>> getStationById({required String stationId})async {
    AppLogger.logWithGetX('Getting station details for id: $stationId');

    return APIClient.instance.get<StationDetailsResponse>(
      endPoint: "stations/$stationId/details",
      fromJson: StationDetailsResponse.fromJson,
    );
  }
}
