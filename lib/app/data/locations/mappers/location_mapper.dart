import 'package:traction_selection_process/app/core/extensions/map_extensions.dart';
import 'package:traction_selection_process/app/domain/locations/entities/location.dart';
import 'package:traction_selection_process/app/data/locations/mappers/sub_location_mapper.dart';

class LocationMapper {
  static const _id = "id";
  static const _name = "name";
  static const _parentId = "parentId";

  static List<Location> fromDataList(List data) {
    final dataList = data.cast<Map<String, dynamic>>();

    final subLocationList = dataList
        .where((item) => item.getValue(key: _parentId) != null)
        .toList();
    final locationList = dataList
        .where((item) => item.getValue(key: _parentId) == null)
        .toList();

    return locationList
        .map((location) => _fromData(location, subLocationList))
        .toList()
      ..sort((a, b) => a.children.length.compareTo(b.children.length));
  }

  static Location _fromData(
    Map<String, dynamic> location,
    List<Map<String, dynamic>> subLocationList,
  ) {
    final id = location.getValue(key: _id);

    return Location(
      id: id,
      name: location.getOrDefaultValue(
        key: _name,
        defaultValue: "",
      ),
      children: SubLocationMapper.fromDataList(
        parentId: id,
        subLocationList: subLocationList,
      ),
    );
  }
}
