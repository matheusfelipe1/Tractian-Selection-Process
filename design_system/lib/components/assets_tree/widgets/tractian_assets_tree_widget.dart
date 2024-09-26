import 'dart:async';
import 'package:flutter/material.dart';
import 'package:design_system/design_system.dart';

part "../tractian_assets_tree.dart";
part "tractian_assets_tree_item_widget.dart";
part 'tractian_list_view_children_widget.dart';
part "tractian_assets_tree_header_widget.dart";
part '../designs/tractian_vertical_line_paint.dart';
part '../designs/tractian_horizontal_line_paint.dart';

class TractianAssetsTreeWidget extends StatefulWidget {
  final bool isLoading;
  final EdgeInsets padding;
  final Function(dynamic)? onTap;
  final List<TractianAssetsTree> assetsTree;
  const TractianAssetsTreeWidget({
    super.key,
    this.onTap,
    this.isLoading = false,
    required this.assetsTree,
    this.padding = EdgeInsets.zero,
  });

  @override
  State<TractianAssetsTreeWidget> createState() => _TractianAssetsTreeWidgetState();
}

class _TractianAssetsTreeWidgetState extends State<TractianAssetsTreeWidget> {
  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: ListView.builder(
        shrinkWrap: true,
        padding: widget.padding,
        addRepaintBoundaries: true,
        itemCount: widget.assetsTree.length,
        itemBuilder: (context, index) {
          final item = widget.assetsTree.elementAt(index);
          return _TractianAssetsTreeItemWidget(
            item: item,
            onTap: widget.onTap,
            isLoading: widget.isLoading,
          );
        },
      ),
    );
  }


}
