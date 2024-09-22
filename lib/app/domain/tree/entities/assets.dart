import 'package:design_system/design_system.dart';
import 'package:traction_selection_proccess/app/domain/tree/entities/tree_assets.dart';

class Assets extends TreeBranches {
  final String name;
  final String locationId;

  Assets({
    super.isOpen,
    required super.id,
    required this.name,
    required super.children,
    required this.locationId,
  });

  @override
  Assets copyWith({
    String? id,
    String? name,
    bool? isOpen,
    String? locationId,
    List<TreeBranches>? children,
  }) {
    return Assets(
      id: id ?? this.id,
      name: name ?? this.name,
      isOpen: isOpen ?? this.isOpen,
      children: children ?? this.children,
      locationId: locationId ?? this.locationId,
    );
  }

  @override
  TractianAssetsTree toDSData() {
    return TractianAssetsTree(
      id: id,
      name: name,
      isOpen: isOpen,
      type: TractianAssetType.asset,
      children: children.map((e) => e.toDSData()).toList(),
    );
  }
}
