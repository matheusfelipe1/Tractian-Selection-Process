import 'package:design_system/design_system.dart';
import 'package:traction_selection_proccess/app/core/extensions/assets_extension.dart';
import 'package:traction_selection_proccess/app/core/extensions/sub_location_extension.dart';
import 'package:traction_selection_proccess/app/domain/assets_tree/entities/assets.dart';
import 'package:traction_selection_proccess/app/domain/locations/entities/location.dart';
import 'package:traction_selection_proccess/app/core/extensions/component_extensions.dart';
import 'package:traction_selection_proccess/app/domain/assets_tree/entities/component_asset.dart';
import 'package:traction_selection_proccess/app/domain/locations/entities/sub_location.dart';


extension LocationExtensions on List<Location> {
  List<Location> insertData({
    required List<Assets> assets,
    required List<ComponentAsset> components,
  }) {
    final locations = <Location>[];

    for (var location in this) {

      final assetFiltered = assets.filterByLocationId(location.id);
      final componentFiltered = components.filterByLocationId(location.id);

      // for (var i = 0; i < location.children.length; i++) {
      //   final child = location.children[i];

      //   final assetFiltered = assets.filterByLocationId(child.id);
      //   final componentFiltered = components.filterByLocationId(child.id);
      //   location.children[i] = location.children[i].copyWith(
      //     children: [
      //       ...assetFiltered,
      //       ...componentFiltered,
      //       ...location.children[i].children,
      //     ],
      //   );
      // }
      for (var i = 0; i < location.children.length; i++) {
        final children = location.children.whereType<SubLocation>();

        location.children[i] = location.children[i].copyWith(
          children: children.insertData(assets: assets, components: components)
        );
      }

      locations.add(
        location.copyWith(
          children: [
            ...assetFiltered,
            ...componentFiltered,
            ...location.children,
          ],
        ),
      );
    }
    return locations;
  }

  List<TractianAssetsTree> toDSEntity() {
    return map((e) => e.toDSEntity()).toList();
  }
}
