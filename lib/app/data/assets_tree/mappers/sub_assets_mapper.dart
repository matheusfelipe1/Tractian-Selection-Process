import 'package:traction_selection_process/app/core/extensions/map_extensions.dart';
import 'package:traction_selection_process/app/domain/assets_tree/entities/sub_assets.dart';
import 'package:traction_selection_process/app/data/assets_tree/mappers/assets_tree_mapper.dart';
import 'package:traction_selection_process/app/data/assets_tree/mappers/assets_component_mapper.dart';

class SubAssetsMapper {
  static List<SubAssets> fromDataList({
    required String parentId,
    required TreeMapperList subAssets,
    required TreeMapperList components,
  }) {
    final subAssetsFiltered = subAssets
        .where((item) => item.getValue(key: "parentId") == parentId)
        .toList();
    final newSubAssets = subAssetsFiltered
        .map((subAsset) => _fromData(
              subAsset: subAsset,
              subAssets: subAssets,
              components: components,
            ))
        .toList();

    return newSubAssets
      ..sort((a, b) => a.children.length.compareTo(b.children.length));
  }

  static SubAssets _fromData({
    required TreeMapperList subAssets,
    required TreeMapperList components,
    required Map<String, dynamic> subAsset,
  }) {
    final id = subAsset.getValue(key: "id");

    final myAssetsComponent = components
        .where((component) => component.getValue(key: "parentId") == id)
        .toList();
    final anotherAssetsComponent = components
        .where((component) => component.getValue(key: "parentId") != id)
        .toList();

    return SubAssets(
      id: id,
      parentId: subAsset.getValue(key: "parentId"),
      name: subAsset.getOrDefaultValue(key: "name", defaultValue: ""),
      children: [
        ...AssetsComponentMapper.fromDataList(myAssetsComponent),
        ...fromDataList(
          parentId: id,
          subAssets: subAssets,
          components: anotherAssetsComponent,
        ),
      ],
    );
  }
}
