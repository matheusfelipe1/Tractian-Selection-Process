import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:traction_selection_process/app/core/use_cases/use_cases.dart';
import 'package:traction_selection_process/app/domain/assets_tree/entities/assets_tree_entity.dart';
import 'package:traction_selection_process/app/domain/assets_tree/entities/assets_component_entity.dart';

class FilterCriticalAlertUseCase
    extends UseCases<Future<AssetsTreeEntity>, FilterCriticalAlertParams> {
  @override
  Future<AssetsTreeEntity> call(FilterCriticalAlertParams params) async {
    if (params.criticalAlertActive) {
      final treeBranchesprocessed = params.assetsTreeprocessed.branches;

      final treeBranches = await compute(
        _deepCriticalAlertFilter,
        treeBranchesprocessed,
      );

      return AssetsTreeEntity(branches: treeBranches);
    }
    return params.assetsTreeCache;
  }

  static List<TreeBranches> _deepCriticalAlertFilter(
    List<TreeBranches> branches,
  ) {
    final List<TreeBranches> assetsTree = [];

    for (var element in branches) {
      if (element.children.isNotEmpty) {
        element = element.copyWith(
          isOpen: true,
          children: _deepCriticalAlertFilter(element.children),
        );
      }

      if (element is AssetsComponentEntity) {
        if (element.isCritical) {
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

class FilterCriticalAlertParams {
  final bool criticalAlertActive;
  final AssetsTreeEntity assetsTreeCache;
  final AssetsTreeEntity assetsTreeprocessed;

  FilterCriticalAlertParams({
    required this.assetsTreeCache,
    required this.criticalAlertActive,
    required this.assetsTreeprocessed,
  });
}
