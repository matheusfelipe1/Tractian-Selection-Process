import 'package:traction_selection_process/app/core/utils/result.dart';
import 'package:traction_selection_process/app/domain/company/entity/company.dart';

abstract class CompanyRepository {
  Future<Result<List<Company>, Exception>> getCompanies();
}
