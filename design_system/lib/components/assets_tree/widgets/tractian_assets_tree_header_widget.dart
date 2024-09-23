part of 'tractian_assets_tree_widget.dart';

class _TractianAssetsTreeHeaderWidget extends StatelessWidget {
  final TractianAssetsTree item;

  const _TractianAssetsTreeHeaderWidget({required this.item});

  @override
  Widget build(BuildContext context) {
    final expansionIcon = item.isOpen ? Icons.expand_less : Icons.expand_more;
    final componentIconColorType =
        item.isOnAlert ? TractianColors.red50 : TractianColors.gren50;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
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
        Flexible(
          child: Text(
            item.name,
            style: regularSm.defaultStyle(),
          ),
        ),
        const SizedBox(width: 8),
        Offstage(
          offstage: !item.isEnergySensor,
          child: Icon(
            size: 16,
            Icons.bolt,
            color: componentIconColorType,
          ),
        ),
        Offstage(
          offstage: !item.isVibrationSensor,
          child: Icon(
            size: 8,
            Icons.circle,
            color: componentIconColorType,
          ),
        ),
      ],
    );
  }
}
