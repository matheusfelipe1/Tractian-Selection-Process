import 'package:traction_selection_process/app/core/utils/result.dart';
import 'package:traction_selection_process/app/domain/assets_tree/entities/tree_assets.dart';

abstract class AssetsTreeRepository {
  Future<Result<AssetsTree, Exception>> getAssetsTree(String companyId);
}
