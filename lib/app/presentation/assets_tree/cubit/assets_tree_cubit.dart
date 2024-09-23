import 'dart:async';
import 'package:get/get.dart';
import 'package:traction_selection_proccess/app/core/utils/base_cubit.dart';
import 'package:traction_selection_proccess/app/core/extensions/location_extension.dart';
import 'package:traction_selection_proccess/app/domain/locations/entities/location.dart';
import 'package:traction_selection_proccess/app/core/extensions/tree_branches_extension.dart';
import 'package:traction_selection_proccess/app/domain/assets_tree/entities/tree_assets.dart';
import 'package:traction_selection_proccess/app/domain/assets_tree/entities/component_asset.dart';
import 'package:traction_selection_proccess/app/domain/locations/use_cases/get_location_use_case.dart';
import 'package:traction_selection_proccess/app/presentation/assets_tree/cubit/assets_tree_states.dart';
import 'package:traction_selection_proccess/app/domain/assets_tree/use_case/get_tree_asset_use_case.dart';

class AssetsTreeCubit extends BaseCubit<AssetsTreeState> {
  final GetLocationUseCase _getLocationUseCase;
  final GetAssetsTreeUseCase _getAssetsTreeUseCase;

  AssetsTreeCubit(
    this._getLocationUseCase,
    this._getAssetsTreeUseCase,
  ) : super(AssetsTreeInitial());

  late final AssetsArgs _args;

  Completer<List<Location>> completer = Completer();

  AssetsTree _assetsTree = const AssetsTree(branches: []);

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
    emit(AssetsTreeLoading());
    completer = Completer();

    final result = await _getLocationUseCase(
      LocationParams(idCompany: _args.companyId),
    );

    result.proccessResult(
      onFailure: (error) => emit(AssetsTreeError()),
      onSuccess: (data) => completer.complete(data),
    );
  }

  Future<void> _getAssetsTree() async {
    emit(AssetsTreeLoading());
    final result = await _getAssetsTreeUseCase(_args.companyId);

    result.proccessResult(
      onSuccess: _onSuccessAssetsTree,
      onFailure: (error) => emit(AssetsTreeError()),
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
    emit(AssetsTreeLoaded(assetsTree: _assetsTree));
  }

  void toggleTree(String id) {
    _assetsTree = AssetsTree(
      branches: _deepSearchToExpandes(id, _assetsTree.branches),
    );

    emit(AssetsTreeLoaded(assetsTree: _assetsTree));
  }

  List<TreeBranches> _deepSearchToExpandes(
    String id,
    List<TreeBranches> branches,
  ) {
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

  void toggleAlertCritical() {
    final newCriticalState = !state.critical;
    final assetsTreeFiltered = newCriticalState
        ? _deepCriticalFilter(_assetsTree.branches)
        : _assetsTree.branches;

    emit(
      state.copyWith(
        energy: false,
        critical: newCriticalState,
        assetsTree: AssetsTree(branches: assetsTreeFiltered),
      ),
    );
  }

  List<TreeBranches> _deepCriticalFilter(
    List<TreeBranches> branches,
  ) {
    final List<TreeBranches> assetsTree = [];

    for (var element in branches) {
      if (element.children.isNotEmpty) {
        element = element.copyWith(
          isOpen: true,
          children: _deepCriticalFilter(element.children),
        );
      }

      if (element is ComponentAsset) {
        if (element.isCritical) {
          assetsTree.add(element);
        }
      }

      if (element.children.isNotEmpty) {
        assetsTree.add(element);
      }
    }

    return assetsTree;
  }

  void toggleEnergySensor() {
    final newEnergySytate = !state.energy;
    final assetsTreeFiltered = newEnergySytate
        ? _deepEnergySensorFilter(_assetsTree.branches)
        : _assetsTree.branches;

    emit(
      state.copyWith(
        critical: false,
        energy: newEnergySytate,
        assetsTree: AssetsTree(branches: assetsTreeFiltered),
      ),
    );
  }

  List<TreeBranches> _deepEnergySensorFilter(
    List<TreeBranches> branches,
  ) {
    final List<TreeBranches> assetsTree = [];

    for (var element in branches) {
      if (element.children.isNotEmpty) {
        element = element.copyWith(
          isOpen: true,
          children: _deepEnergySensorFilter(element.children),
        );
      }

      if (element is ComponentAsset) {
        if (element.isEnergySensor) {
          assetsTree.add(element);
        }
      }

      if (element.children.isNotEmpty) {
        assetsTree.add(element);
      }
    }

    return assetsTree;
  }

  void onFiltering(String query) {
    final filterByTyping = _deepTypingFilter(
      query.toLowerCase(),
      _assetsTree.branches,
    );

    emit(
      state.copyWith(
        energy: false,
        critical: false,
        assetsTree: AssetsTree(branches: filterByTyping),
      ),
    );
  }

  List<TreeBranches> _deepTypingFilter(
    String query,
    List<TreeBranches> branches,
  ) {
    final List<TreeBranches> assetsTree = [];

    for (var element in branches) {
      if (element.children.isNotEmpty) {
        element = element.copyWith(
          isOpen: true,
          children: _deepTypingFilter(query, element.children),
        );
      }

      if (element.name.toLowerCase().contains(query)) {
        assetsTree.add(element);
      } else if (element.children.isNotEmpty) {
        assetsTree.add(element);
      }
    }

    return assetsTree;
  }
}

class AssetsArgs {
  final String companyId;

  AssetsArgs({required this.companyId});
}
