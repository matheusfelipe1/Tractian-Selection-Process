import 'package:flutter/material.dart';
import 'package:design_system/design_system.dart';

part "../tractian_assets_tree.dart";
part '../designs/tractian_vertical_line_paint.dart';
part '../designs/tractian_horizontal_line_paint.dart';
part 'tractian_list_view_children_widget.dart';
part "tractian_assets_tree_header_widget.dart";

class TractianAssetsTreeWidget extends StatelessWidget {
  final TractianAssetsTree assetsTree;
  const TractianAssetsTreeWidget({
    super.key,
    required this.assetsTree,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _getPainter(),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: _getPadding(),
        child: Column(
          children: [
            _TractianAssetsTreeHeaderWidget(assetsTree: assetsTree),
            const SizedBox(height: 4),
            _TractianListViewChildrenWidget(assetsTree: assetsTree),
          ],
        ),
      ),
    );
  }

  _TractianHorizontalLinePaint? _getPainter() {
    return assetsTree.isComponent ? _TractianHorizontalLinePaint() : null;
  }

  EdgeInsets _getPadding() {
    return EdgeInsets.only(
      top: 8,
      left: assetsTree.isComponent ? 16 : 0,
    );
  }
}
