import 'package:flutter_test/flutter_test.dart';
import 'package:traction_selection_process/app/domain/assets_tree/entities/assets_entity.dart';
import 'package:traction_selection_process/app/domain/assets_tree/entities/assets_tree_entity.dart';
import 'package:traction_selection_process/app/data/assets_tree/mappers/assets_tree_mapper.dart';

void main() {
  test(
    "Must return list of TreeBranches",
    () {
      final result = AssetsTreeMappers.fromDataList(_mockGeneralAssetsJSON);
      expect(result, isA<List<TreeBranches>>());
      expect(result.length, equals(4));

      for (var element in result) {
        if (element is AssetsEntity) {
          final assertion = element.children.cast().every(
                (item) => item.parentId == element.id,
              );
          expect(assertion, equals(true));
        }
      }
    },
  );
}

const _mockGeneralAssetsJSON = [
  {
    "id": "656a07bbf2d4a1001e2144c2",
    "locationId": "656a07b3f2d4a1001e2144bf",
    "name": "CONVEYOR BELT ASSEMBLY",
    "parentId": null,
    "sensorType": null,
    "status": null
  },
  {
    "gatewayId": "QHI640",
    "id": "656734821f4664001f296973",
    "locationId": null,
    "name": "Fan - External",
    "parentId": null,
    "sensorId": "MTC052",
    "sensorType": "energy",
    "status": "operating"
  },
  {
    "id": "656734448eb037001e474a62",
    "locationId": "656733b1664c41001e91d9ed",
    "name": "Fan H12D",
    "parentId": null,
    "sensorType": null,
    "status": null
  },
  {
    "gatewayId": "FRH546",
    "id": "656a07cdc50ec9001e84167b",
    "locationId": null,
    "name": "MOTOR RT COAL AF01",
    "parentId": "656a07c3f2d4a1001e2144c5",
    "sensorId": "FIJ309",
    "sensorType": "vibration",
    "status": "operating"
  },
  {
    "id": "656a07c3f2d4a1001e2144c5",
    "locationId": null,
    "name": "MOTOR TC01 COAL UNLOADING AF02",
    "parentId": "656a07bbf2d4a1001e2144c2",
    "sensorType": null,
    "status": null
  },
  {
    "id": "656a07c3f2d4a1001e2144c500",
    "locationId": null,
    "name": "MOTOR TC01 COAL UNLOADING AF02",
    "parentId": "656a07c3f2d4a1001e2144c5",
    "sensorType": null,
    "status": null
  },
  {
    "gatewayId": "QBK282",
    "id": "6567340c1f4664001f29622e",
    "locationId": null,
    "name": "Motor H12D- Stage 1",
    "parentId": "656734968eb037001e474d5a",
    "sensorId": "CFX848",
    "sensorType": "vibration",
    "status": "alert"
  },
  {
    "gatewayId": "VHS387",
    "id": "6567340c664c41001e91dceb",
    "locationId": null,
    "name": "Motor H12D-Stage 2",
    "parentId": "656734968eb037001e474d5a",
    "sensorId": "GYB119",
    "sensorType": "vibration",
    "status": "alert"
  },
  {
    "gatewayId": "VZO694",
    "id": "656733921f4664001f295e9b",
    "locationId": null,
    "name": "Motor H12D-Stage 3",
    "parentId": "656734968eb037001e474d5a",
    "sensorId": "SIF016",
    "sensorType": "vibration",
    "status": "alert"
  },
  {
    "id": "656734968eb037001e474d5a",
    "locationId": "656733b1664c41001e91d9ed",
    "name": "Motors H12D",
    "parentId": null,
    "sensorType": null,
    "status": null
  }
];
