import 'package:traction_selection_process/app/core/use_cases/use_cases.dart';
import 'package:traction_selection_process/app/core/utils/result.dart';
import 'package:traction_selection_process/app/domain/assets_tree/entities/tree_assets.dart';
import 'package:traction_selection_process/app/domain/assets_tree/repository/assets_tree_repository.dart';

typedef AssetsTreeResult = Result<AssetsTree, Exception>;

class GetAssetsTreeUseCase implements UseCases<AssetsTreeResult, String> {
  final AssetsTreeRepository _assetsRepository;
  GetAssetsTreeUseCase(this._assetsRepository);

  @override
  Future<AssetsTreeResult> call(String params) async {
    return await _assetsRepository.getAssetsTree(params);
  }
}
