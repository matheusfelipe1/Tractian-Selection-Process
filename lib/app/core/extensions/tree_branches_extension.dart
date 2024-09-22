import 'package:traction_selection_proccess/app/domain/assets_tree/entities/assets.dart';
import 'package:traction_selection_proccess/app/domain/assets_tree/entities/tree_assets.dart';
import 'package:design_system/components/assets_tree/widgets/tractian_assets_tree_widget.dart';
import 'package:traction_selection_proccess/app/domain/assets_tree/entities/component_asset.dart';

extension ComponentExtensions on List<TreeBranches> {
  List<ComponentAsset> get componentsUnliked =>
      where((item) => item is ComponentAsset && !item.isAssociated)
          .map((item) => item as ComponentAsset)
          .toList();

  List<ComponentAsset> get componentsWLocation =>
      where((item) => item is ComponentAsset && item.hasLocation)
          .map((item) => item as ComponentAsset)
          .toList();

  List<Assets> get assets =>
      where((item) => item is Assets).map((item) => item as Assets).toList();

  List<TractianAssetsTree> toDSEntity() {
    return map((e) => e.toDSEntity()).toList();
  }
}
