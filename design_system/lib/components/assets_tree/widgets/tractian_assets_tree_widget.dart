import 'package:flutter/material.dart';
import 'package:design_system/design_system.dart';

part "../tractian_assets_tree.dart";
part "tractian_assets_tree_item_widget.dart";
part 'tractian_list_view_children_widget.dart';
part "tractian_assets_tree_header_widget.dart";
part '../designs/tractian_vertical_line_paint.dart';
part '../designs/tractian_horizontal_line_paint.dart';

class TractianAssetsTreeWidget extends StatelessWidget {
  final bool isLoading;
  final List<TractianAssetsTree> assetsTree;
  const TractianAssetsTreeWidget({
    super.key,
    this.isLoading = false,
    required this.assetsTree,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemCount: assetsTree.length,
      itemBuilder: (context, index) {
        final item = assetsTree.elementAt(index);
        return _TractianAssetsTreeItemWidget(
          item: item,
          isLoading: isLoading,
        );
      },
    );
  }
}
