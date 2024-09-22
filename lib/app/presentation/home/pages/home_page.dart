import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:design_system/design_system.dart';
import 'package:traction_selection_proccess/app/core/constants/app_constants.dart';
import 'package:traction_selection_proccess/app/core/utils/tractian_localizations.dart';
import 'package:traction_selection_proccess/app/presentation/home/cubit/home_cubit.dart';
import 'package:traction_selection_proccess/app/presentation/home/cubit/home_state.dart';
import 'package:traction_selection_proccess/app/domain/company/entity/company.dart';

part '../widgets/home_error_page.dart';
part "../widgets/home_companies_listview.dart";

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TractianColors.whiteBrand,
      appBar: TractianAppbarWidget(
        appbarSettings: TractianAppbar(
          child: Image.asset(
            TractianImages.logo,
            package: AppConstants.designSystemPackageName,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 30,
          horizontal: 22,
        ),
        child: BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
          final homeCubit = context.read<HomeCubit>();
          if (state is HomeLoading) {
            return _HomeCompaniesListview(
              isLoading: true,
              companies: state.companies,
              onRefresh: homeCubit.onRefresh,
            );
          }
          if (state is HomeLoaded) {
            return _HomeCompaniesListview(
              isLoading: false,
              companies: state.companies,
              onRefresh: homeCubit.onRefresh,
              onTap: homeCubit.goToAssetsPage,
            );
          }
          return const _HomeErrorPage();
        }),
      ),
    );
  }
}
