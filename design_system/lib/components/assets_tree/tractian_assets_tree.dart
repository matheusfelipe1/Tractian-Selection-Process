part of 'widgets/tractian_assets_tree_widget.dart';

class TractianAssetsTree {
  final dynamic id;
  final String name;
  final bool isOpen;
  final bool critical;
  final bool isAssociated;
  final TractianAssetType type;
  final List<TractianAssetsTree> children;

  TractianAssetsTree({
    this.id,
    required this.name,
    required this.type,
    this.isOpen = true,
    this.critical = false,
    required this.children,
    this.isAssociated = false,
  });

  IconData getIcon() {
    return type.getIcon();
  }

  bool get isComponent => type == TractianAssetType.component;

  bool get isCritical => critical;
}
