import 'package:flutter/material.dart';
import 'package:design_system/design_system.dart';

part 'tractian_vertical_line.dart';
part 'tractian_horizontal_line.dart';
part 'tractian_list_view_children.dart';
part "tractian_assets_tree_header.dart";

class TractianAssetsTree extends StatelessWidget {
  final TractianAssetsTreeDSEntity assetsTreeDSEntity;
  const TractianAssetsTree({
    super.key,
    required this.assetsTreeDSEntity,
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
            _TractianAssetsTreeHeader(assetsTreeDSEntity: assetsTreeDSEntity),
            const SizedBox(height: 4),
            _TractianListViewChildren(assetsTreeDSEntity: assetsTreeDSEntity),
            
          ],
        ),
      ),
    );
  }

  _TractianHorizontalLine? _getPainter() {
    return assetsTreeDSEntity.isComponent ? _TractianHorizontalLine() : null;
  }

  EdgeInsets _getPadding() {
    return EdgeInsets.only(
      top: 8,
      left: assetsTreeDSEntity.isComponent ? 16 : 0,
    );
  }
}
