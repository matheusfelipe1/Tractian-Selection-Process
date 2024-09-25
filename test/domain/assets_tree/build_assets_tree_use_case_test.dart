import 'package:flutter_test/flutter_test.dart';
import 'package:traction_selection_process/app/domain/assets_tree/entities/assets.dart';
import 'package:traction_selection_process/app/domain/assets_tree/entities/assets_component.dart';
import 'package:traction_selection_process/app/domain/assets_tree/entities/sub_assets.dart';
import 'package:traction_selection_process/app/domain/assets_tree/entities/tree_assets.dart';
import 'package:traction_selection_process/app/domain/assets_tree/use_case/build_assets_tree_use_case.dart';
import 'package:traction_selection_process/app/domain/locations/entities/location.dart';
import 'package:traction_selection_process/app/domain/locations/entities/sub_location.dart';

void main() {
  final BuildAssetsTreeUseCase buildAssetsTreeUseCase =
      BuildAssetsTreeUseCase();

  test(
    "Test",
    () async {
      final result = buildAssetsTreeUseCase(assetsTree);
      print(result);
    },
  );
}

final AssetsTree assetsTree = AssetsTree(
  branches: [
    ...[
      AssetsComponent(
        id: "140",
        sensorId: "1290",
        name: "Energy Component",
        sensorType: SensorType.energySensor,
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
                sensorStatus: SensorStatus.alert,
                sensorType: SensorType.energySensor,
              ),
              AssetsComponent(
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
    ...[
      Location(
        id: "123",
        name: "Production Tractian",
        children: [
          SubLocation(id: "0012", name: "Sub Production", parentId: "123"),
          SubLocation(
            id: "002",
            name: "Sub Production2",
            parentId: "123",
            children: [
              SubLocation(
                id: "004",
                name: "Sub Production",
                parentId: "123",
                children: [
                  SubLocation(
                      id: "007", name: "Sub Production", parentId: "123"),
                  SubLocation(
                      id: "001",
                      name: "Sub Production",
                      parentId: "123",
                      children: [
                        SubLocation(
                            id: "0090",
                            name: "Sub Production",
                            parentId: "123"),
                      ]),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
    ...[
      Location(
        id: "123",
        name: "Production Tractian",
        children: [
          SubLocation(id: "0012", name: "Sub Production", parentId: "123"),
          SubLocation(
            id: "002",
            name: "Sub Production2",
            parentId: "123",
            children: [
              SubLocation(
                id: "004",
                name: "Sub Production",
                parentId: "123",
                children: [
                  SubLocation(
                      id: "007", name: "Sub Production", parentId: "123"),
                  SubLocation(
                      id: "001",
                      name: "Sub Production",
                      parentId: "123",
                      children: [
                        SubLocation(
                            id: "0090",
                            name: "Sub Production",
                            parentId: "123"),
                      ]),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
    ...[
      Location(
        id: "123",
        name: "Production Tractian",
        children: [
          SubLocation(id: "0012", name: "Sub Production", parentId: "123"),
          SubLocation(
            id: "002",
            name: "Sub Production2",
            parentId: "123",
            children: [
              SubLocation(
                id: "004",
                name: "Sub Production",
                parentId: "123",
                children: [
                  SubLocation(
                      id: "007", name: "Sub Production", parentId: "123"),
                  SubLocation(
                      id: "001",
                      name: "Sub Production",
                      parentId: "123",
                      children: [
                        SubLocation(
                            id: "0090",
                            name: "Sub Production",
                            parentId: "123"),
                      ]),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
    ...[
      Location(
        id: "123",
        name: "Production Tractian",
        children: [
          SubLocation(id: "0012", name: "Sub Production", parentId: "123"),
          SubLocation(
            id: "002",
            name: "Sub Production2",
            parentId: "123",
            children: [
              SubLocation(
                id: "004",
                name: "Sub Production",
                parentId: "123",
                children: [
                  SubLocation(
                      id: "007", name: "Sub Production", parentId: "123"),
                  SubLocation(
                      id: "001",
                      name: "Sub Production",
                      parentId: "123",
                      children: [
                        SubLocation(
                            id: "0090",
                            name: "Sub Production",
                            parentId: "123"),
                      ]),
                ],
              ),
            ],
          ),
        ],
      ),
    ]
  ],
);
