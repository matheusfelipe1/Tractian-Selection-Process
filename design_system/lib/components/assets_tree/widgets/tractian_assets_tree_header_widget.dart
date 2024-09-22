part of 'tractian_assets_tree_widget.dart';

class _TractianAssetsTreeHeaderWidget extends StatelessWidget {
  final TractianAssetsTree assetsTree;

  const _TractianAssetsTreeHeaderWidget({required this.assetsTree});

  @override
  Widget build(BuildContext context) {
    final expansionIcon =
        assetsTree.isOpen ? Icons.expand_less : Icons.expand_more;

    return Row(
      children: [
        Visibility(
          visible: !assetsTree.isComponent,
          child: Icon(
            size: 16,
            expansionIcon,
            color: TractianColors.bodyText2,
          ),
        ),
        const SizedBox(width: 8),
        Icon(
          size: 22,
          assetsTree.getIcon(),
          color: TractianColors.blue50,
        ),
        const SizedBox(width: 4),
        Text(
          assetsTree.name,
          style: regularSm.defaultStyle(),
        ),
        const SizedBox(width: 8),
        Visibility(
          visible: assetsTree.isComponent,
          child: _getStatusIcon(),
        )
      ],
    );
  }

  Widget _getStatusIcon() {
    return assetsTree.isCritical
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
