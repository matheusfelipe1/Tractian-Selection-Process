import 'package:design_system/components/assets_tree/widgets/tractian_assets_tree_widget.dart';
import 'package:design_system/styles/traction_asset_type.dart';

class SubLocation {
  final String id;
  final String name;
  final String parentId;

  const SubLocation({
    required this.id,
    required this.name,
    required this.parentId,
  });

  TractianAssetsTree toDSData() {
    return TractianAssetsTree(
      name: name,
      isOpen: false,
      type: TractianAssetType.subLocation,
      children: [],
    );
  }
}