part of 'tractian_assets_tree_widget.dart';

class _TractianAssetsTreeItemWidget extends StatelessWidget {
  final bool isLoading;
  final TractianAssetsTree item;
  final Function(dynamic)? onTap;
  const _TractianAssetsTreeItemWidget({
    required this.item,
    required this.onTap,
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
              InkWell(
                onTap: item.isComponent ? null : () => onTap?.call(item.id),
                child: _TractianAssetsTreeHeaderWidget(item: item),
              ),
              const SizedBox(height: 4),
              Visibility(
                visible: item.isOpen,
                child: _TractianListViewChildrenWidget(
                  item: item,
                  onTap: onTap,
                  isLoading: isLoading,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _TractianHorizontalLinePaint? _getPainter() {
    return item.isComponent && item.isAssociated
        ? _TractianHorizontalLinePaint()
        : null;
  }

  EdgeInsets _getPadding() {
    return EdgeInsets.only(
      top: 8,
      left: item.isComponent && item.isAssociated ? 16 : 0,
    );
  }
}
