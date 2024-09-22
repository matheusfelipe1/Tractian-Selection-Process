import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:traction_selection_proccess/src/presentation/home/cubit/home_cubit.dart';
import 'package:traction_selection_proccess/src/routes/route_pages.dart';
import 'package:traction_selection_proccess/src/routes/route_paths.dart';
import 'package:traction_selection_proccess/src/core/constants/app_constants.dart';
import 'package:traction_selection_proccess/src/core/injections/dependency_injections.dart';

void main() {
  FlutterError.onError = (details) {
    FlutterError.dumpErrorToConsole(details);
  };
  DependencyInjections.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeCubit>(
          create: (context) => HomeCubit(GetIt.I()),
        ),
      ],
      child: GetMaterialApp(
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
      ),
    );
  }
}
