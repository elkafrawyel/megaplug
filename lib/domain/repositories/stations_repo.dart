import 'package:megaplug/config/clients/api/api_result.dart';
import 'package:megaplug/domain/entities/connector_type_model.dart';
import 'package:megaplug/domain/entities/station_model.dart';

abstract class StationsRepository{

  Future<ApiResult<List<StationModel>>> getAllStations();
  Future<ApiResult<List<ConnectorTypeModel>>> getAllConnectorTypes();


}