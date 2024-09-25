import 'dart:async';
import 'package:get/get.dart';
import 'package:traction_selection_process/app/core/utils/base_cubit.dart';
import 'package:traction_selection_process/app/domain/locations/entities/location.dart';
import 'package:traction_selection_process/app/domain/assets_tree/entities/tree_assets.dart';
import 'package:traction_selection_process/app/core/extensions/tree_branches_extension.dart';
import 'package:traction_selection_process/app/domain/locations/use_cases/get_location_use_case.dart';
import 'package:traction_selection_process/app/presentation/assets_tree/cubit/assets_tree_states.dart';
import 'package:traction_selection_process/app/domain/assets_tree/use_case/get_tree_asset_use_case.dart';
import 'package:traction_selection_process/app/domain/assets_tree/use_case/build_assets_tree_use_case.dart';
import 'package:traction_selection_process/app/domain/assets_tree/use_case/filter_energy_sensor_use_case.dart';
import 'package:traction_selection_process/app/domain/assets_tree/use_case/filter_critical_alert_use_case.dart';
import 'package:traction_selection_process/app/domain/assets_tree/use_case/filter_by_text_assets_tree_use_case.dart';
import 'package:traction_selection_process/app/domain/assets_tree/use_case/expands_children_when_clicked_use_case.dart';
import 'package:traction_selection_process/app/domain/assets_tree/use_case/pre_processing_assets_tree_can_be_filtered_use_case.dart';

class AssetsTreeCubit extends BaseCubit<AssetsTreeState> {
  final GetLocationUseCase _getLocationUseCase;
  final GetAssetsTreeUseCase _getAssetsTreeUseCase;
  final BuildAssetsTreeUseCase _buildAssetsTreeUseCase;
  final FilterEnergySensorUseCase _filterEnergySensorUseCase;
  final FilterCriticalAlertUseCase _filterCriticalAlertUseCase;
  final FilterByTextAssetsTreeUseCase _filterByTextAssetsTreeUseCase;
  final ExpandsChildrenWhenClickedUseCase _expandChildrenWhenClickedUseCase;
  final PreProcessingAssetsTreeCanBeFilteredUseCase
      _preProcessingAssetsTreeCanBeFilteredUseCase;

  AssetsTreeCubit({
    required GetLocationUseCase getLocationUseCase,
    required GetAssetsTreeUseCase getAssetsTreeUseCase,
    required BuildAssetsTreeUseCase buildAssetsTreeUseCase,
    required FilterEnergySensorUseCase filterEnergySensorUseCase,
    required FilterCriticalAlertUseCase filterCriticalAlertUseCase,
    required FilterByTextAssetsTreeUseCase filterByTextAssetsTreeUseCase,
    required ExpandsChildrenWhenClickedUseCase
        expandsChildrenWhenClickedUseCase,
    required PreProcessingAssetsTreeCanBeFilteredUseCase
        preProcessingAssetsTreeCanBeFilteredUseCase,
  })  : _getLocationUseCase = getLocationUseCase,
        _getAssetsTreeUseCase = getAssetsTreeUseCase,
        _buildAssetsTreeUseCase = buildAssetsTreeUseCase,
        _filterEnergySensorUseCase = filterEnergySensorUseCase,
        _filterCriticalAlertUseCase = filterCriticalAlertUseCase,
        _filterByTextAssetsTreeUseCase = filterByTextAssetsTreeUseCase,
        _expandChildrenWhenClickedUseCase = expandsChildrenWhenClickedUseCase,
        _preProcessingAssetsTreeCanBeFilteredUseCase =
            preProcessingAssetsTreeCanBeFilteredUseCase,
        super(AssetsTreeInitial());

  String _cachedQueryString = '';
  late final AssetsTreeArgs _args;
  Completer<List<Location>> completer = Completer();
  AssetsTree _assetsTreeCache = const AssetsTree(branches: []);
  AssetsTree _assetsTreeCacheprocessed = const AssetsTree(branches: []);

