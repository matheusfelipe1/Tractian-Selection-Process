import 'package:get/get.dart';
import 'package:traction_selection_process/app/routes/route_paths.dart';
import 'package:traction_selection_process/app/core/utils/base_cubit.dart';
import 'package:traction_selection_process/app/core/use_cases/use_cases.dart';
import 'package:traction_selection_process/app/presentation/home/cubit/home_state.dart';
import 'package:traction_selection_process/app/domain/company/use_cases/get_companies_use_case.dart';
import 'package:traction_selection_process/app/presentation/assets/cubit/assets_cubit.dart';

class HomeCubit extends BaseCubit<HomeState> {
  final GetCompaniesUseCase _getCompaniesUseCase;
  HomeCubit({
    required GetCompaniesUseCase getCompaniesUseCase,
  })  : _getCompaniesUseCase = getCompaniesUseCase,
        super(HomeInitial());

  @override
  void onInit() {
    _onGetCompanies();
  }

  Future<void> _onGetCompanies() async {
    emit(HomeLoading());
    final result = await _getCompaniesUseCase(NoParams());
    result.processResult(
      onSuccess: (data) => emit(HomeLoaded(companies: data)),
      onFailure: (error) => emit(HomeError(message: error.toString())),
    );
  }

  void goToAssetsPage(String idCompany) {
    Get.toNamed(
      RoutePaths.assets,
      arguments: AssetsArgs(companyId: idCompany),
    );
  }

  Future<void> onRefresh() async => await _onGetCompanies();
}
