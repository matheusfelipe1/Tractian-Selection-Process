import 'package:design_system/components/assets_tree/widgets/tractian_assets_tree_widget.dart';
import 'package:traction_selection_proccess/app/domain/assets_tree/entities/assets_component.dart';

extension ComponentExtensions on List<AssetsComponent> {
  List<TractianAssetsTree> toDSEntity() {
    return map((e) => e.toDSEntity()).toList();
  }
}
