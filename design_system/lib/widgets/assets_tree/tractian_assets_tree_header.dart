part of 'tractian_assets_tree.dart';

class _TractianAssetsTreeHeader extends StatelessWidget {
  final TractianAssetsTreeDSEntity assetsTreeDSEntity;

  const _TractianAssetsTreeHeader({required this.assetsTreeDSEntity});

  @override
  Widget build(BuildContext context) {
    final expansionIcon =
        assetsTreeDSEntity.isOpen ? Icons.expand_less : Icons.expand_more;

    return Row(
      children: [
        Visibility(
          visible: !assetsTreeDSEntity.isComponent,
          child: Icon(
            size: 16,
            expansionIcon,
            color: TractianColors.bodyText2,
          ),
        ),
        const SizedBox(width: 8),
        Icon(
          size: 22,
          assetsTreeDSEntity.getIcon(),
          color: TractianColors.blue50,
        ),
        const SizedBox(width: 4),
        Text(
          assetsTreeDSEntity.name,
          style: regularSm.defaultStyle(),
        ),
        const SizedBox(width: 8),
        Visibility(
          visible: assetsTreeDSEntity.isComponent,
          child: _getStatusIcon(),
        )
      ],
    );
  }

  Widget _getStatusIcon() {
    return assetsTreeDSEntity.isCritical
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
