import 'package:traction_selection_proccess/src/core/extensions/map_extensions.dart';
import 'package:traction_selection_proccess/src/domain/company/entity/company_entity.dart';

extension CompanyDTO on CompanyEntity {

  static CompanyEntity _fromData(Map<String, dynamic> data) {
    return CompanyEntity(
      id: data.getValue(key: "id"),
      name: data.getOrDefaultValue(key: "name", defaultValue: ""),
    );
  }

  static List<CompanyEntity> fromDataList(List data) {
    return data.cast<Map<String, dynamic>>().map((e) => _fromData(e)).toList();
  }
}