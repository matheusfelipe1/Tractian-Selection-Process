import 'package:get/get.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:traction_selection_process/app/routes/route_paths.dart';
import 'package:traction_selection_process/app/core/utils/tractian_localizations.dart';
import 'package:traction_selection_process/app/presentation/assets/page/assets_page.dart';
import 'package:traction_selection_process/app/presentation/assets/cubit/assets_cubit.dart';

import '../../../test/mocks/material_app/mock_material_app.dart';
import '../../../test/mocks/injection/mock_dependency_injection.dart';

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
       
      );
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();

      Get.toNamed(
        RoutePaths.assets,
        arguments: AssetsArgs(companyId: "0"),
      );

      await tester.pumpAndSettle();
      expect(find.byType(AssetsPage), findsOneWidget);

      await tester.pumpAndSettle();

      expect(find.text(tractianLocalizations.powerSensor), findsOneWidget);
      expect(find.text("Energy 2"), findsNothing);

      await tester.tap(find.text(tractianLocalizations.powerSensor));
      await tester.pumpAndSettle();
      expect(find.text("Energy Component"), findsOneWidget);
      expect(find.text("Energy 2"), findsOneWidget);
    },
  );
}
