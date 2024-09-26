import 'package:design_system/styles/traction_asset_type.dart';
import 'package:traction_selection_process/app/domain/assets_tree/entities/assets_entity.dart';
import 'package:traction_selection_process/app/domain/assets_tree/entities/assets_tree_entity.dart';
import 'package:design_system/components/assets_tree/widgets/tractian_assets_tree_widget.dart';
import 'package:traction_selection_process/app/domain/assets_tree/entities/assets_component_entity.dart';

extension ComponentExtensions on List<TreeBranches> {
  List<AssetsComponentEntity> get componentsUnlinked =>
      where((item) => item is AssetsComponentEntity && !item.isAssociated)
          .map((item) => item as AssetsComponentEntity)
          .toList();

  List<AssetsComponentEntity> get componentsWLocation =>
      where((item) => item is AssetsComponentEntity && item.hasLocation)
          .map((item) => item as AssetsComponentEntity)
          .toList();

  List<AssetsEntity> get assets =>
      where((item) => item is AssetsEntity).map((item) => item as AssetsEntity).toList();

  List<TractianAssetsTree> toDSEntity() {
    final dataList = map((e) => e.toDSEntity()).toList();
    dataList.sort((_, b) => b.type == TractianAssetType.location ? 1 : -1);
    dataList.sort((a, b) => b.children.length > a.children.length ? 1 : -1);
    return dataList;
  }
}
