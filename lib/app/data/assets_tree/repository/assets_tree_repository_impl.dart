import 'package:flutter/foundation.dart';
import 'package:traction_selection_proccess/app/core/utils/result.dart';
import 'package:traction_selection_proccess/app/core/utils/base_repository.dart';
import 'package:traction_selection_proccess/app/domain/assets_tree/entities/tree_assets.dart';
import 'package:traction_selection_proccess/app/data/assets_tree/mappers/assets_tree_mapper.dart';
import 'package:traction_selection_proccess/app/data/assets_tree/datasource/assets_tree_datasource.dart';
import 'package:traction_selection_proccess/app/domain/assets_tree/repository/assets_tree_repository.dart';

class AssetsTreeRepositoryImpl extends BaseRepository
    implements AssetsTreeRepository {
  final AssetsTreeDatasource _datasource;

  AssetsTreeRepositoryImpl(this._datasource);

  @override
  Future<Result<AssetsTree, Exception>> getAssetsTree(String companyId) async {
    try {
      final result = await _datasource.getGeneralAssets(companyId);

      final assetsTreeMapped = await compute(_computeHeavyTask, result);

      return handleSuccess(assetsTreeMapped);
    } catch (error) {
      return handleFailure(error);
    }
  }

  static AssetsTree _computeHeavyTask(dynamic result) {
    final assetsTreeMapped = AssetsTreeMappers.fromDataList(result);

    return AssetsTree(branches: assetsTreeMapped);
  }
}
