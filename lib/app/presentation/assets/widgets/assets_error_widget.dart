part of '../page/assets_page.dart';

class AssetsErrorWidget extends StatelessWidget {
  const AssetsErrorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final assetsCubit = context.read<AssetsCubit>();
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Icon(
              TractianIcons.warninig,
              size: 90,
              color: TractianColors.red50,
            ),
          ),
          const SizedBox(height: 32),
          Text(
            tractianLocalizations.somethingWrong,
            style: mediumLg
                .customColor(TractianColors.bodyText2)
                .copyWith(fontSize: 28),
          ),
          const SizedBox(height: 16),
          Text(
            tractianLocalizations.companiesDataError,
            textAlign: TextAlign.center,
            style: mediumLg.customColor(TractianColors.bodyText2),
          ),
          const SizedBox(height: 32),
          TractianButtonWidget(
            onPressed: assetsCubit.onRefresh,
            label: tractianLocalizations.tryAgain,
          )
        ],
      ),
    );
  }
}