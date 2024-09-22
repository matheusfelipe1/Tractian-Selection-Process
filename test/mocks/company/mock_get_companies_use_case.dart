import 'package:mocktail/mocktail.dart';
import 'package:traction_selection_proccess/app/core/use_cases/use_cases.dart';
import 'package:traction_selection_proccess/app/core/utils/result.dart';
import 'package:traction_selection_proccess/app/domain/company/entity/company.dart';
import 'package:traction_selection_proccess/app/domain/company/use_cases/get_companies_use_case.dart';

class MockGetCompaniesUseCase extends Mock implements GetCompaniesUseCase {
  @override
  Future<Result<List<Company>, Exception>> call(NoParams params) async {
    return Result.success(
      [
        const Company(id: "123", name: "Tractian: Inovação 1"),
        const Company(id: "456", name: "Tractian: Inovação 2"),
        const Company(id: "789", name: "Tractian: Inovação 3"),
      ],
    );
  }
}
