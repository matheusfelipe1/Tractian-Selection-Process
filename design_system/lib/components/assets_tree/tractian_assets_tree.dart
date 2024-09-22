part of 'widgets/tractian_assets_tree_widget.dart';

class TractianAssetsTree {
  final String name;
  final bool isOpen;
  final bool critical;
  final TractianAssetType type;
  final List<TractianAssetsTree> children;

  TractianAssetsTree({
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
