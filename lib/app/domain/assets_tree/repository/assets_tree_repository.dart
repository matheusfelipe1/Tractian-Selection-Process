import 'package:traction_selection_process/app/core/utils/result.dart';
import 'package:traction_selection_process/app/domain/assets_tree/entities/assets_tree_entity.dart';

abstract class AssetsTreeRepository {
  Future<Result<AssetsTreeEntity, Exception>> getAssetsTree(String companyId);
}
