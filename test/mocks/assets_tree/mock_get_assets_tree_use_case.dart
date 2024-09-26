import 'package:mocktail/mocktail.dart';
import 'package:traction_selection_process/app/core/utils/result.dart';
import 'package:traction_selection_process/app/domain/assets_tree/entities/assets_entity.dart';
import 'package:traction_selection_process/app/domain/assets_tree/entities/sub_assets_entity.dart';
import 'package:traction_selection_process/app/domain/assets_tree/entities/assets_tree_entity.dart';
import 'package:traction_selection_process/app/domain/assets_tree/entities/assets_component_entity.dart';
import 'package:traction_selection_process/app/domain/assets_tree/use_case/get_tree_asset_use_case.dart';

class MockGetAssetsTreeUseCase extends Mock implements GetAssetsTreeUseCase {
  @override
  Future<AssetsTreeResult> call(String params) async {
    return Result.success(
      AssetsTreeEntity(
        branches: [
          AssetsComponentEntity(
            id: "140",
            sensorId: "1290",
            name: "Energy Component",
            sensorType: SensorType.energySensor,
            sensorStatus: SensorStatus.operating,
          ),
          AssetsEntity(
            id: "50",
            locationId: "001",
            name: "Asset Tractian",
            children: [
              SubAssetsEntity(
                id: "90",
                parentId: "50",
                name: "Sub Asset Tractian",
                children: [
                  AssetsComponentEntity(
                    id: "140",
                    parentId: "90",
                    sensorId: "1890",
                    name: "Component critical",
                    sensorType: SensorType.energySensor,
                    sensorStatus: SensorStatus.alert,
                  ),
                  AssetsComponentEntity(
                    id: "140",
                    parentId: "90",
                    sensorId: "1890",
                    name: "Energy 2",
                    sensorType: SensorType.energySensor,
                    sensorStatus: SensorStatus.operating,
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
