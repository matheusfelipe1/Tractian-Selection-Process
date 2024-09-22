part of "../pages/home_page.dart";

class _HomeCompaniesListview extends StatelessWidget {
  final bool isLoading;
  final VoidCallback? onTap;
  final List<CompanyEntity> companies;
  final Future<void> Function() onRefresh;

  const _HomeCompaniesListview({
    this.onTap,
    required this.onRefresh,
    required this.isLoading,
    required this.companies,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator.adaptive(
      onRefresh: onRefresh,
      color: TractianColors.blue50,
      child: ListView.separated(
        itemCount: companies.length,
        separatorBuilder: (_, __) => const SizedBox(height: 40),
        itemBuilder: (_, index) {
          final company = companies.elementAt(index);
          return TractianCompaniesTileWidget(
            onTap: onTap,
            isLoading: isLoading,
            companyNamel: company.name,
          );
        },
      ),
    );
  }
}
