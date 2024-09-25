import 'dart:async';
import 'dart:isolate';
import 'package:traction_selection_process/app/core/use_cases/use_cases.dart';
import 'package:traction_selection_process/app/domain/tasks/tasks_manager.dart';
import 'package:traction_selection_process/app/domain/assets_tree/entities/tree_assets.dart';
import 'package:traction_selection_process/app/domain/assets_tree/entities/assets_component.dart';

class FilterByTextAssetsTreeUseCase
    extends UseCases<Stream<AssetsTree>, FilterByTextAssetsTreeParams> {
  final TasksManager _taskManager;

  FilterByTextAssetsTreeUseCase(this._taskManager);

  @override
  Stream<AssetsTree> call(FilterByTextAssetsTreeParams params) {
    final StreamController<AssetsTree> streamController = StreamController();
    _taskManager.addTask(() {
      _runIsolateFilter(params, streamController);
    });
    return streamController.stream;
  }

  void dispose() {
    _taskManager.releaseTask();
    _taskManager.killAllTasks();
  }

  Future<void> _runIsolateFilter(
    FilterByTextAssetsTreeParams params,
    StreamController streamController,
  ) async {
    final receivePort = ReceivePort();

    await Isolate.spawn(
      _isolateTask,
      [receivePort.sendPort, params],
    );

    receivePort.listen((branches) {
      _taskManager.releaseTask();
      if (branches is List<TreeBranches>) {
        streamController.add(AssetsTree(branches: branches));
      }
    }).onDone(() {
      _taskManager.releaseTask();
    });
  }

  Future<void> _isolateTask(List<dynamic> args) async {
    final [sendPort, params] = args;
    final treeBranches = await _deepTypingFilter(params);
    sendPort.send(treeBranches);
  }

  Future<List<TreeBranches>> _deepTypingFilter(
    FilterByTextAssetsTreeParams params,
  ) async {
    List<TreeBranches> treeBranches = [];
    final futures = params.branches.map((element) async {
      if (element.children.isNotEmpty) {
        final children = await _deepTypingFilter(
            params.copyWith(branches: element.children));
        if (children.isNotEmpty) {
          final canOpen = params.isEnergySensor ||
              params.isCritical ||
              params.query.isNotEmpty;
          return element.copyWith(children: children, isOpen: canOpen);
        }
      }

      if (params.isEnergySensor || params.isCritical) {
        if (element is AssetsComponent &&
            element.isCritical &&
            params.isCritical) {
          if (element.name.toLowerCase().contains(params.query.toLowerCase())) {
            return element.copyWith(isOpen: false);
          }
        }
        if (element is AssetsComponent &&
            element.isEnergySensor &&
            params.isEnergySensor) {
          if (element.name.toLowerCase().contains(params.query.toLowerCase())) {
            return element.copyWith(isOpen: false);
          }
        }
        return null;
      }

      if (element.name.toLowerCase().contains(params.query.toLowerCase())) {
        return element.copyWith(isOpen: false);
      }
      return null;
    });

    final processFutures = await Future.wait(futures);
    return treeBranches..addAll(processFutures.whereType<TreeBranches>());
  }
}

class FilterByTextAssetsTreeParams {
  final String query;
  final bool isCritical;
  final bool isEnergySensor;
  final List<TreeBranches> branches;

  FilterByTextAssetsTreeParams({
    required this.query,
    required this.branches,
    required this.isCritical,
    required this.isEnergySensor,
  });

  FilterByTextAssetsTreeParams copyWith({
    String? query,
    bool? isCritical,
    bool? isEnergySensor,
    List<TreeBranches>? branches,
  }) {
    return FilterByTextAssetsTreeParams(
      query: query ?? this.query,
      branches: branches ?? this.branches,
      isCritical: isCritical ?? this.isCritical,
      isEnergySensor: isEnergySensor ?? this.isEnergySensor,
    );
  }
}
