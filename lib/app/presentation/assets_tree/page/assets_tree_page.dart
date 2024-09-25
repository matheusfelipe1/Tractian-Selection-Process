import 'package:get_it/get_it.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:design_system/design_system.dart';
import 'package:traction_selection_proccess/app/core/utils/tractian_localizations.dart';
import 'package:traction_selection_proccess/app/core/extensions/tree_branches_extension.dart';
import 'package:traction_selection_proccess/app/presentation/assets_tree/cubit/assets_tree_cubit.dart';
import 'package:traction_selection_proccess/app/presentation/assets_tree/cubit/assets_tree_states.dart';

part "../widgets/assets_tree_error_widget.dart";

class AssetsTreePage extends StatefulWidget {
  const AssetsTreePage({super.key});

  @override
  State<AssetsTreePage> createState() => _AssetsTreePageState();
}

class _AssetsTreePageState extends State<AssetsTreePage> {
  final TextEditingController controller = TextEditingController();
  late final AssetsTreeCubit cubitController;

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
    cubitController.onDispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => cubitController = AssetsTreeCubit(
        getLocationUseCase: GetIt.I(),
        getAssetsTreeUseCase: GetIt.I(),
        buildAssetsTreeUseCase: GetIt.I(),
        filterEnergySensorUseCase: GetIt.I(),
        filterCriticalAlertUseCase: GetIt.I(),
        filterByTextAssetsTreeUseCase: GetIt.I(),
        expandsChildrenWhenClickedUseCase: GetIt.I(),
        preProccessingAssetsTreeCanBeFilteredUseCase: GetIt.I(),
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
        body: BlocBuilder<AssetsTreeCubit, AssetsTreeState>(
            builder: (context, state) {
          final AssetsTreeCubit cubit = context.read<AssetsTreeCubit>();
          if (state is AssetsTreeError) {
            return const AssetsTreeErrorWidget();
          }
          return RefreshIndicator.adaptive(
            onRefresh: cubit.onRefresh,
            color: TractianColors.blue50,
            child: Column(
              children: [
                if (state is AssetsTreeLoaded && state.isProcessingData)
                const LinearProgressIndicator(
                  color: TractianColors.blue50,
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TractianTextFieldWidget(
                    controller: controller,
                    onChanged: cubit.onFiltering,
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
                            onTap: cubit.toggleEnergySensor,
                            title: tractianLocalizations.powerSensor,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      FittedBox(
                        child: TractianToggleButtonWidget(
                          settings: TractianToggleButtons(
                            isActive: state.critical,
                            icon: TractianIcons.warninig,
                            onTap: cubit.toggleAlertCritical,
                            title: tractianLocalizations.critical,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                if (state is AssetsTreeLoaded)
                  Flexible(
                    child: TractianAssetsTreeWidget(
                      onTap: (id) => cubit.toggleTree(id),
                      assetsTree: state.assetsTree.branches.toDSEntity(),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                    ),
                  ),
                if (state is AssetsTreeLoading)
                  Flexible(
                    child: TractianAssetsTreeWidget(
                      isLoading: true,
                      assetsTree: state.assets,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                    ),
                  )
              ],
            ),
          );
        }),
      ),
    );
  }
}
