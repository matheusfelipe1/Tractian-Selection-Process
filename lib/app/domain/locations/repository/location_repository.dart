import 'package:traction_selection_process/app/core/utils/result.dart';
import 'package:traction_selection_process/app/domain/locations/entities/location.dart';

abstract class LocationRepository {
  Future<Result<List<Location>, Exception>> getLocations(String idCompany);
}
