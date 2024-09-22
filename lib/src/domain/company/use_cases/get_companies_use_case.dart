import 'package:traction_selection_proccess/src/core/utils/result.dart';
import 'package:traction_selection_proccess/src/core/use_cases/use_cases.dart';
import 'package:traction_selection_proccess/src/domain/company/entity/company_entity.dart';
import 'package:traction_selection_proccess/src/domain/company/repository/company_repository.dart';

typedef CompaniesResult = Result<List<CompanyEntity>, Exception>;

class GetCompaniesUseCase extends UseCases<CompaniesResult, NoParams> {

  final CompanyRepository _companyRepository;

  GetCompaniesUseCase(this._companyRepository);

  @override
  Future<Result<List<CompanyEntity>, Exception>> call(NoParams params) async {
    return await _companyRepository.getCompanies();
  }
}
