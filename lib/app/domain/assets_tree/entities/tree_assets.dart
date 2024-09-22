import 'package:design_system/components/assets_tree/widgets/tractian_assets_tree_widget.dart';

class AssetsTree {
  final List<TreeBranches> branches;

  AssetsTree({
    required this.branches,
  });
}

abstract class TreeBranches {
  final String id;
  final bool isOpen;
  final List<TreeBranches> children;

  TreeBranches({
    required this.id,
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
