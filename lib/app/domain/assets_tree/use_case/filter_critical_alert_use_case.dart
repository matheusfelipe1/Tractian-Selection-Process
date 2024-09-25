import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:traction_selection_proccess/app/core/use_cases/use_cases.dart';
import 'package:traction_selection_proccess/app/domain/assets_tree/entities/tree_assets.dart';
import 'package:traction_selection_proccess/app/domain/assets_tree/entities/assets_component.dart';

class FilterCriticalAlertUseCase extends UseCases<Future<AssetsTree>, FilterCriticalAlertParams> {

  @override
  Future<AssetsTree> call(FilterCriticalAlertParams params) async {
    if (params.criticalAlertActive) {
      final treeBranchesProccessed = params.assetsTreeProccessed.branches;

      final treeBranches = await compute(
        _deepCriticalAlertFilter,
        treeBranchesProccessed,
      );

      return AssetsTree(branches: treeBranches);
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

      if (element is AssetsComponent) {
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
  final AssetsTree assetsTreeCache;
  final AssetsTree assetsTreeProccessed;

  FilterCriticalAlertParams({
    required this.assetsTreeCache,
    required this.criticalAlertActive,
    required this.assetsTreeProccessed,
  });
}