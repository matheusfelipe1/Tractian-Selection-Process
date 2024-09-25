import 'package:flutter_test/flutter_test.dart';
import 'package:traction_selection_process/app/domain/assets_tree/entities/assets.dart';
import 'package:traction_selection_process/app/domain/assets_tree/entities/assets_component.dart';
import 'package:traction_selection_process/app/domain/assets_tree/entities/tree_assets.dart';
import 'package:traction_selection_process/app/domain/assets_tree/use_case/filter_by_text_assets_tree_use_case.dart';
import 'package:traction_selection_process/app/domain/locations/entities/location.dart';
import 'package:traction_selection_process/app/domain/locations/entities/sub_location.dart';
import 'package:traction_selection_process/app/domain/tasks/tasks_manager.dart';

void main() {
  final FilterByTextAssetsTreeUseCase filterByTextAssetsTreeUseCase =
      FilterByTextAssetsTreeUseCase(
    TasksManager(),
  );
  test(
    "Must show assets tree filtered by text",
    () async {
      final params = FilterByTextAssetsTreeParams(
        query: "Tractian 1",
        isCritical: false,
        isEnergySensor: false,
        branches: _assetsTreeMock.branches,
      );
      final onReceivedResults = filterByTextAssetsTreeUseCase(params);

      print(onReceivedResults);
    },
    timeout: const Timeout(Duration(seconds: 60)),
  );
}

final _assetsTreeMock = AssetsTree(
  branches: [
    Location(
      id: "012",
      name: "Tractian 1",
      children: [
        SubLocation(
          id: "001",
          name: "Sub 1",
          parentId: "012",
          children: [
            Assets(
              id: "0090",
              name: "Asset 1",
              locationId: "001",
              children: [
                AssetsComponent(
                    id: "0018",
                    parentId: "0090",
                    name: "Component 1",
                    sensorId: "1890",
                    sensorType: SensorType.energySensor,
                    sensorStatus: SensorStatus.operating),
                AssetsComponent(
                    id: "0019",
                    parentId: "0090",
                    name: "Component 2",
                    sensorId: "1890",
                    sensorType: SensorType.energySensor,
                    sensorStatus: SensorStatus.alert),
                AssetsComponent(
                    id: "0020",
                    parentId: "0090",
                    name: "Component 3",
                    sensorId: "1890",
                    sensorType: SensorType.vibrationSensor,
                    sensorStatus: SensorStatus.operating),
                AssetsComponent(
                    id: "0021",
                    parentId: "0090",
                    name: "Component 4",
                    sensorId: "1890",
                    sensorType: SensorType.vibrationSensor,
                    sensorStatus: SensorStatus.alert),
              ],
            )
          ],
        ),
      ],
    ),
    Location(
      id: "012",
      name: "Tractian 2",
      children: [
        SubLocation(
          id: "001",
          name: "Sub 1",
          parentId: "012",
          children: [
            Assets(
              id: "0090",
              name: "Asset 1",
              locationId: "001",
              children: [],
            ),
          ],
        )
      ],
    ),
    AssetsComponent(
      id: "0021",
      name: "Component 5",
      sensorId: "1890",
      sensorType: SensorType.vibrationSensor,
      sensorStatus: SensorStatus.alert,
    ),
  ],
);
