import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

enum TractianAssetType {
  asset,
  location,
  subasset,
  component,
  subLocation;

  IconData getIcon() {
    return switch (this) {
      TractianAssetType.location ||
      TractianAssetType.subLocation =>
        TractianIcons.location,
      TractianAssetType.asset ||
      TractianAssetType.subasset =>
        TractianIcons.cube,
      _ => TractianIcons.codepen,
    };
  }
}
