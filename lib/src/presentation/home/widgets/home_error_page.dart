part of '../pages/home_page.dart';

class _HomeErrorPage extends StatelessWidget {
  const _HomeErrorPage();

  @override
  Widget build(BuildContext context) {
    final homeCubit = context.read<HomeCubit>();
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
            onPressed: homeCubit.onRefresh,
            label: tractianLocalizations.tryAgain,
          )
        ],
      ),
    );
  }
}
