import 'package:traction_selection_proccess/app/domain/assets_tree/entities/assets.dart';

extension AssetsExtension on List<Assets> {
  List<Assets> filterByLocationId(String id) =>
      where((asset) => asset.locationId == id).toList();
}
