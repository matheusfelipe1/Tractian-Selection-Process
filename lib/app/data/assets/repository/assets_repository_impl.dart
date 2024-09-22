import 'package:traction_selection_proccess/app/core/utils/result.dart';
import 'package:traction_selection_proccess/app/core/utils/base_repository.dart';
import 'package:traction_selection_proccess/app/data/assets/datasource/assets_datasource.dart';
import 'package:traction_selection_proccess/app/data/assets/mappers/assets_tree_mappers.dart';
import 'package:traction_selection_proccess/app/domain/tree/entities/tree_assets.dart';
import 'package:traction_selection_proccess/app/domain/tree/repository/assets_repository.dart';

class AssetsRepositoryImpl extends BaseRepository implements AssetsRepository {
  final AssetsDatasource _datasource;

  AssetsRepositoryImpl(this._datasource);

  @override
  Future<Result<AssetsTree, Exception>> getAssetsTree(
      String companyId) async {
    try {
      final result = await _datasource.getGeneralAssets(companyId);
      final assetsTreeMapped = AssetsTreeMappers.fromDataList(result);
      return handleSuccess(AssetsTree(branches: assetsTreeMapped));
    } catch (error) {
      return handleFailure(error);
    }
  }
}
