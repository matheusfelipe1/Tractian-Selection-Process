import 'dart:async';
import 'dart:isolate';
import 'package:traction_selection_proccess/app/core/use_cases/use_cases.dart';
import 'package:traction_selection_proccess/app/domain/assets_tree/entities/tree_assets.dart';
import 'package:traction_selection_proccess/app/domain/tasks/tasks_manager.dart';

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
      [receivePort.sendPort, params.query, params.branches],
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
    final [sendPort, query, branches] = args;
    final treeBranches = await _deepTypingFilter(query, branches);
    sendPort.send(treeBranches);
  }

  Future<List<TreeBranches>> _deepTypingFilter(
    String query,
    List<TreeBranches> branches,
  ) async {
    List<TreeBranches> treeBranches = [];
    final futures = branches.map((element) async {
      if (element.children.isNotEmpty) {
        final children = await _deepTypingFilter(query, element.children);
        if (children.isNotEmpty) {
          return element.copyWith(children: children, isOpen: query.isNotEmpty);
        }
      }

      if (element.name.toLowerCase().contains(query.toLowerCase())) {
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
  final List<TreeBranches> branches;

  FilterByTextAssetsTreeParams({
    required this.query,
    required this.branches,
  });
}
