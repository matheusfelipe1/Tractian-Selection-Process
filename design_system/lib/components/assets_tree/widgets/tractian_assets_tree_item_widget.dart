part of 'tractian_assets_tree_widget.dart';

class _TractianAssetsTreeItemWidget extends StatefulWidget {
  final bool isLoading;
  final TractianAssetsTree item;
  final Function(dynamic)? onTap;
  const _TractianAssetsTreeItemWidget({
    required this.item,
    required this.onTap,
    required this.isLoading,
  });

  @override
  State<_TractianAssetsTreeItemWidget> createState() =>
      _TractianAssetsTreeItemWidgetState();
}

class _TractianAssetsTreeItemWidgetState
    extends State<_TractianAssetsTreeItemWidget> {
  final StreamController<bool> _isVisibleController = StreamController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (mounted) {
        _isVisibleController.add(_isVisible());
      }
    });
  }

  @override
  void didUpdateWidget(covariant _TractianAssetsTreeItemWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.item.isOpen != widget.item.isOpen && mounted) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        _isVisibleController.add(_isVisible());
      });
    }
  }

  @override
  void dispose() {
    _isVisibleController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
        initialData: false,
        stream: _isVisibleController.stream,
        builder: (context, snapshot) {
          return Visibility(
            visible: snapshot.data!,
            child: TractianLoadingShimmerWidget(
              isLoading: widget.isLoading,
              child: CustomPaint(
                painter: _getPainter(),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  padding: _getPadding(),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: widget.item.isComponent
                            ? null
                            : () => widget.onTap?.call(widget.item.id),
                        child:
                            _TractianAssetsTreeHeaderWidget(item: widget.item),
                      ),
                      const SizedBox(height: 4),
                      Visibility(
                        visible: widget.item.isOpen,
                        child: _TractianListViewChildrenWidget(
                          item: widget.item,
                          onTap: widget.onTap,
                          isLoading: widget.isLoading,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  bool _isVisible() {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final position = renderBox.localToGlobal(Offset.zero);
    final size = renderBox.size;
    final screenHeight = MediaQuery.of(context).size.height;
    return position.dy + size.height > 0 && position.dy < screenHeight;
  }

  _TractianHorizontalLinePaint? _getPainter() {
    return widget.item.isComponent && widget.item.isAssociated
        ? _TractianHorizontalLinePaint()
        : null;
  }

  EdgeInsets _getPadding() {
    return EdgeInsets.only(
      top: 8,
      left: widget.item.isComponent && widget.item.isAssociated ? 16 : 0,
    );
  }
}
