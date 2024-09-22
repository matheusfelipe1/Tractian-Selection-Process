part of 'tractian_assets_tree_widget.dart';

class _TractianAssetsTreeItemWidget extends StatelessWidget {
  final bool isLoading;
  final TractianAssetsTree item;
  const _TractianAssetsTreeItemWidget({
    required this.item,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return TractianLoadingShimmerWidget(
      isLoading: isLoading,
      child: CustomPaint(
        painter: _getPainter(),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: _getPadding(),
          child: Column(
            children: [
              _TractianAssetsTreeHeaderWidget(item: item),
              const SizedBox(height: 4),
              _TractianListViewChildrenWidget(item: item, isLoading: isLoading),
            ],
          ),
        ),
      ),
    );
  }

  _TractianHorizontalLinePaint? _getPainter() {
    return item.isComponent ? _TractianHorizontalLinePaint() : null;
  }

  EdgeInsets _getPadding() {
    return EdgeInsets.only(
      top: 8,
      left: item.isComponent ? 16 : 0,
    );
  }
}
