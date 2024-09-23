import 'package:traction_selection_proccess/app/core/extensions/map_extensions.dart';
import 'package:traction_selection_proccess/app/domain/locations/entities/sub_location.dart';

class SubLocationMapper {
  static const _id = "id";
  static const _name = "name";
  static const _parentId = "parentId";

  static List<SubLocation> fromDataList({
    required String parentId,
    required List<Map<String, dynamic>> subLocationList,
  }) {
    final subLocationsFiltered = subLocationList
        .where((element) => _isParent(element, parentId))
        .toList();

    return subLocationsFiltered.map(_fromData).toList();
  }

  static bool _isParent(Map<String, dynamic> data, String parentId) {
    return data.getOrDefaultValue(key: _parentId, defaultValue: "") == parentId;
  }

  static SubLocation _fromData(Map<String, dynamic> subLocation) {
    return SubLocation(
      id: subLocation.getValue(key: _id),
      name: subLocation.getOrDefaultValue(key: _name, defaultValue: ""),
      parentId: subLocation.getOrDefaultValue(
        key: _parentId,
        defaultValue: "",
      ),
    );
  }
}
