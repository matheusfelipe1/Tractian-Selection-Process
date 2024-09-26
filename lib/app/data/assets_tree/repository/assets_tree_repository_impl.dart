import 'package:flutter/foundation.dart';
import 'package:traction_selection_process/app/core/utils/result.dart';
import 'package:traction_selection_process/app/core/utils/base_repository.dart';
import 'package:traction_selection_process/app/domain/assets_tree/entities/assets_tree_entity.dart';
import 'package:traction_selection_process/app/data/assets_tree/mappers/assets_tree_mapper.dart';
import 'package:traction_selection_process/app/data/assets_tree/datasource/assets_tree_datasource.dart';
import 'package:traction_selection_process/app/domain/assets_tree/repository/assets_tree_repository.dart';

class AssetsTreeRepositoryImpl extends BaseRepository
    implements AssetsTreeRepository {
  final AssetsTreeDatasource _datasource;

  AssetsTreeRepositoryImpl(this._datasource);

  @override
  Future<Result<AssetsTreeEntity, Exception>> getAssetsTree(String companyId) async {
    try {
      final result = await _datasource.getGeneralAssets(companyId);

      final assetsTreeMapped = await compute(_computeHeavyTask, result);

      return handleSuccess(assetsTreeMapped);
    } catch (error) {
      return handleFailure(error);
    }
  }

  static AssetsTreeEntity _computeHeavyTask(dynamic result) {
    final assetsTreeMapped = AssetsTreeMappers.fromDataList(result);

    return AssetsTreeEntity(branches: assetsTreeMapped);
  }
}
