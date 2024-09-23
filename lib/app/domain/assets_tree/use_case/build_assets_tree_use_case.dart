import 'dart:isolate';
import 'package:traction_selection_proccess/app/core/use_cases/use_cases.dart';
import 'package:traction_selection_proccess/app/core/extensions/assets_extension.dart';
import 'package:traction_selection_proccess/app/domain/locations/entities/location.dart';
import 'package:traction_selection_proccess/app/domain/assets_tree/entities/assets.dart';
import 'package:traction_selection_proccess/app/core/extensions/component_extensions.dart';
import 'package:traction_selection_proccess/app/domain/locations/entities/sub_location.dart';
import 'package:traction_selection_proccess/app/domain/assets_tree/entities/tree_assets.dart';
import 'package:traction_selection_proccess/app/domain/assets_tree/entities/assets_component.dart';

class BuildAssetsTreeUseCase extends UseCases<Stream<AssetsTree>, AssetsTree> {
  @override
  Stream<AssetsTree> call(AssetsTree params) async* {
    final receivePort = ReceivePort();
    await Isolate.spawn(_isolateTask, [receivePort.sendPort, params.branches]);

    await for (var location in receivePort) {
      yield AssetsTree(branches: [location]);
    }

    Isolate.exit();
  }

  static void _isolateTask(List<dynamic> args) {
    final [sendPort, branches] = args;

    for (var data in _buildLocation(branches)) {
      sendPort.send(data);
    }
  }

  static Iterable<Location> _buildLocation(
    List<TreeBranches> branches,
  ) sync* {
    final assets = branches.whereType<Assets>().toList();
    final locations = branches.whereType<Location>().toList();
    final components = branches.whereType<AssetsComponent>().toList();

    locations.sort((a, b) => b.children.length < a.children.length ? 1 : -1);

    for (var location in locations) {
      final assetsFiltered = assets.filterByLocationId(location.id);
      final newAssetsFilter = assets.where(
        (item) => location.id != item.locationId,
      );
      final componentsFiltered = components.filterByLocationId(location.id);
      final newComponentsFilter = components.where(
        (item) => location.id != item.locationId,
      );

      yield location.copyWith(
        children: [
          ...assetsFiltered,
          ...componentsFiltered,
          ..._buildSubLocation([
            ...location.children,
            ...newAssetsFilter,
            ...newComponentsFilter,
          ])
        ],
      );
    }
  }

  static Iterable<SubLocation> _buildSubLocation(
    List<TreeBranches> branches,
  ) sync* {
    final assets = branches.whereType<Assets>().toList();
    final subLocations = branches.whereType<SubLocation>().toList();
    final components = branches.whereType<AssetsComponent>().toList();

    subLocations.sort((a, b) => b.children.length < a.children.length ? 1 : -1);

    for (var subLocation in subLocations) {
      final assetsFiltered = assets.filterByLocationId(subLocation.id);
      final newAssetsFilter = assets.where(
        (item) => subLocation.id != item.locationId,
      );

      final componentsFiltered = components.filterByLocationId(subLocation.id);
      final newComponentsFilter = components.where(
        (item) => subLocation.id != item.locationId,
      );

      yield subLocation.copyWith(
        children: [
          ...assetsFiltered,
          ...componentsFiltered,
          ..._buildSubLocation([
            ...subLocation.children,
            ...newAssetsFilter,
            ...newComponentsFilter,
          ]),
        ],
      );
    }
  }
}
