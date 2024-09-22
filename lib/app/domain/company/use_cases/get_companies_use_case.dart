import 'package:traction_selection_proccess/app/core/utils/result.dart';
import 'package:traction_selection_proccess/app/core/use_cases/use_cases.dart';
import 'package:traction_selection_proccess/app/domain/company/entity/company.dart';
import 'package:traction_selection_proccess/app/domain/company/repository/company_repository.dart';

typedef CompaniesResult = Result<List<Company>, Exception>;

class GetCompaniesUseCase extends UseCases<CompaniesResult, NoParams> {
  final CompanyRepository _companyRepository;

  GetCompaniesUseCase(this._companyRepository);

  @override
  Future<Result<List<Company>, Exception>> call(NoParams params) async {
    return await _companyRepository.getCompanies();
  }
}
