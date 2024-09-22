import 'package:dio/dio.dart';
import 'package:traction_selection_proccess/src/domain/api/api_handler.dart';

class ApiHandlerImpl extends ApiHandler {
  late Dio _dio;

  ApiHandlerImpl() {
    _dio = Dio()..options.baseUrl = const String.fromEnvironment("API_URL");
  }

  @override
  Future get({required String path}) async {
    return await _dio.get(path);
  }
}
