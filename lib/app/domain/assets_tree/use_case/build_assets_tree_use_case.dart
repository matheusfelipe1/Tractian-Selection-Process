import 'dart:isolate';
import 'package:traction_selection_process/app/core/use_cases/use_cases.dart';
import 'package:traction_selection_process/app/domain/locations/entities/location_entity.dart';
import 'package:traction_selection_process/app/domain/assets_tree/entities/assets_entity.dart';
import 'package:traction_selection_process/app/domain/locations/entities/sub_location_entity.dart';
import 'package:traction_selection_process/app/domain/assets_tree/entities/assets_tree_entity.dart';
import 'package:traction_selection_process/app/domain/assets_tree/entities/assets_component_entity.dart';

class BuildAssetsTreeUseCase extends UseCases<Stream<AssetsTreeEntity?>, AssetsTreeEntity> {
  @override
  Stream<AssetsTreeEntity?> call(AssetsTreeEntity params) async* {
    final receivePort = ReceivePort();
    await Isolate.spawn(_isolateTask, [receivePort.sendPort, params.branches]);

    await for (var location in receivePort) {
      yield location == null ? null : AssetsTreeEntity(branches: [location]);
    }

    Isolate.exit();
  }

  void _isolateTask(List<dynamic> args) {
    final [sendPort, branches] = args;

    for (var data in _buildMainLevelAssetsTree(branches)) {
      sendPort.send(data);
    }

    sendPort.send(null);
  }

  Iterable<LocationEntity> _buildMainLevelAssetsTree(
    List<TreeBranches> branches,
  ) sync* {
    final assets = branches.whereType<AssetsEntity>().toList();
    final locations = branches.whereType<LocationEntity>().toList();
    final components = branches.whereType<AssetsComponentEntity>().toList();

    for (var location in locations) {
      final assetsInLocation = assets.where(
        (assets) => assets.locationId == location.id,
      );

      final componentsInLocation = components.where(
        (component) => component.locationId == location.id,
      );

      final assetsNotInLocation = assets.where(
        (assets) => assets.locationId != location.id,
      );

      final componentsNotInLocation = components.where(
        (component) => component.locationId != location.id,
      );

      if (componentsNotInLocation.isEmpty && assetsNotInLocation.isEmpty) {
        yield location;
        continue;
      }

      yield location.copyWith(
        children: [
          ...assetsInLocation,
          ...componentsInLocation,
          ..._buildSecondaryLevelsAssetsTree([
            ...location.children,
            ...assetsNotInLocation,
            ...componentsNotInLocation,
          ])
        ],
      );
    }
  }

  Iterable<SubLocationEntity> _buildSecondaryLevelsAssetsTree(
    List<TreeBranches> branches,
  ) sync* {
    final assets = branches.whereType<AssetsEntity>().toList();
    final subLocations = branches.whereType<SubLocationEntity>().toList();
    final components = branches.whereType<AssetsComponentEntity>().toList();

    for (var subLocation in subLocations) {
      final assetsInLocation = assets.where(
        (assets) => assets.locationId == subLocation.id,
      );

      final componentsInLocation = components.where(
        (component) => component.locationId == subLocation.id,
      );

      final assetsNotInLocation = assets.where(
        (assets) => assets.locationId != subLocation.id,
      );

      final componentsNotInLocation = components.where(
        (component) => component.locationId != subLocation.id,
      );

      if (componentsNotInLocation.isEmpty && assetsNotInLocation.isEmpty) {
        yield subLocation;
        continue;
      }

      yield subLocation.copyWith(
        children: [
          ...assetsInLocation,
          ...componentsInLocation,
          ..._buildSecondaryLevelsAssetsTree([
            ...subLocation.children,
            ...assetsNotInLocation,
            ...componentsNotInLocation,
          ]),
        ],
      );
    }
  }
}
