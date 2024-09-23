import 'package:traction_selection_proccess/app/core/extensions/map_extensions.dart';
import 'package:traction_selection_proccess/app/data/assets/mappers/assets_mapper.dart';
import 'package:traction_selection_proccess/app/data/assets/mappers/component_asset_mapped.dart';
import 'package:traction_selection_proccess/app/domain/assets_tree/entities/tree_assets.dart';

typedef TreeMapperList = List<Map<String, dynamic>>;

class AssetsTreeMappers {
  static const _parentId = "parentId";
  static const _sensorId = "sensorId";
  static const _sensorType = "sensorType";
  static const _locationId = "locationId";


  static List<TreeBranches> fromDataList(List data) {
    final dataList = data.cast<Map<String, dynamic>>();

    final assets = dataList.where(_isAnAsset).toList();
    final subAssets = dataList.where(_isASubAsset).toList();
    final componentUnliked = dataList.where(_isComponentUnliked).toList();
    final componentWParent = dataList.where(_isComponentWParent).toList();
    final componentWLocation = dataList.where(_isComponentWLocation).toList();

    return [
      ...ComponentMapped.fromDataList(componentUnliked),
      ...ComponentMapped.fromDataList(componentWLocation),
      ...AssetsMapper.fromDataList(
        assets: assets,
        subAssets: subAssets,
        components: componentWParent,
      ),
    ];
  }

  static bool _isComponentUnliked(Map<String, dynamic> data) {
    final parentId = data.getValue(key: _parentId);
    final location = data.getValue(key: _locationId);
    final sensorType = data.getValue(key: _sensorType);

    return parentId == null && location == null && sensorType != null;
  }

  static bool _isAnAsset(Map<String, dynamic> data) {
    final sensorId = data.getValue(key: _sensorId);
    final locationId = data.getValue(key: _locationId);

    return sensorId == null && locationId != null;
  }

  static bool _isASubAsset(Map<String, dynamic> data) {
    final sensorId = data.getValue(key: _sensorId);
    final parentId = data.getValue(key: _parentId);

    return sensorId == null && parentId != null;
  }

  static bool _isComponentWParent(Map<String, dynamic> data) {
    final parentId = data.getValue(key: _parentId);
    final sensorType = data.getValue(key: _sensorType);

    return parentId != null && sensorType != null;
  }

  static bool _isComponentWLocation(Map<String, dynamic> data) {
    final location = data.getValue(key: _locationId);
    final sensorType = data.getValue(key: _sensorType);

    return location != null && sensorType != null;
  }
}
