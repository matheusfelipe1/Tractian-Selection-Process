import 'package:traction_selection_process/app/core/constants/app_constants.dart';
import 'package:traction_selection_process/app/core/extensions/map_extensions.dart';
import 'package:traction_selection_process/app/domain/company/entity/company_entity.dart';

class CompanyMapper {
  static CompanyEntity _fromData(Map<String, dynamic> data) {
    return CompanyEntity(
      id: data.getValue(key: AppConstants.id),
      name: data.getOrDefaultValue(key: AppConstants.name, defaultValue: ""),
    );
  }

  static List<CompanyEntity> fromDataList(List data) {
    return data.cast<Map<String, dynamic>>().map((e) => _fromData(e)).toList();
  }
}
