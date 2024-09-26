import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:traction_selection_process/app/core/extensions/map_extensions.dart';
import 'package:traction_selection_process/app/data/api/custom_interceptors.dart';
import 'package:traction_selection_process/app/domain/api/api_handler.dart';

class ApiHandlerImpl extends ApiHandler {
  late Dio _dio;

  ApiHandlerImpl() {
    _dio = Dio()
      ..interceptors.add(CustomInterceptors())
      ..options.connectTimeout = const Duration(seconds: 10)
      ..options.baseUrl = dotenv.env.getOrDefaultValue(
        key: "API_URL",
        defaultValue: "",
      );
  }

  @override
  Future get({required String path}) async {
    final response = await _dio.get(path);
    return response.data;
  }
}
