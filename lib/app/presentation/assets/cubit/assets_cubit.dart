import 'package:get/get.dart';
import 'package:traction_selection_proccess/app/core/extensions/location_extension.dart';
import 'package:traction_selection_proccess/app/core/utils/base_cubit.dart';
import 'package:traction_selection_proccess/app/presentation/assets/cubit/assets_states.dart';
import 'package:traction_selection_proccess/app/domain/locations/use_cases/get_location_use_case.dart';

class AssetsCubit extends BaseCubit<AssetsState> {
  final GetLocationUseCase _getLocationUseCase;

  AssetsCubit(this._getLocationUseCase) : super(AssetsInitial());

  late final AssetsArgs _args;

  @override
  void onInit() {
    _args = Get.arguments as AssetsArgs;
    _getLocations();
  }

  void onRefresh() {
    _getLocations();
  }

  Future<void> _getLocations() async {
    emit(AssetsLoading());
    final result = await _getLocationUseCase(
      LocationParams(idCompany: _args.companyId),
    );

    result.proccessResult(
      onFailure: (error) => emit(AssetsError()),
      onSuccess: (data) => emit(AssetsLoaded(assets: data.toDSData())),
    );
  }
}

class AssetsArgs {
  final String companyId;

  AssetsArgs({required this.companyId});
}
