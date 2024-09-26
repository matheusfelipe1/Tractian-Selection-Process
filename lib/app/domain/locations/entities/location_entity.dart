import 'package:design_system/design_system.dart';
import 'package:traction_selection_process/app/domain/assets_tree/entities/assets_tree_entity.dart';

class LocationEntity extends TreeBranches {
  LocationEntity({
    super.isOpen,
    required super.id,
    required super.name,
    super.children = const [],
  });

  @override
  LocationEntity copyWith({
    String? id,
    String? name,
    bool? isOpen,
    List<TreeBranches>? children,
  }) {
    return LocationEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      isOpen: isOpen ?? this.isOpen,
      children: children ?? this.children,
    );
  }

  @override
  TractianAssetsTree toDSEntity() {
    return TractianAssetsTree(
      id: id,
      name: name,
      isOpen: isOpen,
      type: TractianAssetType.location,
      children: children.map((e) => e.toDSEntity()).toList(),
    );
  }
}
