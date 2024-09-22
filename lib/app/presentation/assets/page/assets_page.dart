import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:design_system/design_system.dart';
import 'package:traction_selection_proccess/app/core/utils/tractian_localizations.dart';
import 'package:traction_selection_proccess/app/presentation/assets/cubit/assets_cubit.dart';
import 'package:traction_selection_proccess/app/presentation/assets/cubit/assets_states.dart';

part "../widgets/assets_error_widget.dart";

class AssetsPage extends StatefulWidget {
  const AssetsPage({super.key});

  @override
  State<AssetsPage> createState() => _AssetsPageState();
}

class _AssetsPageState extends State<AssetsPage> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TractianColors.whiteBrand,
      appBar: TractianAppbarWidget(
        appbarSettings: TractianAppbar(
          onTapLeading: Get.back,
          leadingIcon: Icons.navigate_before,
          title: tractianLocalizations.assets,
        ),
      ),
      body: BlocBuilder<AssetsCubit, AssetsState>(builder: (context, state) {
        if (state is AssetsError) {
          return const AssetsErrorWidget();
        }
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TractianTextFieldWidget(
                controller: controller,
                hintText: tractianLocalizations.searchField,
                onChanged: (value) {},
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  FittedBox(
                    child: TractianToggleButtonWidget(
                      settings: TractianToggleButtons(
                        isActive: false,
                        onTapActive: () {},
                        onTapInactive: () {},
                        icon: TractianIcons.lightning,
                        title: tractianLocalizations.powerSensor,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  FittedBox(
                    child: TractianToggleButtonWidget(
                      settings: TractianToggleButtons(
                        isActive: false,
                        onTapActive: () {},
                        onTapInactive: () {},
                        icon: TractianIcons.warninig,
                        title: tractianLocalizations.critical,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              if (state is AssetsLoaded)
                Flexible(
                  child: TractianAssetsTreeWidget(assetsTree: state.assets),
                ),
              if (state is AssetsLoading)
                Flexible(
                  child: TractianAssetsTreeWidget(
                    isLoading: true,
                    assetsTree: state.assets,
                  ),
                )
            ],
          ),
        );
      }),
    );
  }
}
