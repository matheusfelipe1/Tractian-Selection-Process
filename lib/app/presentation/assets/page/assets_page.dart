import 'package:get_it/get_it.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:design_system/design_system.dart';
import 'package:traction_selection_process/app/core/utils/tractian_localizations.dart';
import 'package:traction_selection_process/app/core/extensions/tree_branches_extension.dart';
import 'package:traction_selection_process/app/presentation/assets/cubit/assets_cubit.dart';
import 'package:traction_selection_process/app/presentation/assets/cubit/assets_states.dart';

part "../widgets/assets_error_widget.dart";

class AssetsPage extends StatefulWidget {
  const AssetsPage({super.key});

  @override
  State<AssetsPage> createState() => _AssetsPageState();
}

class _AssetsPageState extends State<AssetsPage> {
  final TextEditingController controller = TextEditingController();
  late final AssetsCubit assetsCubit;

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
    assetsCubit.onDispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => assetsCubit = AssetsCubit(
        getLocationUseCase: GetIt.I(),
        getAssetsTreeUseCase: GetIt.I(),
        buildAssetsTreeUseCase: GetIt.I(),
        expandTheChildrenUseCase: GetIt.I(),
        filterEnergySensorUseCase: GetIt.I(),
        filterCriticalAlertUseCase: GetIt.I(),
        filterByTextAssetsTreeUseCase: GetIt.I(),
        cachedDataCanBeFilteredUseCase: GetIt.I(),
      ),
      child: Scaffold(
        backgroundColor: TractianColors.whiteBrand,
        appBar: TractianAppbarWidget(
          appbarSettings: TractianAppbar(
            onTapLeading: Get.back,
            leadingIcon: Icons.navigate_before,
            title: tractianLocalizations.assets,
          ),
        ),
        body: BlocBuilder<AssetsCubit, AssetsState>(builder: (context, state) {
          final crossFadeState = state is AssetsLoading
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst;
          if (state is AssetsError) {
            return const AssetsErrorWidget();
          }
          return RefreshIndicator.adaptive(
            onRefresh: assetsCubit.onRefresh,
            color: TractianColors.blue50,
            child: Column(
              children: [
                if (state.isProcessing)
                  const LinearProgressIndicator(
                    color: TractianColors.blue50,
                  ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TractianTextFieldWidget(
                    controller: controller,
                    onChanged: assetsCubit.onFiltering,
                    hintText: tractianLocalizations.searchField,
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      FittedBox(
                        child: TractianToggleButtonWidget(
                          settings: TractianToggleButtons(
                            isActive: state.energy,
                            icon: TractianIcons.lightning,
                            title: tractianLocalizations.powerSensor,
                            onTap: () => {
                              controller.clear(),
                              assetsCubit.toggleEnergySensor(),
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      FittedBox(
                        child: TractianToggleButtonWidget(
                          settings: TractianToggleButtons(
                            isActive: state.critical,
                            icon: TractianIcons.warninig,
                            title: tractianLocalizations.critical,
                            onTap: () => {
                              controller.clear(),
                              assetsCubit.toggleAlertCritical(),
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Flexible(
                  child: AnimatedCrossFade(
                    crossFadeState: crossFadeState,
                    duration: const Duration(milliseconds: 200),
                    firstChild: TractianAssetsTreeWidget(
                      onTap: assetsCubit.toggleShowChildren,
                      assetsTree: state.assetsTree.branches.toDSEntity(),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                    ),
                    secondChild: TractianAssetsTreeWidget(
                      isLoading: true,
                      assetsTree: state.assetsTree.branches.toDSEntity(),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
