import 'package:traction_selection_process/app/core/extensions/map_extensions.dart';
import 'package:traction_selection_process/app/domain/assets_tree/entities/assets_component.dart';

class AssetsComponentMapper {
  static List<AssetsComponent> fromDataList(
    List<Map<String, dynamic>> component,
  ) {
    return component.map(_fromData).toList();
  }

  static AssetsComponent _fromData(Map<String, dynamic> component) {
    return AssetsComponent(
      id: component.getValue(key: "id"),
      sensorType: _getSensorType(component),
      sensorStatus: _getSensorStatus(component),
      sensorId: component.getValue(key: "sensorId"),
      parentId: component.getValue(key: "parentId"),
      locationId: component.getValue(key: "locationId"),
      name: component.getOrDefaultValue(key: "name", defaultValue: ""),
    );
  }

  static SensorType _getSensorType(Map<String, dynamic> component) {
    final sensorType = component.getValue(key: "sensorType");
    return SensorType.values.firstWhere((item) => item.value == sensorType);
  }

  static SensorStatus _getSensorStatus(Map<String, dynamic> component) {
    final String sensorStatus = component.getValue(key: "status");
    return SensorStatus.values.firstWhere((item) => item.value == sensorStatus);
  }
}
