import 'package:design_system/styles/traction_asset_type.dart';
import 'package:traction_selection_process/app/domain/assets_tree/entities/assets.dart';
import 'package:traction_selection_process/app/domain/assets_tree/entities/tree_assets.dart';
import 'package:design_system/components/assets_tree/widgets/tractian_assets_tree_widget.dart';
import 'package:traction_selection_process/app/domain/assets_tree/entities/assets_component.dart';

extension ComponentExtensions on List<TreeBranches> {
  List<AssetsComponent> get componentsUnliked =>
      where((item) => item is AssetsComponent && !item.isAssociated)
          .map((item) => item as AssetsComponent)
          .toList();

  List<AssetsComponent> get componentsWLocation =>
      where((item) => item is AssetsComponent && item.hasLocation)
          .map((item) => item as AssetsComponent)
          .toList();

  List<Assets> get assets =>
      where((item) => item is Assets).map((item) => item as Assets).toList();

  List<TractianAssetsTree> toDSEntity() {
    final dataList = map((e) => e.toDSEntity()).toList();
    dataList.sort((_, b) => b.type == TractianAssetType.location ? 1 : -1);
    dataList.sort((a, b) => b.children.length > a.children.length ? 1 : -1);
    return dataList;
  }
}
