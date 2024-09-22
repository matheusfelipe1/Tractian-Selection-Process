import 'package:traction_selection_proccess/app/core/constants/endpoints.dart';
import 'package:traction_selection_proccess/app/domain/api/api_handler.dart';

class AssetsDatasource {

  final ApiHandler _apiHandler;

  AssetsDatasource(this._apiHandler);


  Future<dynamic> getGeneralAssets(dynamic params) async {
    return await _apiHandler.get(path: Endpoints.getAssets(params));
  }

}