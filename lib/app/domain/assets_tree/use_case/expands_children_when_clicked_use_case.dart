import 'package:traction_selection_proccess/app/core/use_cases/use_cases.dart';
import 'package:traction_selection_proccess/app/domain/assets_tree/entities/tree_assets.dart';

class ExpandsChildrenWhenClickedUseCase extends UseCases<AssetsTree, ExpandsChildrenWhenClickedParams> {

  @override
  AssetsTree call(ExpandsChildrenWhenClickedParams params) {
     final assetsTree = AssetsTree(
      branches: _deepSearchToExpands(params.id, params.branches),
    );
    return assetsTree;
  }

   List<TreeBranches> _deepSearchToExpands(
    String id,
    List<TreeBranches> branches,
  ) {
    final List<TreeBranches> assetsTree = [];

    for (var element in branches) {
      if (element.children.isNotEmpty) {
        element = element.copyWith(
          children: _deepSearchToExpands(id, element.children),
        );
      }

      if (element.id == id) {
        element = element.copyWith(isOpen: !element.isOpen);
      }

      assetsTree.add(element);
    }

    return assetsTree;
  }

}

class ExpandsChildrenWhenClickedParams {
  final String id;
  final List<TreeBranches> branches;

  ExpandsChildrenWhenClickedParams({
    required this.id,
    required this.branches,
  });
}