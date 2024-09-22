import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(
    "Create an appbar correctly",
    () {
      testWidgets(
        "Must show generic child widget",
        (tester) async {
          await tester.pumpWidget(
            MaterialApp(
              home: Scaffold(
                appBar: TractianAppbar(
                  appbarSettings: AppbarSettings(
                    child: Image.asset(
                      TractianImages.logo,
                      package: "design_system",
                    ),
                  ),
                ),
              ),
            ),
          );

          await tester.pumpAndSettle();

          expect(find.byType(TractianAppbar), findsOneWidget);
          expect(find.byType(Image), findsOneWidget);
        },
      );

      testWidgets(
        "Must show a title string",
        (tester) async {
          await tester.pumpWidget(
            const MaterialApp(
              home: Scaffold(
                appBar: TractianAppbar(
                  appbarSettings: AppbarSettings(
                    title: "Tractian",
                  ),
                ),
              ),
            ),
          );

          await tester.pumpAndSettle();

          expect(find.byType(TractianAppbar), findsOneWidget);
          expect(find.text("Tractian"), findsOneWidget);
        },
      );

      testWidgets(
        "Must show assertion error",
        (tester) async {
          expect(
            () => tester.pumpWidget(
              MaterialApp(
                home: Scaffold(
                  appBar: TractianAppbar(
                    appbarSettings: AppbarSettings(), 
                  ),
                ),
              ),
            ),
            throwsAssertionError,
          );

          expect(
            () => tester.pumpWidget(
              MaterialApp(
                home: Scaffold(
                  appBar: TractianAppbar(
                    appbarSettings: AppbarSettings(
                      title: "Tractian",
                      child: Image.asset(
                        TractianImages.logo,
                        package: "design_system",
                      ),
                    ), 
                  ),
                ),
              ),
            ),
            throwsAssertionError,
          );
        },
      );
    },
  );
}
