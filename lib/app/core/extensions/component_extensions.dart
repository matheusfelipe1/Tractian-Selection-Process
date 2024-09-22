import 'package:design_system/components/assets_tree/widgets/tractian_assets_tree_widget.dart';
import 'package:traction_selection_proccess/app/domain/assets_tree/entities/component_asset.dart';

extension ComponentExtensions on List<ComponentAsset> {
  List<TractianAssetsTree> toDSEntity() {
    return map((e) => e.toDSEntity()).toList();
  }

  List<ComponentAsset> filterByLocationId(String id) =>
      where((component) => component.locationId == id).toList();
}
