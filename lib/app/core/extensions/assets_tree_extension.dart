
import 'package:design_system/design_system.dart';
import 'package:traction_selection_proccess/app/domain/tree/entities/tree_assets.dart';

extension TreeBranchesExtensions on List<TreeBranches> {
  
  List<TractianAssetsTree> toDSData() {
    return map((e) => e.toDSData()).toList();
  }
}