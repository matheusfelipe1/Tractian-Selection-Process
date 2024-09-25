import 'package:flutter/foundation.dart';
import 'package:traction_selection_process/app/core/utils/result.dart';
import 'package:traction_selection_process/app/core/utils/base_repository.dart';
import 'package:traction_selection_process/app/domain/locations/entities/location.dart';
import 'package:traction_selection_process/app/data/locations/mappers/location_mapper.dart';
import 'package:traction_selection_process/app/data/locations/datasource/location_datasource.dart';
import 'package:traction_selection_process/app/domain/locations/repository/location_repository.dart';

class LocationRepositoryImpl extends BaseRepository
    implements LocationRepository {
  final LocationDatasource _locationDatasource;

  LocationRepositoryImpl(this._locationDatasource);

  @override
  Future<Result<List<Location>, Exception>> getLocations(
      String idCompany) async {
    try {
      final result = await _locationDatasource.getLocations(idCompany);
      final locationMapped = await compute(_executeHeavyTask, result);
      return handleSuccess(locationMapped);
    } catch (error) {
      return handleFailure(error);
    }
  }

  static List<Location> _executeHeavyTask(dynamic result) {
    return LocationMapper.fromDataList(result);
  }
}
