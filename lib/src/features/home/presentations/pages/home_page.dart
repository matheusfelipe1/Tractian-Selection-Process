import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:traction_selection_proccess/src/core/constants/app_constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TractianAppbar(
        appbarSettings: AppbarSettings(
          child: Image.asset(
            TractianImages.logo,
            package: AppConstants.designSystemPackageName,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TractianCompaniesTileWidget(onTap: () {}, companyNamel: "JAGUAR"),
        ),
      ),
    );
  }
}
