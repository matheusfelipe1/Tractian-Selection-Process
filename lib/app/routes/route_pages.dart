import 'package:get/route_manager.dart';
import 'package:traction_selection_process/app/routes/route_paths.dart';
import 'package:traction_selection_process/app/presentation/home/pages/home_page.dart';
import 'package:traction_selection_process/app/presentation/assets/page/assets_page.dart';
import 'package:traction_selection_process/app/presentation/splash_screen/pages/splash_screen.dart';

final class RoutePages {
  static List<GetPage> get pages {
    return [
      GetPage(
        name: RoutePaths.splash,
        page: () => const SplashScreen(),
      ),
      GetPage(
        name: RoutePaths.home,
        page: () => const HomePage(),
      ),
      GetPage(
        name: RoutePaths.assets,
        page: () => const AssetsPage(),
      ),
    ];
  }
}
