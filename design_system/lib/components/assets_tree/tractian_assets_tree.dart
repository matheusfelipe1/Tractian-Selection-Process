part of 'widgets/tractian_assets_tree_widget.dart';

class TractianAssetsTree {
  final dynamic id;
  final String name;
  final bool isOpen;
  final bool isAssociated;
  final TractianAssetType type;
  final List<TractianAssetsTree> children;
  final TractianAssetsComponentType componentType;
  final TractianAssetsComponentStatus componentStatus;

  TractianAssetsTree({
    this.id,
    required this.name,
    required this.type,
    this.isOpen = false,
    required this.children,
    this.isAssociated = false,
    this.componentType = TractianAssetsComponentType.none,
    this.componentStatus = TractianAssetsComponentStatus.none,
  });

  IconData getIcon() {
    return type.getIcon();
  }

  bool get isComponent => type == TractianAssetType.component;

  bool get isOnAlert => componentStatus == TractianAssetsComponentStatus.alert;

  bool get isEnergySensor => type == TractianAssetType.component &&
      componentType == TractianAssetsComponentType.energySensor;

  bool get isVibrationSensor => type == TractianAssetType.component &&
      componentType == TractianAssetsComponentType.vibrationSensor;
}


