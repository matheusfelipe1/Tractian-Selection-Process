import 'package:get_it/get_it.dart';
import 'package:traction_selection_process/app/domain/assets_tree/use_case/build_assets_tree_use_case.dart';
import 'package:traction_selection_process/app/domain/assets_tree/use_case/get_tree_asset_use_case.dart';
import 'package:traction_selection_process/app/domain/company/use_cases/get_companies_use_case.dart';
import 'package:traction_selection_process/app/domain/locations/use_cases/get_location_use_case.dart';

import '../assets_tree/mock_get_assets_tree_use_case.dart';
import '../company/mock_get_companies_use_case.dart';
import '../location/mock_get_location_use_case.dart';

class MockDependencyInjection {
  static final _getIt = GetIt.instance;

  static void ensureInitialized() => _registerMocks();

  static void _registerMocks() {
    _getIt.registerFactory<GetCompaniesUseCase>(
      () => MockGetCompaniesUseCase(),
    );
    _getIt.registerFactory<GetAssetsTreeUseCase>(
      () => MockGetAssetsTreeUseCase(),
    );
    _getIt.registerFactory<GetLocationUseCase>(
      () => MockGetLocationUseCase(),
    );
    _getIt.registerFactory(
      () => BuildAssetsTreeUseCase(),
    );
  }
}
