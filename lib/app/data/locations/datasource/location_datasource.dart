import 'package:traction_selection_process/app/core/constants/endpoints.dart';
import 'package:traction_selection_process/app/domain/api/api_handler.dart';

class LocationDatasource {
  final ApiHandler _apiHandler;

  LocationDatasource(this._apiHandler);

  Future<dynamic> getLocations(dynamic params) async {
    return await _apiHandler.get(path: Endpoints.getLocations(params));
  }
}