  @override
  void onInit() {
    _args = Get.arguments as AssetsTreeArgs;
    _executeRequestsToBuildAssetsTree();
  }

  void onDispose() {
    _filterByTextAssetsTreeUseCase.dispose();
    close();
  }

  Future<void> onRefresh() async {
    await _executeRequestsToBuildAssetsTree();
  }

  Future<void> _executeRequestsToBuildAssetsTree() async {
    emit(AssetsTreeLoading());
    await Future.wait([
      _getLocations(),
      _getAssetsTree(),
    ]);
  }

  Future<void> _getLocations() async {
    completer = Completer();

    final result = await _getLocationUseCase(_args.companyId);
    result.processResult(
      onFailure: (error) => emit(AssetsTreeError()),
      onSuccess: (data) => completer.complete(data),
    );
  }

  Future<void> _getAssetsTree() async {
    final result = await _getAssetsTreeUseCase(_args.companyId);
    result.processResult(
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
        emit(
          AssetsTreeLoaded(
            energy: state.energy,
            isProcessingData: false,
            critical: state.critical,
            assetsTree: state.assetsTree,
          ),
        );
        _preprocessAssetsTree();
        return;
      }
      _updateAssetsTree(resultData);
    });
  }

  void _preprocessAssetsTree() {
    final listenPreprocess = _preProcessingAssetsTreeCanBeFilteredUseCase(
      _assetsTreeCache.branches,
    );

    listenPreprocess.listen((data) {
      _assetsTreeCacheprocessed = data;
    });
  }

  void _updateAssetsTree(AssetsTree resultData) {
    final currentAssetsTree = state.assetsTree;

    final updatedBranches = List<TreeBranches>.from(resultData.branches)
      ..addAll(currentAssetsTree.branches);

    if (isClosed) return;
    emit(
      AssetsTreeLoaded(
        isProcessingData: true,
        assetsTree: currentAssetsTree.copyWith(branches: updatedBranches),
      ),
    );

    _assetsTreeCache = currentAssetsTree.copyWith(branches: updatedBranches);
  }

  void toggleTree(String id) {
    final params = ExpandsChildrenWhenClickedParams(
      id: id,
      branches: state.assetsTree.branches,
    );

    emit(
      AssetsTreeLoaded(
        assetsTree: _expandChildrenWhenClickedUseCase(params),
      ),
    );
  }

  Future<void> toggleAlertCritical() async {
    final criticalAlert = !state.critical;

    final assetsTree = await _filterCriticalAlertUseCase(
      FilterCriticalAlertParams(
        criticalAlertActive: criticalAlert,
        assetsTreeCache: _assetsTreeCache,
        assetsTreeprocessed: _assetsTreeCacheprocessed,
      ),
    );

    emit(
      state.copyWith(
        energy: false,
        assetsTree: assetsTree,
        critical: criticalAlert,
      ),
    );
  }

  Future<void> toggleEnergySensor() async {
    final energySensor = !state.energy;

    final assetsTree = await _filterEnergySensorUseCase(
      FilterEnergySensorParams(
        energySensorActive: energySensor,
        assetsTreeCache: _assetsTreeCache,
        assetsTreeprocessed: _assetsTreeCacheprocessed,
      ),
    );

    emit(
      state.copyWith(
        critical: false,
        energy: energySensor,
        assetsTree: assetsTree,
      ),
    );
  }

  Future<void> onFiltering(String query) async {
    final params = FilterByTextAssetsTreeParams(
      query: query,
      isCritical: state.critical,
      isEnergySensor: state.energy,
      branches: _choiceTreeBranches(query),
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

  List<TreeBranches> _choiceTreeBranches(String query) {
    final branches = query.contains(_cachedQueryString) &&
            query.length > _cachedQueryString.length
        ? state.assetsTree.branches
        : _assetsTreeCache.branches;

    return branches;
  }
}

class AssetsTreeArgs {
  final String companyId;

  AssetsTreeArgs({required this.companyId});
}
