import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:traction_selection_proccess/app/core/utils/tractian_localizations.dart';
import 'package:traction_selection_proccess/app/presentation/assets_tree/cubit/assets_tree_cubit.dart';
import 'package:traction_selection_proccess/app/presentation/assets_tree/page/assets_tree_page.dart';
import 'package:traction_selection_proccess/app/presentation/home/cubit/home_cubit.dart';
import 'package:traction_selection_proccess/app/routes/route_paths.dart';

import '../../../test/mocks/injection/mock_dependency_injection.dart';
import '../../../test/mocks/material_app/mock_material_app.dart';

void main() {
  setUpAll(() {
    Get.testMode = true;
    TestWidgetsFlutterBinding.ensureInitialized();
    MockDependencyInjection.ensureInitialized();
  });
  testWidgets(
    "Should open and show the path of where it is located when you click on critical",
    (tester) async {
      final widget = MockMaterialApp.getWidget(
        initialRoute: RoutePaths.home,
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
      );
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();

      Get.toNamed(
        RoutePaths.assets,
        arguments: AssetsTreeArgs(companyId: "0"),
      );

      await tester.pumpAndSettle();
      expect(find.byType(AssetsTreePage), findsOneWidget);

      await tester.pumpAndSettle();

      expect(find.text(tractianLocalizations.powerSensor), findsOneWidget);
      expect(find.text("Component critical"), findsNothing);

      await tester.tap(find.text(tractianLocalizations.powerSensor));
      await tester.pumpAndSettle();
      expect(find.text("Energy Component"), findsOneWidget);
    },
  );
}
