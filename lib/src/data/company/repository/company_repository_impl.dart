import 'package:traction_selection_proccess/src/core/utils/result.dart';
import 'package:traction_selection_proccess/src/core/utils/base_repository.dart';
import 'package:traction_selection_proccess/src/data/company/dto/company_dto.dart';
import 'package:traction_selection_proccess/src/domain/company/entity/company_entity.dart';
import 'package:traction_selection_proccess/src/data/company/datasource/company_datasource.dart';
import 'package:traction_selection_proccess/src/domain/company/repository/company_repository.dart';

class CompanyRepositoryImpl extends BaseRepository implements CompanyRepository {

  final CompanyDatasource _companyDatasource;

  CompanyRepositoryImpl(this._companyDatasource);

  @override
  Future<Result<List<CompanyEntity>, Exception>> getCompanies() async {
    try {
      final result = await _companyDatasource.getCompanies();
      return handleSuccess(CompanyDTO.fromDataList(result));
    } catch (error) {
      return handleFailure(error);
    }
  }
}