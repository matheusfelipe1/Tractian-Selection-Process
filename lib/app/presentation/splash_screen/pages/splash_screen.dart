import 'package:flutter/material.dart';
import 'package:design_system/design_system.dart';
import 'package:get/get.dart';
import 'package:traction_selection_process/app/core/constants/app_constants.dart';
import 'package:traction_selection_process/app/routes/route_paths.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 3),
      () => Get.toNamed(RoutePaths.home),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TractianColors.blue100,
      body: Center(
        child: Image.asset(
          TractianImages.logo,
          package: AppConstants.designSystemPackageName,
        ),
      ),
    );
  }
}
