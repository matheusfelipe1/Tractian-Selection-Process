import 'package:design_system/design_system.dart';
import 'package:traction_selection_process/app/domain/assets_tree/entities/assets_tree_entity.dart';

class AssetsEntity extends TreeBranches {
  final String locationId;

  AssetsEntity({
    super.isOpen,
    required super.id,
    required super.name,
    required super.children,
    required this.locationId,
  });

  @override
  AssetsEntity copyWith({
    String? id,
    String? name,
    bool? isOpen,
    String? locationId,
    List<TreeBranches>? children,
  }) {
    return AssetsEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      isOpen: isOpen ?? this.isOpen,
      children: children ?? this.children,
      locationId: locationId ?? this.locationId,
    );
  }

  @override
  TractianAssetsTree toDSEntity() {
    return TractianAssetsTree(
      id: id,
      name: name,
      isOpen: isOpen,
      type: TractianAssetType.asset,
      children: children.map((e) => e.toDSEntity()).toList(),
    );
  }
}
