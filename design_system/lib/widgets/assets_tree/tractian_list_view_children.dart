part of 'tractian_assets_tree.dart';

class _TractianListViewChildren extends StatelessWidget {
  final TractianAssetsTreeDSEntity assetsTreeDSEntity;

  const _TractianListViewChildren({
    required this.assetsTreeDSEntity,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _TractianVerticalLine(),
      child: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          itemCount: assetsTreeDSEntity.children.length,
          itemBuilder: (context, index) {
            final item = assetsTreeDSEntity.children.elementAt(index);
            return TractianAssetsTree(assetsTreeDSEntity: item);
          },
        ),
      ),
    );
  }
}
