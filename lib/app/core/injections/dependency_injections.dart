import 'package:get_it/get_it.dart';
import 'package:traction_selection_proccess/app/data/assets/datasource/assets_datasource.dart';
import 'package:traction_selection_proccess/app/data/assets/repository/assets_repository_impl.dart';
import 'package:traction_selection_proccess/app/data/locations/datasource/location_datasource.dart';
import 'package:traction_selection_proccess/app/data/locations/repository/location_repository_impl.dart';
import 'package:traction_selection_proccess/app/domain/api/api_handler.dart';
import 'package:traction_selection_proccess/app/data/api/api_handler_impl.dart';
import 'package:traction_selection_proccess/app/data/company/datasource/company_datasource.dart';
import 'package:traction_selection_proccess/app/domain/tree/repository/assets_repository.dart';
import 'package:traction_selection_proccess/app/domain/tree/use_case/get_tree_asset_use_case.dart';
import 'package:traction_selection_proccess/app/domain/company/repository/company_repository.dart';
import 'package:traction_selection_proccess/app/data/company/repository/company_repository_impl.dart';
import 'package:traction_selection_proccess/app/domain/company/use_cases/get_companies_use_case.dart';
import 'package:traction_selection_proccess/app/domain/locations/repository/location_repository.dart';
import 'package:traction_selection_proccess/app/domain/locations/use_cases/get_location_use_case.dart';

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
    _getIt.registerFactory(
      () => LocationDatasource(_getIt()),
    );
    _getIt.registerFactory(
      () => AssetsDatasource(_getIt()),
    );
  }

  static void _registerRepositories() {
    _getIt.registerFactory<CompanyRepository>(
      () => CompanyRepositoryImpl(_getIt()),
    );
    _getIt.registerFactory<LocationRepository>(
      () => LocationRepositoryImpl(locationDatasource: _getIt()),
    );
    _getIt.registerFactory<AssetsRepository>(
      () => AssetsRepositoryImpl(_getIt()),
    );
  }

  static void _registerUseCases() {
    _getIt.registerFactory(
      () => GetCompaniesUseCase(_getIt()),
    );
    _getIt.registerFactory(
      () => GetLocationUseCase(_getIt()),
    );
    _getIt.registerFactory(
      () => GetAssetsTreeUseCase(_getIt()),
    );
  }
}
