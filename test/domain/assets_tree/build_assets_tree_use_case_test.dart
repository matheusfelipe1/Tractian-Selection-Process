import 'package:flutter_test/flutter_test.dart';
import 'package:traction_selection_process/app/domain/assets_tree/entities/assets_entity.dart';
import 'package:traction_selection_process/app/domain/assets_tree/entities/assets_component_entity.dart';
import 'package:traction_selection_process/app/domain/assets_tree/entities/sub_assets_entity.dart';
import 'package:traction_selection_process/app/domain/assets_tree/entities/assets_tree_entity.dart';
import 'package:traction_selection_process/app/domain/assets_tree/use_case/build_assets_tree_use_case.dart';
import 'package:traction_selection_process/app/domain/locations/entities/location_entity.dart';
import 'package:traction_selection_process/app/domain/locations/entities/sub_location_entity.dart';

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

final AssetsTreeEntity assetsTree = AssetsTreeEntity(
  branches: [
    ...[
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
                sensorStatus: SensorStatus.alert,
                sensorType: SensorType.energySensor,
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
    ...[
      LocationEntity(
        id: "123",
        name: "Production Tractian",
        children: [
          SubLocationEntity(id: "0012", name: "Sub Production", parentId: "123"),
          SubLocationEntity(
            id: "002",
            name: "Sub Production2",
            parentId: "123",
            children: [
              SubLocationEntity(
                id: "004",
                name: "Sub Production",
                parentId: "123",
                children: [
                  SubLocationEntity(
                      id: "007", name: "Sub Production", parentId: "123"),
                  SubLocationEntity(
                      id: "001",
                      name: "Sub Production",
                      parentId: "123",
                      children: [
                        SubLocationEntity(
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
      LocationEntity(
        id: "123",
        name: "Production Tractian",
        children: [
          SubLocationEntity(id: "0012", name: "Sub Production", parentId: "123"),
          SubLocationEntity(
            id: "002",
            name: "Sub Production2",
            parentId: "123",
            children: [
              SubLocationEntity(
                id: "004",
                name: "Sub Production",
                parentId: "123",
                children: [
                  SubLocationEntity(
                      id: "007", name: "Sub Production", parentId: "123"),
                  SubLocationEntity(
                      id: "001",
                      name: "Sub Production",
                      parentId: "123",
                      children: [
                        SubLocationEntity(
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
      LocationEntity(
        id: "123",
        name: "Production Tractian",
        children: [
          SubLocationEntity(id: "0012", name: "Sub Production", parentId: "123"),
          SubLocationEntity(
            id: "002",
            name: "Sub Production2",
            parentId: "123",
            children: [
              SubLocationEntity(
                id: "004",
                name: "Sub Production",
                parentId: "123",
                children: [
                  SubLocationEntity(
                      id: "007", name: "Sub Production", parentId: "123"),
                  SubLocationEntity(
                      id: "001",
                      name: "Sub Production",
                      parentId: "123",
                      children: [
                        SubLocationEntity(
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
      LocationEntity(
        id: "123",
        name: "Production Tractian",
        children: [
          SubLocationEntity(id: "0012", name: "Sub Production", parentId: "123"),
          SubLocationEntity(
            id: "002",
            name: "Sub Production2",
            parentId: "123",
            children: [
              SubLocationEntity(
                id: "004",
                name: "Sub Production",
                parentId: "123",
                children: [
                  SubLocationEntity(
                      id: "007", name: "Sub Production", parentId: "123"),
                  SubLocationEntity(
                      id: "001",
                      name: "Sub Production",
                      parentId: "123",
                      children: [
                        SubLocationEntity(
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
