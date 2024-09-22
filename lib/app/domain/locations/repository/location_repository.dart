import 'package:traction_selection_proccess/app/core/utils/result.dart';
import 'package:traction_selection_proccess/app/domain/locations/entities/location.dart';

abstract class LocationRepository {
  Future<Result<List<Location>, Exception>> getLocations(String idCompany);
}