import 'package:traction_selection_proccess/app/core/use_cases/use_cases.dart';
import 'package:traction_selection_proccess/app/core/utils/result.dart';
import 'package:traction_selection_proccess/app/domain/tree/entities/tree_assets.dart';
import 'package:traction_selection_proccess/app/domain/tree/repository/assets_repository.dart';

typedef AssetsTreeResult = Result<AssetsTree, Exception>;

class GetAssetsTreeUseCase implements UseCases<AssetsTreeResult, String> {
  final AssetsRepository _assetsRepository;
  GetAssetsTreeUseCase(this._assetsRepository);

  @override
  Future<AssetsTreeResult> call(String params) async {
    return await _assetsRepository.getAssetsTree(params);
  }
}
