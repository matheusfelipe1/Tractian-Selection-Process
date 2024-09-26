import 'package:flutter_test/flutter_test.dart';
import 'package:design_system/design_system.dart';
import 'package:integration_test/integration_test.dart';
import 'package:traction_selection_process/app/routes/route_paths.dart';

import '../../../test/mocks/material_app/mock_material_app.dart';
import '../../../test/mocks/injection/mock_dependency_injection.dart';

void main() {
  setUpAll(() {
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();
    MockDependencyInjection.ensureInitialized();
  });

  testWidgets(
    "Must build the home page with companies data list",
    (tester) async {
      final widget = MockMaterialApp.getWidget(
        initialRoute: RoutePaths.home,
      );
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();
      expect(find.byType(TractianCompaniesTileWidget), findsNWidgets(3));
      expect(find.text("Tractian: Inovação 1"), findsOneWidget);
      expect(find.text("Tractian: Inovação 2"), findsOneWidget);
      expect(find.text("Tractian: Inovação 3"), findsOneWidget);
    },
  );
}
