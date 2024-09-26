import 'package:traction_selection_process/app/core/utils/result.dart';
import 'package:traction_selection_process/app/core/use_cases/use_cases.dart';
import 'package:traction_selection_process/app/domain/company/entity/company_entity.dart';
import 'package:traction_selection_process/app/domain/company/repository/company_repository.dart';

typedef CompaniesResult = Result<List<CompanyEntity>, Exception>;

class GetCompaniesUseCase extends UseCases<CompaniesResult, NoParams> {
  final CompanyRepository _companyRepository;

  GetCompaniesUseCase(this._companyRepository);

  @override
  Future<Result<List<CompanyEntity>, Exception>> call(NoParams params) async {
    return await _companyRepository.getCompanies();
  }
}
