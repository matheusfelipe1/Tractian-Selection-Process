import 'dart:async';
import 'dart:isolate';
import 'package:traction_selection_proccess/app/core/use_cases/use_cases.dart';
import 'package:traction_selection_proccess/app/domain/assets_tree/entities/tree_assets.dart';

class FilterByTextAssetsTreeUseCase
    extends UseCases<Stream<AssetsTree>, FilterByTextAssetsTreeParams> {
  Isolate? _activeIsolate;
  ReceivePort? _receivePort;

  @override
  Stream<AssetsTree> call(FilterByTextAssetsTreeParams params) {
    final StreamController<AssetsTree> streamController = StreamController();
    _runIsolate(params, streamController);
    return streamController.stream;
  }

  Future<void> _runIsolate(
    FilterByTextAssetsTreeParams params,
    StreamController streamController,
  ) async {
    _activeIsolate?.kill(priority: Isolate.immediate);
    _receivePort?.close();

    final receivePort = ReceivePort();

    _activeIsolate = await Isolate.spawn(
      _isolateTask,
      [receivePort.sendPort, params.query, params.branches],
    );

    receivePort.listen((branches) {
      streamController.add(AssetsTree(branches: branches));
    }).onDone(() {
      streamController.close();
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
          return element.copyWith(isOpen: true);
        }
      }

      if (element.name.toLowerCase().contains(query.toLowerCase())) {
        print(element.name);
        return element.copyWith(isOpen: true);
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
