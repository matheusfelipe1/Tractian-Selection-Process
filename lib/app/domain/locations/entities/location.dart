import 'package:design_system/design_system.dart';
import 'package:traction_selection_proccess/app/domain/locations/entities/sub_location.dart';

class Location {
  final String id;
  final String name;
  final List<SubLocation> subLocations;

  Location({
    required this.id,
    required this.name,
    required this.subLocations,
  });

  TractianAssetsTree toDSData() {
    return TractianAssetsTree(
      name: name,
      isOpen: false,
      type: TractianAssetType.location,
      children: subLocations.map((e) => e.toDSData()).toList(),
    );
  }
}