import 'package:traction_selection_proccess/app/domain/assets_tree/entities/assets.dart';
import 'package:traction_selection_proccess/app/core/extensions/map_extensions.dart';
import 'package:traction_selection_proccess/app/data/assets_tree/mappers/component_asset_mapper.dart';
import 'package:traction_selection_proccess/app/data/assets_tree/mappers/assets_tree_mapper.dart';

import 'sub_assets_mapper.dart';

class AssetsMapper {
  static List<Assets> fromDataList({
    required TreeMapperList assets,
    required TreeMapperList subAssets,
    required TreeMapperList components,
  }) {
    return assets
        .map(
          (asset) => _fromData(
            asset: asset,
            subAssets: subAssets,
            components: components,
          ),
        )
        .toList();
  }

  static Assets _fromData({
    required Map<String, dynamic> asset,
    required TreeMapperList subAssets,
    required TreeMapperList components,
  }) {
    final id = asset.getValue(key: "id");
    final componentAssets = components
        .where((component) => component.getValue(key: "parentId") == id)
        .toList();
    final subAssetsFiltered = subAssets
        .where((item) => item.getValue(key: "parentId") == id)
        .toList();

    return Assets(
      id: id,
      locationId: asset.getValue(key: "locationId"),
      name: asset.getOrDefaultValue(key: "name", defaultValue: ""),
      children: [
        ...ComponentMapper.fromDataList(componentAssets),
        ...SubAssetsMapper.fromDataList(
          components: components,
          subAssets: subAssetsFiltered,
        ),
      ],
    );
  }
}
