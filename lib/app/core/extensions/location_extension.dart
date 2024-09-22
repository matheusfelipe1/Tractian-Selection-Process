
import 'package:design_system/design_system.dart';
import 'package:traction_selection_proccess/app/domain/locations/entities/location.dart';

extension LocationExtensions on List<Location> {

  List<TractianAssetsTree> toDSData() {
    return map((e) => e.toDSData()).toList();
  }
  
}