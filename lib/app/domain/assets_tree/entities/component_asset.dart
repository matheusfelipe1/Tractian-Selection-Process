import 'package:design_system/design_system.dart';
import 'package:traction_selection_proccess/app/domain/assets_tree/entities/tree_assets.dart';

class ComponentAsset extends TreeBranches {
  final String sensorId;
  final String? parentId;
  final String? locationId;
  final SensorType sensorType;
  final SensorStatus sensorStatus;

  ComponentAsset({
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
  bool get isEnergySensor => sensorType == SensorType.energy;
  bool get isAssociated => parentId != null || locationId != null;

  @override
  TractianAssetsTree toDSEntity() {
    return TractianAssetsTree(
      id: id,
      name: name,
      children: [],
      isOpen: isOpen,
      critical: isCritical,
      isAssociated: isAssociated,
      type: TractianAssetType.component,
    );
  }

  @override
  ComponentAsset copyWith({
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
    return ComponentAsset(
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
  energy("energy"),
  vibration("vibration");

  final String value;

  const SensorType(this.value);
}

enum SensorStatus {
  alert("alert"),
  operating("operating");

  final String value;

  const SensorStatus(this.value);
}
