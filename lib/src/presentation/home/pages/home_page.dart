import 'package:flutter/material.dart';
import 'package:design_system/design_system.dart';
import 'package:traction_selection_proccess/src/core/constants/app_constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:traction_selection_proccess/src/presentation/home/cubit/home_cubit.dart';
import 'package:traction_selection_proccess/src/presentation/home/cubit/home_state.dart';

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
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              // child: ,
            ),
          );
        }
      ),
    );
  }
}
