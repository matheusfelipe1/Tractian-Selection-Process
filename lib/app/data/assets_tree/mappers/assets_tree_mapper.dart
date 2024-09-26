import 'package:traction_selection_process/app/core/constants/app_constants.dart';
import 'package:traction_selection_process/app/core/extensions/map_extensions.dart';
import 'package:traction_selection_process/app/data/assets_tree/mappers/assets_mapper.dart';
import 'package:traction_selection_process/app/domain/assets_tree/entities/assets_tree_entity.dart';
import 'package:traction_selection_process/app/data/assets_tree/mappers/assets_component_mapper.dart';

typedef TreeMapperList = List<Map<String, dynamic>>;

class AssetsTreeMappers {

  static List<TreeBranches> fromDataList(List data) {
    final dataList = data.cast<Map<String, dynamic>>();

    final assets = dataList.where(_isAnAsset).toList();
    final subAssets = dataList.where(_isASubAsset).toList();
    final componentUnliked = dataList.where(_isComponentUnliked).toList();
    final componentWParent = dataList.where(_isComponentWParent).toList();
    final componentWLocation = dataList.where(_isComponentWLocation).toList();

    return [
      ...AssetsComponentMapper.fromDataList(componentUnliked),
      ...AssetsComponentMapper.fromDataList(componentWLocation),
      ...AssetsMapper.fromDataList(
        assets: assets,
        subAssets: subAssets,
        components: componentWParent,
      ),
    ]..sort((a, b) => a.children.length.compareTo(b.children.length));
  }

  static bool _isComponentUnliked(Map<String, dynamic> data) {
    final parentId = data.getValue(key: AppConstants.parentId);
    final locationId = data.getValue(key: AppConstants.locationId);
    final sensorType = data.getValue(key: AppConstants.sensorType);

    return parentId == null && locationId == null && sensorType != null;
  }

  static bool _isAnAsset(Map<String, dynamic> data) {
    final sensorId = data.getValue(key: AppConstants.sensorId);
    final locationId = data.getValue(key: AppConstants.locationId);

    return sensorId == null && locationId != null;
  }

  static bool _isASubAsset(Map<String, dynamic> data) {
    final sensorId = data.getValue(key: AppConstants.sensorId);
    final parentId = data.getValue(key: AppConstants.parentId);

    return sensorId == null && parentId != null;
  }

  static bool _isComponentWParent(Map<String, dynamic> data) {
    final parentId = data.getValue(key: AppConstants.parentId);
    final sensorType = data.getValue(key: AppConstants.sensorType);

    return parentId != null && sensorType != null;
  }

  static bool _isComponentWLocation(Map<String, dynamic> data) {
    final locationId = data.getValue(key: AppConstants.locationId);
    final sensorType = data.getValue(key: AppConstants.sensorType);

    return locationId != null && sensorType != null;
  }
}
