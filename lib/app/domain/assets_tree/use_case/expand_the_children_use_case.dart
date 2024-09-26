import 'package:traction_selection_process/app/core/use_cases/use_cases.dart';
import 'package:traction_selection_process/app/domain/assets_tree/entities/assets_tree_entity.dart';

class ExpandTheChildrenUseCase extends UseCases<AssetsTreeEntity, ExpandTheChildrenParams> {
  @override
  AssetsTreeEntity call(ExpandTheChildrenParams params) {
    final assetsTree = AssetsTreeEntity(
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

class ExpandTheChildrenParams {
  final String id;
  final List<TreeBranches> branches;

  ExpandTheChildrenParams({
    required this.id,
    required this.branches,
  });
}
