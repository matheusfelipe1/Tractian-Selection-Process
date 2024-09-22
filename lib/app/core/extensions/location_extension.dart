import 'package:design_system/design_system.dart';
import 'package:traction_selection_proccess/app/domain/tree/entities/assets.dart';
import 'package:traction_selection_proccess/app/domain/locations/entities/location.dart';
import 'package:traction_selection_proccess/app/domain/tree/entities/component_asset.dart';

extension LocationExtensions on List<Location> {
  List<Location> insertData({
    required List<Assets> assets,
    required List<ComponentAsset> components,
  }) {
    final locations = <Location>[];
    for (var location in this) {
      final componentFiltered = components
          .where((component) => component.locationId == location.id)
          .toList();
      final assetFiltered =
          assets.where((asset) => asset.locationId == location.id).toList();

      for (var subLocation in location.children) {
        final assetFiltered = assets
            .where(
              (asset) => asset.locationId == location.id,
            )
            .toList();
        subLocation = subLocation.copyWith(
          children: assetFiltered,
        );
      }

      locations.add(
        location.copyWith(
          children: [
            ...assetFiltered,
            ...location.children,
            ...componentFiltered
          ]
        ),
      );
    }
    return locations;
  }

  List<TractianAssetsTree> toDSData() {
    return map((e) => e.toDSData()).toList();
  }
}
