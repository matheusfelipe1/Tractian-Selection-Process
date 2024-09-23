import 'package:traction_selection_proccess/app/core/constants/endpoints.dart';
import 'package:traction_selection_proccess/app/domain/api/api_handler.dart';

class AssetsTreeDatasource {
  final ApiHandler _apiHandler;

  AssetsTreeDatasource(this._apiHandler);

  Future<dynamic> getGeneralAssets(dynamic params) async {
    return await _apiHandler.get(path: Endpoints.getAssets(params));
  }
}
