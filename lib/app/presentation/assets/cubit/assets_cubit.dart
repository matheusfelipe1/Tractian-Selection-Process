import 'dart:async';
import 'package:get/get.dart';
import 'package:design_system/design_system.dart';
import 'package:traction_selection_proccess/app/core/utils/base_cubit.dart';
import 'package:traction_selection_proccess/app/core/extensions/location_extension.dart';
import 'package:traction_selection_proccess/app/domain/locations/entities/location.dart';
import 'package:traction_selection_proccess/app/core/extensions/tree_branches_extension.dart';
import 'package:traction_selection_proccess/app/presentation/assets/cubit/assets_states.dart';
import 'package:traction_selection_proccess/app/domain/assets_tree/entities/tree_assets.dart';
import 'package:traction_selection_proccess/app/domain/locations/use_cases/get_location_use_case.dart';
import 'package:traction_selection_proccess/app/domain/assets_tree/use_case/get_tree_asset_use_case.dart';

class AssetsCubit extends BaseCubit<AssetsState> {
  final GetLocationUseCase _getLocationUseCase;
  final GetAssetsTreeUseCase _getAssetsTreeUseCase;

  AssetsCubit(
    this._getLocationUseCase,
    this._getAssetsTreeUseCase,
  ) : super(AssetsInitial());

  late final AssetsArgs _args;

  Completer<List<Location>> completer = Completer();

  AssetsTree _assetsTree = AssetsTree(branches: []);

  @override
  void onInit() {
    _args = Get.arguments as AssetsArgs;
    _getData();
  }

  Future<void> _getData() async {
    await Future.wait([
      _getLocations(),
      _getAssetsTree(),
    ]);
  }

  Future<void> onRefresh() async => await _getData();

  Future<void> _getLocations() async {
    emit(AssetsLoading());
    completer = Completer();

    final result = await _getLocationUseCase(
      LocationParams(idCompany: _args.companyId),
    );

    result.proccessResult(
      onFailure: (error) => emit(AssetsError()),
      onSuccess: (data) => completer.complete(data),
    );
  }

  Future<void> _getAssetsTree() async {
    emit(AssetsLoading());
    final result = await _getAssetsTreeUseCase(_args.companyId);

    result.proccessResult(
      onSuccess: _onSuccessAssetsTree,
      onFailure: (error) => emit(AssetsError()),
    );
  }

  Future<void> _onSuccessAssetsTree(AssetsTree data) async {
    final locations = await completer.future;
    _assetsTree = AssetsTree(
      branches: [
        ...data.branches.componentsUnliked,
        ...locations.insertData(
          assets: data.branches.assets,
          components: data.branches.componentsWLocation,
        )
      ],
    );
    final items = _assetsTree.branches.toDSEntity();
    items.sort((a, b) => b.type == TractianAssetType.location ? 1 : -1);
    emit(AssetsLoaded(assets: items));
  }

  void toggleTree(String id) {
    _assetsTree = AssetsTree(
      branches: _deepSearchToExpandes(id, _assetsTree.branches),
    );

    final itemsDSData = _assetsTree.branches.toDSEntity();

    itemsDSData.sort((a, b) => b.type == TractianAssetType.location ? 1 : -1);

    emit(AssetsLoaded(assets: itemsDSData));
  }

  List<TreeBranches> _deepSearchToExpandes(String id, List<TreeBranches> branches) {
    final List<TreeBranches> assetsTree = [];

    for (var element in branches) {
      if (element.children.isNotEmpty) {
        element = element.copyWith(
          children: _deepSearchToExpandes(id, element.children),
        );
      }

      if (element.id == id) {
        element = element.copyWith(isOpen: !element.isOpen);
      }

      assetsTree.add(element);
    }

    return assetsTree;
  }
}

class AssetsArgs {
  final String companyId;

  AssetsArgs({required this.companyId});
}
