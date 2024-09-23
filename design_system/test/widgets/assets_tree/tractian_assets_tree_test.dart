import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../mocks/tractian_assets_tree_mock.dart';

void main() {
  testWidgets(
    "Must build assets tree",
    (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TractianAssetsTreeWidget(
              assetsTree: [TractianAssetsTreeMock.get()],
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      final locationIcon = find.byWidgetPredicate((widget) {
        return widget is Icon && widget.icon == TractianIcons.location;
      });

      expect(locationIcon, findsNWidgets(3));

      final cubeIcon = find.byWidgetPredicate((widget) {
        return widget is Icon && widget.icon == TractianIcons.cube;
      });

      expect(cubeIcon, findsNWidgets(4));

      final codepenIcon = find.byWidgetPredicate((widget) {
        return widget is Icon && widget.icon == TractianIcons.codepen;
      });

      expect(codepenIcon, findsNWidgets(8));

      final boltIcon = find.byWidgetPredicate((widget) {
        return widget is Icon && widget.icon == Icons.bolt;
      });

      expect(boltIcon, findsNWidgets(8));
    },
  );
}
