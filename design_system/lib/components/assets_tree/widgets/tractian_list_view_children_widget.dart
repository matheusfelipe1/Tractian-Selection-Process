part of 'tractian_assets_tree_widget.dart';

class _TractianListViewChildrenWidget extends StatelessWidget {
  final TractianAssetsTree assetsTree;

  const _TractianListViewChildrenWidget({
    required this.assetsTree,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _TractianVerticalLinePaint(),
      child: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          itemCount: assetsTree.children.length,
          itemBuilder: (context, index) {
            final item = assetsTree.children.elementAt(index);
            return TractianAssetsTreeWidget(assetsTree: item);
          },
        ),
      ),
    );
  }
}
