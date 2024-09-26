import 'package:design_system/components/assets_tree/widgets/tractian_assets_tree_widget.dart';

class AssetsTreeEntity {
  final List<TreeBranches> branches;

  const AssetsTreeEntity({
    required this.branches,
  });

  AssetsTreeEntity copyWith({
    List<TreeBranches>? branches,
  }) {
    return AssetsTreeEntity(
      branches: branches ?? this.branches,
    );
  }
}

abstract class TreeBranches {
  final String id;
  final bool isOpen;
  final String name;
  final List<TreeBranches> children;

  TreeBranches({
    required this.id,
    required this.name,
    this.isOpen = false,
    this.children = const [],
  });

  TreeBranches copyWith({
    String? id,
    bool? isOpen,
    List<TreeBranches>? children,
  });

  TractianAssetsTree toDSEntity();
}
