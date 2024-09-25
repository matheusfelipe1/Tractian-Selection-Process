import 'dart:async';
import 'dart:isolate';
import 'package:traction_selection_proccess/app/core/use_cases/use_cases.dart';
import 'package:traction_selection_proccess/app/domain/assets_tree/entities/tree_assets.dart';
import 'package:traction_selection_proccess/app/domain/assets_tree/entities/assets_component.dart';

class PreProccessingAssetsTreeCanBeFilteredUseCase
    extends UseCases<Stream<AssetsTree>, List<TreeBranches>> {
  Isolate? _activeIsolate;
  ReceivePort? _receivePort;

  @override
  Stream<AssetsTree> call(List<TreeBranches> params) {
    final StreamController<AssetsTree> streamController = StreamController();
    _runIsolate(params, streamController);
    return streamController.stream;
  }

  Future<void> _runIsolate(
    List<TreeBranches> params,
    StreamController streamController,
  ) async {
    _activeIsolate?.kill(priority: Isolate.immediate);
    _receivePort?.close();

    final receivePort = ReceivePort();

    _activeIsolate = await Isolate.spawn(
      _isolateTask,
      [receivePort.sendPort,  params],
    );

    receivePort.listen((branches) {
      streamController.add(AssetsTree(branches: branches));
    }).onDone(() {
      streamController.close();
    });
  }

  Future<void> _isolateTask(List<dynamic> args) async {
    final [sendPort, branches] = args;
    final treeBranches = await _deepFilter(branches);
    sendPort.send(treeBranches);
  }

  Future<List<TreeBranches>> _deepFilter(
    List<TreeBranches> branches,
  ) async {
    List<TreeBranches> treeBranches = [];
    final futures = branches.map((element) async {
      if (element.children.isNotEmpty) {
        final children = await _deepFilter(element.children);
        if (children.isNotEmpty) {
          return element.copyWith(children: children);
        }
      }

      if (element is AssetsComponent) {
        return element;
      }
      return null;
    });

    final processFutures = await Future.wait(futures);
    return treeBranches..addAll(processFutures.whereType<TreeBranches>());
  }
}
