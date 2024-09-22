part of 'tractian_assets_tree_widget.dart';

class _TractianAssetsTreeHeaderWidget extends StatelessWidget {
  final TractianAssetsTree item;

  const _TractianAssetsTreeHeaderWidget({required this.item});

  @override
  Widget build(BuildContext context) {
    final expansionIcon =
        item.isOpen ? Icons.expand_less : Icons.expand_more;

    return Row(
      children: [
        Visibility(
          visible: !item.isComponent,
          child: Icon(
            size: 16,
            expansionIcon,
            color: TractianColors.bodyText2,
          ),
        ),
        const SizedBox(width: 8),
        Icon(
          size: 22,
          item.getIcon(),
          color: TractianColors.blue50,
        ),
        const SizedBox(width: 4),
        Text(
          item.name,
          style: regularSm.defaultStyle(),
        ),
        const SizedBox(width: 8),
        Visibility(
          visible: item.isComponent,
          child: _getStatusIcon(),
        )
      ],
    );
  }

  Widget _getStatusIcon() {
    return item.isCritical
        ? Icon(
            size: 8,
            TractianIcons.warninig,
            color: TractianColors.red50,
          )
        : const Icon(
            size: 16,
            Icons.bolt,
            color: TractianColors.gren50,
          );
  }
}
