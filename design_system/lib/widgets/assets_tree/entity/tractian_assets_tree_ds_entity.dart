import 'package:design_system/styles/traction_asset_type.dart';
import 'package:flutter/material.dart';

class TractianAssetsTreeDSEntity {
  final String name;
  final bool isOpen;
  final bool critical;
  final TractianAssetType type;
  final List<TractianAssetsTreeDSEntity> children;

  TractianAssetsTreeDSEntity({
    required this.name,
    required this.type,
    this.isOpen = true,
    required this.children,
    this.critical = false,
  });

  IconData getIcon() {
    return type.getIcon();
  }

  bool get isComponent => type == TractianAssetType.component;

  bool get isCritical => !isComponent ? false : critical;
}
