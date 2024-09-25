import 'dart:isolate';
import 'package:traction_selection_proccess/app/core/use_cases/use_cases.dart';
import 'package:traction_selection_proccess/app/domain/locations/entities/location.dart';
import 'package:traction_selection_proccess/app/domain/assets_tree/entities/assets.dart';
import 'package:traction_selection_proccess/app/domain/locations/entities/sub_location.dart';
import 'package:traction_selection_proccess/app/domain/assets_tree/entities/tree_assets.dart';
import 'package:traction_selection_proccess/app/domain/assets_tree/entities/assets_component.dart';

class BuildAssetsTreeUseCase extends UseCases<Stream<AssetsTree?>, AssetsTree> {
  @override
  Stream<AssetsTree?> call(AssetsTree params) async* {
    final receivePort = ReceivePort();
    await Isolate.spawn(_isolateTask, [receivePort.sendPort, params.branches]);

    await for (var location in receivePort) {
      
      yield location == null ? null : AssetsTree(branches: [location]);
    }

    Isolate.exit();
  }

  void _isolateTask(List<dynamic> args) {
    final [sendPort, branches] = args;

    for (var data in _buildLocation(branches)) {
      sendPort.send(data);
    }

    sendPort.send(null);
  }

  Iterable<Location> _buildLocation(
    List<TreeBranches> branches,
  ) sync* {
    final assets = branches.whereType<Assets>().toList();
    final locations = branches.whereType<Location>().toList();
    final components = branches.whereType<AssetsComponent>().toList();

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
          ..._buildSubLocation([
            ...location.children,
            ...assetsNotInLocation,
            ...componentsNotInLocation,
          ])
        ],
      );
    }
  }

  Iterable<SubLocation> _buildSubLocation(
    List<TreeBranches> branches,
  ) sync* {
    final assets = branches.whereType<Assets>().toList();
    final subLocations = branches.whereType<SubLocation>().toList();
    final components = branches.whereType<AssetsComponent>().toList();

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
          ..._buildSubLocation([
            ...subLocation.children,
            ...assetsNotInLocation,
            ...componentsNotInLocation,
          ]),
        ],
      );
    }
  }
}
