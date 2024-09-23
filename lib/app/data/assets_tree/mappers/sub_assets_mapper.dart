import 'package:traction_selection_proccess/app/core/extensions/map_extensions.dart';
import 'package:traction_selection_proccess/app/domain/assets_tree/entities/sub_assets.dart';
import 'package:traction_selection_proccess/app/data/assets_tree/mappers/assets_tree_mapper.dart';
import 'package:traction_selection_proccess/app/data/assets_tree/mappers/component_asset_mapper.dart';

class SubAssetsMapper {
  static List<SubAssets> fromDataList({
    required TreeMapperList subAssets,
    required TreeMapperList components,
  }) {
    final subAssetsFiltered = subAssets
        .map(
            (subAsset) => _fromData(components: components, subAsset: subAsset))
        .toList();

    return subAssetsFiltered;
  }

  static SubAssets _fromData({
    required TreeMapperList components,
    required Map<String, dynamic> subAsset,
  }) {
    final id = subAsset.getValue(key: "id");

    final componentAssets = components
        .where((component) => component.getValue(key: "parentId") == id)
        .toList();

    return SubAssets(
      id: id,
      parentId: subAsset.getValue(key: "parentId"),
      children: ComponentMapper.fromDataList(componentAssets),
      name: subAsset.getOrDefaultValue(key: "name", defaultValue: ""),
    );
  }
}
