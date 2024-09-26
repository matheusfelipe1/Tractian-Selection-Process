import 'package:design_system/components/assets_tree/widgets/tractian_assets_tree_widget.dart';
import 'package:traction_selection_process/app/domain/assets_tree/entities/assets_component_entity.dart';

extension ComponentExtensions on List<AssetsComponentEntity> {
  List<TractianAssetsTree> toDSEntity() {
    return map((e) => e.toDSEntity()).toList();
  }
}
