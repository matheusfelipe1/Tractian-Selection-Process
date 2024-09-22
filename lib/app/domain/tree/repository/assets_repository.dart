import 'package:traction_selection_proccess/app/core/utils/result.dart';
import 'package:traction_selection_proccess/app/domain/tree/entities/tree_assets.dart';

abstract class AssetsRepository {
  Future<Result<AssetsTree, Exception>> getAssetsTree(String companyId);
}
