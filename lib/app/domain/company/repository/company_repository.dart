import 'package:traction_selection_proccess/app/core/utils/result.dart';
import 'package:traction_selection_proccess/app/domain/company/entity/company_entity.dart';

abstract class CompanyRepository {
  Future<Result<List<CompanyEntity>, Exception>> getCompanies();
}