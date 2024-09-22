import 'package:traction_selection_proccess/app/core/utils/result.dart';
import 'package:traction_selection_proccess/app/core/utils/base_repository.dart';
import 'package:traction_selection_proccess/app/domain/locations/entities/location.dart';
import 'package:traction_selection_proccess/app/data/locations/mappers/location_mapper.dart';
import 'package:traction_selection_proccess/app/data/locations/datasource/location_datasource.dart';
import 'package:traction_selection_proccess/app/domain/locations/repository/location_repository.dart';

class LocationRepositoryImpl extends BaseRepository implements LocationRepository {
  final LocationDatasource _locationDatasource;

  LocationRepositoryImpl({
    required LocationDatasource locationDatasource,
  }) : _locationDatasource = locationDatasource;
  @override
  Future<Result<List<Location>, Exception>> getLocations(String idCompany) async {
    try {
      final result = await _locationDatasource.getLocations(idCompany);
      final locationMapped = LocationMapper.fromDataList(result);
      return handleSuccess(locationMapped);
    } catch (error) {
      return handleFailure(error);  
    }
  }
}