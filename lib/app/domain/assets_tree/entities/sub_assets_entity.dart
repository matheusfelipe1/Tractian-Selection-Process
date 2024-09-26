import 'package:design_system/design_system.dart';
import 'package:traction_selection_process/app/domain/assets_tree/entities/assets_component_entity.dart';
import 'package:traction_selection_process/app/domain/assets_tree/entities/assets_tree_entity.dart';

class SubAssetsEntity extends TreeBranches {
  final String parentId;

  SubAssetsEntity({
    super.isOpen,
    required super.id,
    required super.name,
    required this.parentId,
    required super.children,
  });

  @override
  SubAssetsEntity copyWith({
    String? id,
    bool? isOpen,
    String? name,
    String? parentId,
    List<TreeBranches>? children,
    List<AssetsComponentEntity>? componentAssets,
  }) {
    return SubAssetsEntity(
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
