import 'package:traction_selection_proccess/app/core/extensions/assets_extension.dart';
import 'package:traction_selection_proccess/app/core/extensions/component_extensions.dart';
import 'package:traction_selection_proccess/app/domain/assets_tree/entities/assets.dart';
import 'package:traction_selection_proccess/app/domain/assets_tree/entities/component_asset.dart';
import 'package:traction_selection_proccess/app/domain/locations/entities/sub_location.dart';

extension SubLocationExtension on Iterable<SubLocation> {
  List<SubLocation> insertData({
    Iterable<SubLocation>? list,
    required List<Assets> assets,
    required List<ComponentAsset> components,
  }) {
    final subLocations = <SubLocation>[];

    for (var subLocation in list ?? this) {
      for (var i = 0; i < subLocation.children.length; i++) {
        subLocation.children[i] = subLocation.children[i].copyWith(
          children: insertData(
            assets: assets,
            components: components,
            list: subLocation.children.whereType<SubLocation>()
          ),
        );
      }

      final assetFiltered = assets.filterByLocationId(subLocation.id);
      final componentFiltered = components.filterByLocationId(subLocation.id);

      subLocations.add(
        subLocation.copyWith(
          children: [
            ...assetFiltered,
            ...componentFiltered,
            ...subLocation.children,
          ],
        ),
      );
    }
    return subLocations;
  }
}
