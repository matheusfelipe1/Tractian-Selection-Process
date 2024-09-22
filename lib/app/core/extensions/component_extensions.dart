import 'package:design_system/components/assets_tree/widgets/tractian_assets_tree_widget.dart';
import 'package:traction_selection_proccess/app/domain/tree/entities/component_asset.dart';

extension ComponentExtensions on List<ComponentAsset> {

  List<TractianAssetsTree> toDSData() {
    return map((e) => e.toDSData()).toList();
  }
}