import 'package:traction_selection_process/app/core/constants/app_constants.dart';
import 'package:traction_selection_process/app/core/extensions/map_extensions.dart';
import 'package:traction_selection_process/app/domain/locations/entities/location_entity.dart';
import 'package:traction_selection_process/app/data/locations/mappers/sub_location_mapper.dart';

class LocationMapper {
  static List<LocationEntity> fromDataList(List data) {
    final dataList = data.cast<Map<String, dynamic>>();

    final subLocationList = dataList
        .where((item) => item.getValue(key: AppConstants.parentId) != null)
        .toList();
    final locationList = dataList
        .where((item) => item.getValue(key: AppConstants.parentId) == null)
        .toList();

    return locationList
        .map((location) => _fromData(location, subLocationList))
        .toList()
      ..sort((a, b) => a.children.length.compareTo(b.children.length));
  }

  static LocationEntity _fromData(
    Map<String, dynamic> location,
    List<Map<String, dynamic>> subLocationList,
  ) {
    final id = location.getValue(key: AppConstants.id);

    return LocationEntity(
      id: id,
      name: location.getOrDefaultValue(
        defaultValue: "",
        key: AppConstants.name,
      ),
      children: SubLocationMapper.fromDataList(
        parentId: id,
        subLocationList: subLocationList,
      ),
    );
  }
}
