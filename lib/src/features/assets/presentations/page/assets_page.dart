import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:traction_selection_proccess/src/core/utils/tractian_localizations.dart';

class AssetsPage extends StatefulWidget {
  const AssetsPage({super.key});

  @override
  State<AssetsPage> createState() => _AssetsPageState();
}

class _AssetsPageState extends State<AssetsPage> {
  final TextEditingController controller = TextEditingController();
  bool isActive = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TractianColors.whiteBrand,
      appBar: TractianAppbar(
        appbarSettings: AppbarSettings(
          onTapLeading: Get.back,
          leadingIcon: Icons.navigate_before,
          title: tractianLocalizations.assets,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TractianTextField(
              controller: controller,
              hintText: tractianLocalizations.searchField,
              onChanged: (value) {},
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                FittedBox(
                  child: TractianToggleButton(
                    settings: TractianToggleButtonsSettings(
                      title: tractianLocalizations.powerSensor,
                      icon: TractianIcons.lightning,
                      isActive: isActive,
                      onTapActive: () {
                        setState(() {
                          isActive = true;
                        });
                      },
                      onTapInactive: () {
                        setState(() {
                          isActive = false;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                FittedBox(
                  child: TractianToggleButton(
                    settings: TractianToggleButtonsSettings(
                      title: tractianLocalizations.critical,
                      icon: TractianIcons.warninig,
                      isActive: isActive,
                      onTapActive: () {
                        setState(() {
                          isActive = true;
                        });
                      },
                      onTapInactive: () {
                        setState(() {
                          isActive = false;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
