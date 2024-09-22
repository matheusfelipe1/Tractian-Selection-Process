import 'package:mocktail/mocktail.dart';
import 'package:traction_selection_proccess/app/core/use_cases/use_cases.dart';
import 'package:traction_selection_proccess/app/core/utils/result.dart';
import 'package:traction_selection_proccess/app/domain/company/entity/company_entity.dart';
import 'package:traction_selection_proccess/app/domain/company/use_cases/get_companies_use_case.dart';

class MockGetCompaniesUseCase extends Mock implements GetCompaniesUseCase {
  @override
  Future<Result<List<CompanyEntity>, Exception>> call(NoParams params) async {
    return Result.success(
      [
        const CompanyEntity(id: "123", name: "Tractian: Inovação 1"),
        const CompanyEntity(id: "456", name: "Tractian: Inovação 2"),
        const CompanyEntity(id: "789", name: "Tractian: Inovação 3"),
      ],
    );
  }
}
