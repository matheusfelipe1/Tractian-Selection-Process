import 'package:traction_selection_process/app/core/constants/app_constants.dart';
import 'package:traction_selection_process/app/core/extensions/map_extensions.dart';
import 'package:traction_selection_process/app/domain/assets_tree/entities/assets_entity.dart';
import 'package:traction_selection_process/app/data/assets_tree/mappers/assets_tree_mapper.dart';
import 'package:traction_selection_process/app/data/assets_tree/mappers/assets_component_mapper.dart';

import 'sub_assets_mapper.dart';

class AssetsMapper {
  static List<AssetsEntity> fromDataList({
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
        .toList()
      ..sort((a, b) => a.children.length.compareTo(b.children.length));
  }

  static AssetsEntity _fromData({
    required Map<String, dynamic> asset,
    required TreeMapperList subAssets,
    required TreeMapperList components,
  }) {
    final id = asset.getValue(key: AppConstants.id);
    final componentAssets = components
        .where((component) => component.getValue(key: AppConstants.parentId) == id)
        .toList();

    return AssetsEntity(
      id: id,
      locationId: asset.getValue(key: AppConstants.locationId),
      name: asset.getOrDefaultValue(key: AppConstants.name, defaultValue: ""),
      children: [
        ...AssetsComponentMapper.fromDataList(componentAssets),
        ...SubAssetsMapper.fromDataList(
          parentId: id,
          subAssets: subAssets,
          components: components,
        ),
      ],
    );
  }
}
