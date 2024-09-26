import 'dart:async';
import 'dart:isolate';
import 'package:traction_selection_process/app/core/use_cases/use_cases.dart';
import 'package:traction_selection_process/app/domain/assets_tree/entities/assets_tree_entity.dart';
import 'package:traction_selection_process/app/domain/assets_tree/entities/assets_component_entity.dart';

class CachedDataCanBeFilteredUseCase extends UseCases<Stream<AssetsTreeEntity>, List<TreeBranches>> {
  @override
  Stream<AssetsTreeEntity> call(List<TreeBranches> params) {
    final StreamController<AssetsTreeEntity> streamController = StreamController();
    _preprocessAssetsInIsolate(params, streamController);
    return streamController.stream;
  }

  Future<void> _preprocessAssetsInIsolate(
    List<TreeBranches> params,
    StreamController streamController,
  ) async {
    final receivePort = ReceivePort();

    await Isolate.spawn(
      _isolateTask,
      [receivePort.sendPort, params],
    );

    receivePort.listen((branches) {
      streamController.add(AssetsTreeEntity(branches: branches));
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

      if (element is AssetsComponentEntity) {
        return element;
      }
      return null;
    });

    final processFutures = await Future.wait(futures);
    return treeBranches..addAll(processFutures.whereType<TreeBranches>());
  }
}
