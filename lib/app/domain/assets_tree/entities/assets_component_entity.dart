import 'package:design_system/design_system.dart';
import 'package:traction_selection_process/app/domain/assets_tree/entities/assets_tree_entity.dart';

class AssetsComponentEntity extends TreeBranches {
  final String sensorId;
  final String? parentId;
  final String? locationId;
  final SensorType sensorType;
  final SensorStatus sensorStatus;

  AssetsComponentEntity({
    super.isOpen,
    this.parentId,
    this.locationId,
    required super.id,
    required super.name,
    required this.sensorId,
    required this.sensorType,
    super.children = const [],
    required this.sensorStatus,
  });

  bool get hasLocation => locationId != null;
  bool get isCritical => sensorStatus == SensorStatus.alert;
  bool get isAssociated => parentId != null || locationId != null;
  bool get isEnergySensor => sensorType == SensorType.energySensor;

  @override
  TractianAssetsTree toDSEntity() {
    return TractianAssetsTree(
      id: id,
      name: name,
      children: [],
      isOpen: isOpen,
      isAssociated: isAssociated,
      type: TractianAssetType.component,
      componentType: TractianAssetsComponentType.values.firstWhere(
        (item) => item.value == sensorType.value,
      ),
      componentStatus: TractianAssetsComponentStatus.values.firstWhere(
        (item) => item.value == sensorStatus.value,
      ),
    );
  }

  @override
  AssetsComponentEntity copyWith({
    String? id,
    bool? isOpen,
    String? name,
    String? sensorId,
    String? parentId,
    String? locationId,
    SensorType? sensorType,
    SensorStatus? sensorStatus,
    List<TreeBranches>? children,
  }) {
    return AssetsComponentEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      isOpen: isOpen ?? this.isOpen,
      children: children ?? this.children,
      sensorId: sensorId ?? this.sensorId,
      parentId: parentId ?? this.parentId,
      locationId: locationId ?? this.locationId,
      sensorType: sensorType ?? this.sensorType,
      sensorStatus: sensorStatus ?? this.sensorStatus,
    );
  }
}

enum SensorType {
  energySensor("energy"),
  vibrationSensor("vibration");

  final String value;

  const SensorType(this.value);
}

enum SensorStatus {
  alert("alert"),
  operating("operating");

  final String value;

  const SensorStatus(this.value);
}
