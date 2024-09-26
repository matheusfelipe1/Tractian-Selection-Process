import 'package:flutter_test/flutter_test.dart';
import 'package:traction_selection_process/app/domain/tasks/tasks_manager.dart';
import 'package:traction_selection_process/app/domain/locations/entities/location_entity.dart';
import 'package:traction_selection_process/app/domain/assets_tree/entities/assets_entity.dart';
import 'package:traction_selection_process/app/domain/locations/entities/sub_location_entity.dart';
import 'package:traction_selection_process/app/domain/assets_tree/entities/assets_tree_entity.dart';
import 'package:traction_selection_process/app/domain/assets_tree/entities/assets_component_entity.dart';
import 'package:traction_selection_process/app/domain/assets_tree/use_case/filter_by_text_assets_tree_use_case.dart';

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

final _assetsTreeMock = AssetsTreeEntity(
  branches: [
    LocationEntity(
      id: "012",
      name: "Tractian 1",
      children: [
        SubLocationEntity(
          id: "001",
          name: "Sub 1",
          parentId: "012",
          children: [
            AssetsEntity(
              id: "0090",
              name: "Asset 1",
              locationId: "001",
              children: [
                AssetsComponentEntity(
                    id: "0018",
                    parentId: "0090",
                    name: "Component 1",
                    sensorId: "1890",
                    sensorType: SensorType.energySensor,
                    sensorStatus: SensorStatus.operating),
                AssetsComponentEntity(
                    id: "0019",
                    parentId: "0090",
                    name: "Component 2",
                    sensorId: "1890",
                    sensorType: SensorType.energySensor,
                    sensorStatus: SensorStatus.alert),
                AssetsComponentEntity(
                    id: "0020",
                    parentId: "0090",
                    name: "Component 3",
                    sensorId: "1890",
                    sensorType: SensorType.vibrationSensor,
                    sensorStatus: SensorStatus.operating),
                AssetsComponentEntity(
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
    LocationEntity(
      id: "012",
      name: "Tractian 2",
      children: [
        SubLocationEntity(
          id: "001",
          name: "Sub 1",
          parentId: "012",
          children: [
            AssetsEntity(
              id: "0090",
              name: "Asset 1",
              locationId: "001",
              children: [],
            ),
          ],
        )
      ],
    ),
    AssetsComponentEntity(
      id: "0021",
      name: "Component 5",
      sensorId: "1890",
      sensorType: SensorType.vibrationSensor,
      sensorStatus: SensorStatus.alert,
    ),
  ],
);
