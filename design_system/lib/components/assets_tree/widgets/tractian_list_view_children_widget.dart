part of 'tractian_assets_tree_widget.dart';

class _TractianListViewChildrenWidget extends StatelessWidget {
  final bool isLoading;
  final TractianAssetsTree item;
  final Function(dynamic)? onTap;

  const _TractianListViewChildrenWidget({
    required this.item,
    required this.onTap,
    required this.isLoading,
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
          itemCount: item.children.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final child = item.children.elementAt(index);
            return _TractianAssetsTreeItemWidget(
              item: child,
              onTap: onTap,
              isLoading: isLoading,
            );
          },
        ),
      ),
    );
  }
}
