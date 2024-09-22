import 'package:traction_selection_proccess/app/domain/tree/entities/assets.dart';
import 'package:traction_selection_proccess/app/domain/tree/entities/component_asset.dart';
import 'package:traction_selection_proccess/app/domain/tree/entities/tree_assets.dart';

extension ComponentExtensions on List<TreeBranches> {
  List<ComponentAsset> get componentsUnliked =>
      where((item) => item is ComponentAsset && !item.isAssociated)
          .map((item) => item as ComponentAsset)
          .toList();

  List<ComponentAsset> get componentsWLocation =>
      where((item) => item is ComponentAsset && item.hasLocation)
          .map((item) => item as ComponentAsset)
          .toList();

  List<Assets> get assets =>
      where((item) => item is Assets).map((item) => item as Assets).toList();
}
