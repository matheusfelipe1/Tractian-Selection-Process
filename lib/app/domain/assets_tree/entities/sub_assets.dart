import 'package:design_system/design_system.dart';
import 'package:traction_selection_proccess/app/domain/assets_tree/entities/component_asset.dart';
import 'package:traction_selection_proccess/app/domain/assets_tree/entities/tree_assets.dart';

class SubAssets extends TreeBranches {
  final String name;
  final String parentId;

  SubAssets({
    super.isOpen,
    required super.id,
    required this.name,
    required this.parentId,
    required super.children,
  });

  @override
  SubAssets copyWith({
    String? id,
    bool? isOpen,
    String? name,
    String? parentId,
    List<TreeBranches>? children,
    List<ComponentAsset>? componentAssets,
  }) {
    return SubAssets(
      id: id ?? this.id,
      name: name ?? this.name,
      isOpen: isOpen ?? this.isOpen,
      children: children ?? this.children,
      parentId: parentId ?? this.parentId,
    );
  }

  @override
  TractianAssetsTree toDSEntity() {
    return TractianAssetsTree(
      id: id,
      name: name,
      isOpen: isOpen,
      type: TractianAssetType.subasset,
      children: children.map((e) => e.toDSEntity()).toList(),
    );
  }
}
