import 'package:design_system/components/assets_tree/widgets/tractian_assets_tree_widget.dart';
import 'package:design_system/styles/traction_asset_type.dart';
import 'package:traction_selection_process/app/domain/assets_tree/entities/assets_tree_entity.dart';

class SubLocationEntity extends TreeBranches {
  final String parentId;

  SubLocationEntity({
    super.isOpen,
    required super.id,
    required super.name,
    required this.parentId,
    super.children = const [],
  });

  @override
  SubLocationEntity copyWith({
    String? id,
    bool? isOpen,
    String? name,
    String? parentId,
    List<TreeBranches>? children,
  }) {
    return SubLocationEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      isOpen: isOpen ?? this.isOpen,
      parentId: parentId ?? this.parentId,
      children: children ?? this.children,
    );
  }

  @override
  TractianAssetsTree toDSEntity() {
    return TractianAssetsTree(
      id: id,
      name: name,
      isOpen: isOpen,
      type: TractianAssetType.subLocation,
      children: children.map((e) => e.toDSEntity()).toList(),
    );
  }
}
