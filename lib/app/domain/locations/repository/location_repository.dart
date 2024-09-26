import 'package:traction_selection_process/app/core/utils/result.dart';
import 'package:traction_selection_process/app/domain/locations/entities/location_entity.dart';

abstract class LocationRepository {
  Future<Result<List<LocationEntity>, Exception>> getLocations(String idCompany);
}
