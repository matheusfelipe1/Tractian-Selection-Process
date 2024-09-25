import 'package:traction_selection_process/app/core/utils/result.dart';
import 'package:traction_selection_process/app/core/utils/base_repository.dart';
import 'package:traction_selection_process/app/data/company/mapper/company_mapper.dart';
import 'package:traction_selection_process/app/domain/company/entity/company.dart';
import 'package:traction_selection_process/app/data/company/datasource/company_datasource.dart';
import 'package:traction_selection_process/app/domain/company/repository/company_repository.dart';

class CompanyRepositoryImpl extends BaseRepository
    implements CompanyRepository {
  final CompanyDatasource _companyDatasource;

  CompanyRepositoryImpl(this._companyDatasource);

  @override
  Future<Result<List<Company>, Exception>> getCompanies() async {
    try {
      final result = await _companyDatasource.getCompanies();
      return handleSuccess(CompanyMapper.fromDataList(result));
    } catch (error) {
      return handleFailure(error);
    }
  }
}
