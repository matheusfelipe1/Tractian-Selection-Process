import 'package:traction_selection_proccess/app/core/utils/result.dart';
import 'package:traction_selection_proccess/app/domain/company/entity/company.dart';

abstract class CompanyRepository {
  Future<Result<List<Company>, Exception>> getCompanies();
}
