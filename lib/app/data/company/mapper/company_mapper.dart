import 'package:traction_selection_proccess/app/core/extensions/map_extensions.dart';
import 'package:traction_selection_proccess/app/domain/company/entity/company.dart';

class CompanyMapper {
  static Company _fromData(Map<String, dynamic> data) {
    return Company(
      id: data.getValue(key: "id"),
      name: data.getOrDefaultValue(key: "name", defaultValue: ""),
    );
  }

  static List<Company> fromDataList(List data) {
    return data.cast<Map<String, dynamic>>().map((e) => _fromData(e)).toList();
  }
}
