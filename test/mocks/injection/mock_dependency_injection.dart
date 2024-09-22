import 'package:get_it/get_it.dart';
import 'package:traction_selection_proccess/src/domain/company/use_cases/get_companies_use_case.dart';

import '../company/mock_get_companies_use_case.dart';

class MockDependencyInjection {
  static final _getIt = GetIt.instance;

  static void ensureInitialized() => _registerMocks();

  static void _registerMocks() {
    _getIt.registerFactory<GetCompaniesUseCase>(
      () => MockGetCompaniesUseCase(),
    );
  }
}
