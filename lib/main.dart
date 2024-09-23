import 'dart:ui' as ui;
import 'package:get_it/get_it.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/route_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:traction_selection_proccess/app/routes/route_pages.dart';
import 'package:traction_selection_proccess/app/routes/route_paths.dart';
import 'package:traction_selection_proccess/app/core/constants/app_constants.dart';
import 'package:traction_selection_proccess/app/presentation/home/cubit/home_cubit.dart';
import 'package:traction_selection_proccess/app/core/injections/dependency_injections.dart';
import 'package:traction_selection_proccess/app/presentation/assets_tree/cubit/assets_tree_cubit.dart';

void main() async {
  FlutterError.onError = (details) {
    FlutterError.dumpErrorToConsole(details);
  };
  await dotenv.load();
  DependencyInjections.ensureInitialized();
  BackgroundIsolateBinaryMessenger.ensureInitialized(
    ui.RootIsolateToken.instance!,
  );

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
        BlocProvider<AssetsTreeCubit>(
          create: (context) => AssetsTreeCubit(
            GetIt.I(),
            GetIt.I(),
          ),
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
