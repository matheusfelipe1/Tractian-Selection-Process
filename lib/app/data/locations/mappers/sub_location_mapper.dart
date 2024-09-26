import 'package:traction_selection_process/app/core/constants/app_constants.dart';
import 'package:traction_selection_process/app/core/extensions/map_extensions.dart';
import 'package:traction_selection_process/app/domain/locations/entities/sub_location_entity.dart';

class SubLocationMapper {

  static List<SubLocationEntity> fromDataList({
    required String parentId,
    required List<Map<String, dynamic>> subLocationList,
  }) {
    final subLocationsFiltered = subLocationList
        .where((element) => _isParent(element, parentId))
        .toList();

    return subLocationsFiltered
        .map((e) => _fromData(subLocation: e, subLocationList: subLocationList))
        .toList()
      ..sort((a, b) => a.children.length.compareTo(b.children.length));
  }

  static bool _isParent(Map<String, dynamic> data, String parentId) {
    return data.getOrDefaultValue(key: AppConstants.parentId, defaultValue: "") == parentId;
  }

  static SubLocationEntity _fromData({
    required Map<String, dynamic> subLocation,
    required List<Map<String, dynamic>> subLocationList,
  }) {
    final id = subLocation.getValue(key: AppConstants.id);
    return SubLocationEntity(
      id: id,
      name: subLocation.getOrDefaultValue(
        defaultValue: "",
        key: AppConstants.name,
      ),
      parentId: subLocation.getOrDefaultValue(
        defaultValue: "",
        key: AppConstants.parentId,
      ),
      children: fromDataList(
        parentId: id,
        subLocationList: subLocationList,
      ),
    );
  }
}
