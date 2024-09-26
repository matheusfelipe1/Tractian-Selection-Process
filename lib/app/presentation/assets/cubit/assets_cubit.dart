import 'dart:async';
import 'package:get/get.dart';
import 'package:traction_selection_process/app/core/utils/base_cubit.dart';
import 'package:traction_selection_process/app/core/extensions/tree_branches_extension.dart';
import 'package:traction_selection_process/app/presentation/assets/cubit/assets_states.dart';
import 'package:traction_selection_process/app/domain/locations/entities/location_entity.dart';
import 'package:traction_selection_process/app/domain/assets_tree/entities/assets_tree_entity.dart';
import 'package:traction_selection_process/app/domain/locations/use_cases/get_location_use_case.dart';
import 'package:traction_selection_process/app/domain/assets_tree/use_case/get_tree_asset_use_case.dart';
import 'package:traction_selection_process/app/domain/assets_tree/use_case/build_assets_tree_use_case.dart';
import 'package:traction_selection_process/app/domain/assets_tree/use_case/expand_the_children_use_case.dart';
import 'package:traction_selection_process/app/domain/assets_tree/use_case/filter_energy_sensor_use_case.dart';
import 'package:traction_selection_process/app/domain/assets_tree/use_case/filter_critical_alert_use_case.dart';
import 'package:traction_selection_process/app/domain/assets_tree/use_case/filter_by_text_assets_tree_use_case.dart';
import 'package:traction_selection_process/app/domain/assets_tree/use_case/cached_data_can_be_filtered_use_case.dart';

class AssetsCubit extends BaseCubit<AssetsState> {
  final GetLocationUseCase _getLocationUseCase;
  final GetAssetsTreeUseCase _getAssetsTreeUseCase;
  final BuildAssetsTreeUseCase _buildAssetsTreeUseCase;
  final ExpandTheChildrenUseCase _expandTheChildrenUseCase;
  final FilterEnergySensorUseCase _filterEnergySensorUseCase;
  final FilterCriticalAlertUseCase _filterCriticalAlertUseCase;
  final FilterByTextAssetsTreeUseCase _filterByTextAssetsTreeUseCase;
  final CachedDataCanBeFilteredUseCase _cachedDataCanBeFilteredUseCase;

  AssetsCubit({
    required GetLocationUseCase getLocationUseCase,
    required GetAssetsTreeUseCase getAssetsTreeUseCase,
    required BuildAssetsTreeUseCase buildAssetsTreeUseCase,
    required ExpandTheChildrenUseCase expandTheChildrenUseCase,
    required FilterEnergySensorUseCase filterEnergySensorUseCase,
    required FilterCriticalAlertUseCase filterCriticalAlertUseCase,
    required FilterByTextAssetsTreeUseCase filterByTextAssetsTreeUseCase,
    required CachedDataCanBeFilteredUseCase cachedDataCanBeFilteredUseCase,
  })  : _getLocationUseCase = getLocationUseCase,
        _getAssetsTreeUseCase = getAssetsTreeUseCase,
        _buildAssetsTreeUseCase = buildAssetsTreeUseCase,
        _expandTheChildrenUseCase = expandTheChildrenUseCase,
        _filterEnergySensorUseCase = filterEnergySensorUseCase,
        _filterCriticalAlertUseCase = filterCriticalAlertUseCase,
        _filterByTextAssetsTreeUseCase = filterByTextAssetsTreeUseCase,
        _cachedDataCanBeFilteredUseCase = cachedDataCanBeFilteredUseCase,
        super(AssetsInitial());

  String _cachedQueryString = '';
  late final AssetsArgs _assetsArgs;
  Completer<List<LocationEntity>> completer = Completer();
  AssetsTreeEntity _assetsTreeCache = const AssetsTreeEntity(branches: []);
  AssetsTreeEntity _assetsTreeCacheprocessed = const AssetsTreeEntity(branches: []);

  @override
  void onInit() {
    _assetsArgs = Get.arguments as AssetsArgs;
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
    emit(AssetsLoading());
    await Future.wait([
      _getLocations(),
      _getAssetsTree(),
    ]);
  }

  Future<void> _getLocations() async {
    completer = Completer();

    final result = await _getLocationUseCase(_assetsArgs.companyId);
    result.processResult(
      onFailure: (error) => emit(AssetsError()),
      onSuccess: (data) => completer.complete(data),
    );
  }

  Future<void> _getAssetsTree() async {
    final result = await _getAssetsTreeUseCase(_assetsArgs.companyId);
    result.processResult(
      onSuccess: _buildAssetsTree,
      onFailure: (error) => emit(AssetsError()),
    );
  }

  Future<void> _buildAssetsTree(AssetsTreeEntity inputAssetsTreeData) async {
    final locationData = await completer.future;
    final assetsTreeData = _combineBranches(inputAssetsTreeData, locationData);

    _emitInitialAssetsTree(assetsTreeData);
    _listenForUpdatedAssetsTree(assetsTreeData);
  }

  AssetsTreeEntity _combineBranches(
    AssetsTreeEntity inputAssetsTreeData,
    List<TreeBranches> locationData,
  ) {
    return AssetsTreeEntity(
      branches: [...inputAssetsTreeData.branches, ...locationData],
    );
  }

  void _emitInitialAssetsTree(AssetsTreeEntity assetsTreeData) {
    if (isClosed) return;
    emit(
      AssetsLoaded(
        assetsTree: state.assetsTree.copyWith(
          branches: assetsTreeData.branches.componentsUnlinked,
        ),
      ),
    );
  }

  void _listenForUpdatedAssetsTree(AssetsTreeEntity assetsTreeData) {
    _buildAssetsTreeUseCase(assetsTreeData).listen((resultData) {
      if (resultData == null) {
        emit(
          AssetsLoaded(
            energy: state.energy,
            isProcessing: false,
            critical: state.critical,
            assetsTree: state.assetsTree,
          ),
        );
        _cachedDataCanBeFiltered();
        return;
      }
      _updateAssetsTree(resultData);
    });
  }

  void _cachedDataCanBeFiltered() {
    final listenCachedData = _cachedDataCanBeFilteredUseCase(
      _assetsTreeCache.branches,
    );

    listenCachedData.listen((data) {
      _assetsTreeCacheprocessed = data;
    });
  }

  void _updateAssetsTree(AssetsTreeEntity resultData) {
    final currentAssetsTree = state.assetsTree;

    final updatedBranches = List<TreeBranches>.from(resultData.branches)
      ..addAll(currentAssetsTree.branches);

    if (isClosed) return;
    emit(
      AssetsLoaded(
        isProcessing: true,
        assetsTree: currentAssetsTree.copyWith(branches: updatedBranches),
      ),
    );

    _assetsTreeCache = currentAssetsTree.copyWith(branches: updatedBranches);
  }

  void toggleShowChildren(id) {
    final params = ExpandTheChildrenParams(
      id: id.toString(),
      branches: state.assetsTree.branches,
    );

    emit(
      state.copyWith(
        assetsTree: _expandTheChildrenUseCase(params),
      )
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

class AssetsArgs {
  final String companyId;

  AssetsArgs({required this.companyId});
}
