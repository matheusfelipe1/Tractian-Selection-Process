import 'package:get/route_manager.dart';
import 'package:traction_selection_proccess/src/features/splash_screen/presentations/pages/splash_screen.dart';
import 'package:traction_selection_proccess/src/routes/route_paths.dart';

final class RoutePages {
  static List<GetPage> get pages {
    return [
      GetPage(
        name: RoutePaths.splash,
        page: () => const SplashScreen(),
      ),
    ];
  }
}