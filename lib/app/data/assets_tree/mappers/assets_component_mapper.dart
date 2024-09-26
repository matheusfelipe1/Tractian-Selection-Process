import 'package:traction_selection_process/app/core/constants/app_constants.dart';
import 'package:traction_selection_process/app/core/extensions/map_extensions.dart';
import 'package:traction_selection_process/app/domain/assets_tree/entities/assets_component_entity.dart';

class AssetsComponentMapper {
  static List<AssetsComponentEntity> fromDataList(
    List<Map<String, dynamic>> component,
  ) {
    return component.map(_fromData).toList();
  }

  static AssetsComponentEntity _fromData(Map<String, dynamic> component) {
    return AssetsComponentEntity(
      sensorType: _getSensorType(component),
      sensorStatus: _getSensorStatus(component),
      id: component.getValue(key: AppConstants.id),
      sensorId: component.getValue(key: AppConstants.sensorId),
      parentId: component.getValue(key: AppConstants.parentId),
      locationId: component.getValue(key: AppConstants.locationId),
      name: component.getOrDefaultValue(key: AppConstants.name, defaultValue: ""),
    );
  }

  static SensorType _getSensorType(Map<String, dynamic> component) {
    final sensorType = component.getValue(key: AppConstants.sensorType);
    return SensorType.values.firstWhere((item) => item.value == sensorType);
  }

  static SensorStatus _getSensorStatus(Map<String, dynamic> component) {
    final String sensorStatus = component.getValue(key: AppConstants.sensorStatus);
    return SensorStatus.values.firstWhere((item) => item.value == sensorStatus);
  }
}
