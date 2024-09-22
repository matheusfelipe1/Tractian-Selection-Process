import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:traction_selection_proccess/src/routes/route_pages.dart';
import 'package:traction_selection_proccess/src/routes/route_paths.dart';
import 'package:traction_selection_proccess/src/core/constants/app_constants.dart';

void main() {
  FlutterError.onError = (details) {
    FlutterError.dumpErrorToConsole(details);
  };
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: RoutePages.pages,
      title: AppConstants.appName,
      initialRoute: RoutePaths.splash,
      theme: ThemeData(useMaterial3: true),
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(context).copyWith(
          viewPadding: EdgeInsets.zero,
          textScaler: const TextScaler.linear(1.0),
        ),
        child: Material(child: child),
      ),
    );
  }
}