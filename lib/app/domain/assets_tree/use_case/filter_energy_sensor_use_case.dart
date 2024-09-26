import 'package:flutter/foundation.dart';
import 'package:traction_selection_process/app/core/use_cases/use_cases.dart';
import 'package:traction_selection_process/app/domain/assets_tree/entities/assets_tree_entity.dart';
import 'package:traction_selection_process/app/domain/assets_tree/entities/assets_component_entity.dart';

class FilterEnergySensorUseCase
    extends UseCases<Future<AssetsTreeEntity>, FilterEnergySensorParams> {
  @override
  Future<AssetsTreeEntity> call(FilterEnergySensorParams params) async {
    if (params.energySensorActive) {
      final treeBranchesprocessed = params.assetsTreeprocessed.branches;

      final treeBranches = await compute(
        _deepEnergySensorFilter,
        treeBranchesprocessed,
      );

      return AssetsTreeEntity(branches: treeBranches);
    }
    return params.assetsTreeCache;
  }

  static List<TreeBranches> _deepEnergySensorFilter(
    List<TreeBranches> branches,
  ) {
    final List<TreeBranches> assetsTree = [];

    for (var element in branches) {
      if (element.children.isNotEmpty) {
        element = element.copyWith(
          isOpen: true,
          children: _deepEnergySensorFilter(element.children),
        );
      }

      if (element is AssetsComponentEntity) {
        if (element.isEnergySensor) {
          assetsTree.add(element);
        }
      }

      if (element.children.isNotEmpty) {
        assetsTree.add(element);
      }
    }

    return assetsTree;
  }
}

class FilterEnergySensorParams {
  final bool energySensorActive;
  final AssetsTreeEntity assetsTreeCache;
  final AssetsTreeEntity assetsTreeprocessed;

  FilterEnergySensorParams({
    required this.assetsTreeCache,
    required this.energySensorActive,
    required this.assetsTreeprocessed,
  });
}
