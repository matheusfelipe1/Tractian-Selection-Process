import 'dart:async';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
import 'package:traction_selection_proccess/app/core/utils/base_cubit.dart';
import 'package:traction_selection_proccess/app/domain/assets_tree/use_case/filter_by_text_assets_tree_use_case.dart';
import 'package:traction_selection_proccess/app/domain/assets_tree/use_case/pre_proccessing_assets_tree_can_be_filtered_use_case.dart';
import 'package:traction_selection_proccess/app/domain/locations/entities/location.dart';
import 'package:traction_selection_proccess/app/domain/assets_tree/entities/tree_assets.dart';
import 'package:traction_selection_proccess/app/core/extensions/tree_branches_extension.dart';
import 'package:traction_selection_proccess/app/domain/assets_tree/entities/assets_component.dart';
import 'package:traction_selection_proccess/app/domain/locations/use_cases/get_location_use_case.dart';
import 'package:traction_selection_proccess/app/presentation/assets_tree/cubit/assets_tree_states.dart';
import 'package:traction_selection_proccess/app/domain/assets_tree/use_case/get_tree_asset_use_case.dart';
import 'package:traction_selection_proccess/app/domain/assets_tree/use_case/build_assets_tree_use_case.dart';

class AssetsTreeCubit extends BaseCubit<AssetsTreeState> {
  final GetLocationUseCase _getLocationUseCase;
  final GetAssetsTreeUseCase _getAssetsTreeUseCase;
  final BuildAssetsTreeUseCase _buildAssetsTreeUseCase;
  final FilterByTextAssetsTreeUseCase _filterByTextAssetsTreeUseCase;
  final PreProccessingAssetsTreeCanBeFilteredUseCase
      _preProccessingAssetsTreeCanBeFilteredUseCase;

  AssetsTreeCubit({
    required GetLocationUseCase getLocationUseCase,
    required GetAssetsTreeUseCase getAssetsTreeUseCase,
    required BuildAssetsTreeUseCase buildAssetsTreeUseCase,
    required FilterByTextAssetsTreeUseCase filterByTextAssetsTreeUseCase,
    required PreProccessingAssetsTreeCanBeFilteredUseCase
        preProccessingAssetsTreeCanBeFilteredUseCase,
  })  : _getLocationUseCase = getLocationUseCase,
        _getAssetsTreeUseCase = getAssetsTreeUseCase,
        _buildAssetsTreeUseCase = buildAssetsTreeUseCase,
        _filterByTextAssetsTreeUseCase = filterByTextAssetsTreeUseCase,
        _preProccessingAssetsTreeCanBeFilteredUseCase =
            preProccessingAssetsTreeCanBeFilteredUseCase,
        super(AssetsTreeInitial());

  late final AssetsTreeArgs _args;

  Completer<List<Location>> completer = Completer();

  AssetsTree _assetsTreeCache = const AssetsTree(branches: []);

  AssetsTree _assetsTreeCacheProccessed = const AssetsTree(branches: []);

  @override
  void onInit() {
    _args = Get.arguments as AssetsTreeArgs;
    _getData();
  }

  void onDispose() {
    _filterByTextAssetsTreeUseCase.dispose();
    close();
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

    final result = await _getLocationUseCase(_args.companyId);

    result.proccessResult(
      onFailure: (error) => emit(AssetsTreeError()),
      onSuccess: (data) => completer.complete(data),
    );
  }

  Future<void> _getAssetsTree() async {
    emit(AssetsTreeLoading());
    final result = await _getAssetsTreeUseCase(_args.companyId);

    result.proccessResult(
      onSuccess: _buildAssetsTree,
      onFailure: (error) => emit(AssetsTreeError()),
    );
  }

  Future<void> _buildAssetsTree(AssetsTree inputData) async {
    final locations = await completer.future;
    final assetsTreeData = _combineBranches(inputData, locations);

    _emitInitialAssetsTree(assetsTreeData);
    _listenForUpdatedAssetsTree(assetsTreeData);
  }

  AssetsTree _combineBranches(
    AssetsTree inputData,
    List<TreeBranches> locations,
  ) {
    return AssetsTree(
      branches: [...inputData.branches, ...locations],
    );
  }

  void _emitInitialAssetsTree(AssetsTree assetsTreeData) {
    if (isClosed) return;
    emit(
      AssetsTreeLoaded(
        assetsTree: state.assetsTree.copyWith(
          branches: assetsTreeData.branches.componentsUnliked,
        ),
      ),
    );
  }

  void _listenForUpdatedAssetsTree(AssetsTree assetsTreeData) {
    _buildAssetsTreeUseCase(assetsTreeData).listen((resultData) {
      if (resultData == null) {
        _preProccessAssetsTree();
        return;
      }
      _updateAssetsTree(resultData);
    });
  }

  void _preProccessAssetsTree() {
    final listenPreProccess = _preProccessingAssetsTreeCanBeFilteredUseCase(
        _assetsTreeCache.branches);

    listenPreProccess.listen((data) {
      _assetsTreeCacheProccessed = data;
    });
  }

  void _updateAssetsTree(AssetsTree resultData) {
    final currentAssetsTree = state.assetsTree;

    final updatedBranches = List<TreeBranches>.from(resultData.branches)
      ..addAll(currentAssetsTree.branches);

    if (isClosed) return;
    emit(
      AssetsTreeLoaded(
        assetsTree: currentAssetsTree.copyWith(branches: updatedBranches),
      ),
    );

    _assetsTreeCache = currentAssetsTree.copyWith(branches: updatedBranches);
  }

  void toggleTree(String id) {
    final assetsTree = AssetsTree(
      branches: _deepSearchToExpandes(id, state.assetsTree.branches),
    );

    emit(AssetsTreeLoaded(assetsTree: assetsTree));
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

  Future<void> toggleAlertCritical() async {
    final newCriticalState = !state.critical;
    final assetsTreeFiltered = newCriticalState
        ? await compute(
            _deepCriticalFilter, _assetsTreeCacheProccessed.branches)
        : _assetsTreeCacheProccessed.branches;

    emit(
      state.copyWith(
        energy: false,
        critical: newCriticalState,
        assetsTree: AssetsTree(branches: assetsTreeFiltered),
      ),
    );
  }

  static List<TreeBranches> _deepCriticalFilter(
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

      if (element is AssetsComponent) {
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

  Future<void> toggleEnergySensor() async {
    final newEnergySytate = !state.energy;
    final assetsTreeFiltered = newEnergySytate
        ? await compute(
            _deepEnergySensorFilter, _assetsTreeCacheProccessed.branches)
        : _assetsTreeCacheProccessed.branches;

    emit(
      state.copyWith(
        critical: false,
        energy: newEnergySytate,
        assetsTree: AssetsTree(branches: assetsTreeFiltered),
      ),
    );
  }

  static List<TreeBranches> _deepEnergySensorFilter(
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

      if (element is AssetsComponent) {
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

  String _cachedQueryString = '';

  Future<void> onFiltering(String query) async {

    final params = FilterByTextAssetsTreeParams(
      query: query,
      branches: query.contains(_cachedQueryString) &&
              query.length > _cachedQueryString.length
          ? state.assetsTree.branches
          : _assetsTreeCache.branches,
    );

    _cachedQueryString = query;
    final assetsTreeFiltered = _filterByTextAssetsTreeUseCase(params);

    assetsTreeFiltered.listen((data) {
      emit(
        state.copyWith(
          assetsTree: data,
        ),
      );
    });
  }
}

class AssetsTreeArgs {
  final String companyId;

  AssetsTreeArgs({required this.companyId});
}
