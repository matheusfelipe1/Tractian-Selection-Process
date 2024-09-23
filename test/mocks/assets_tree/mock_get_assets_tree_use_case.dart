import 'package:mocktail/mocktail.dart';
import 'package:traction_selection_proccess/app/core/utils/result.dart';
import 'package:traction_selection_proccess/app/domain/assets_tree/entities/assets.dart';
import 'package:traction_selection_proccess/app/domain/assets_tree/entities/sub_assets.dart';
import 'package:traction_selection_proccess/app/domain/assets_tree/entities/tree_assets.dart';
import 'package:traction_selection_proccess/app/domain/assets_tree/entities/assets_component.dart';
import 'package:traction_selection_proccess/app/domain/assets_tree/use_case/get_tree_asset_use_case.dart';

class MockGetAssetsTreeUseCase extends Mock implements GetAssetsTreeUseCase {
  @override
  Future<AssetsTreeResult> call(String params) async {
    return Result.success(
      AssetsTree(
        branches: [
          AssetsComponent(
            id: "140",
            sensorId: "1290",
            name: "Energy Component",
            sensorType: SensorType.energy,
            sensorStatus: SensorStatus.operating,
          ),
          Assets(
            id: "50",
            locationId: "001",
            name: "Asset Tractian",
            children: [
              SubAssets(
                id: "90",
                parentId: "50",
                name: "Sub Asset Tractian",
                children: [
                  AssetsComponent(
                    id: "140",
                    parentId: "90",
                    sensorId: "1890",
                    name: "Component critical",
                    sensorType: SensorType.energy,
                    sensorStatus: SensorStatus.alert,
                  ),
                  AssetsComponent(
                    id: "140",
                    parentId: "90",
                    sensorId: "1890",
                    name: "Energy 2",
                    sensorType: SensorType.energy,
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
