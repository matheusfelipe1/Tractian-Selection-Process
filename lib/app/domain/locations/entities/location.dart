import 'package:design_system/design_system.dart';
import 'package:traction_selection_proccess/app/domain/tree/entities/tree_assets.dart';

class Location extends TreeBranches {
  final String name;

  Location({
    super.isOpen,
    required super.id,
    required this.name,
    super.children = const [],
  });

  @override
  Location copyWith({
    String? id,
    String? name,
    bool? isOpen,
    List<TreeBranches>? children,
  }) {
    return Location(
      id: id ?? this.id,
      name: name ?? this.name,
      isOpen: isOpen ?? this.isOpen,
      children: children ?? this.children,
    );
  }

  @override
  TractianAssetsTree toDSData() {
    return TractianAssetsTree(
      id: id,
      name: name,
      isOpen: isOpen,
      type: TractianAssetType.location,
      children: children.map((e) => e.toDSData()).toList(),
    );
  }
}
