import 'package:get_it/get_it.dart';
import 'package:traction_selection_proccess/src/domain/api/api_handler.dart';
import 'package:traction_selection_proccess/src/data/api/api_handler_impl.dart';
import 'package:traction_selection_proccess/src/data/company/datasource/company_datasource.dart';
import 'package:traction_selection_proccess/src/domain/company/repository/company_repository.dart';
import 'package:traction_selection_proccess/src/data/company/repository/company_repository_impl.dart';
import 'package:traction_selection_proccess/src/domain/company/use_cases/get_companies_use_case.dart';

class DependencyInjections {
  static final _getIt = GetIt.instance;

  static void ensureInitialized() {
    _registerDatasources();
    _registerRepositories();
    _registerUseCases();
  }

  static void _registerDatasources() {
    _getIt.registerFactory<ApiHandler>(
      () => ApiHandlerImpl(),
    );
    _getIt.registerFactory(
      () => CompanyDatasource(_getIt()),
    );
  }

  static void _registerRepositories() {
    _getIt.registerFactory<CompanyRepository>(
      () => CompanyRepositoryImpl(_getIt()),
    );
  }

  static void _registerUseCases() {
    _getIt.registerFactory(
      () => GetCompaniesUseCase(_getIt()),
    );
  }
}
