import 'package:design_system/design_system.dart';
import 'package:traction_selection_proccess/app/core/extensions/assets_extension.dart';
import 'package:traction_selection_proccess/app/domain/assets_tree/entities/assets.dart';
import 'package:traction_selection_proccess/app/domain/locations/entities/location.dart';
import 'package:traction_selection_proccess/app/core/extensions/component_extensions.dart';
import 'package:traction_selection_proccess/app/domain/assets_tree/entities/component_asset.dart';

extension LocationExtensions on List<Location> {
  List<Location> insertData({
    required List<Assets> assets,
    required List<ComponentAsset> components,
  }) {
    final locations = <Location>[];

    for (var location in this) {
      final assetFiltered = assets.filterByLocationId(location.id);
      final componentFiltered = components.filterByLocationId(location.id);

      locations.add(
        location.copyWith(
          children: [
            ...assetFiltered,
            ...componentFiltered,
            ...location.children.where(
              (child) => !assets.any(
                (asset) => asset.locationId == location.id,
              ),
            ),
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
