import 'package:flutter_test/flutter_test.dart';
import 'package:traction_selection_process/app/data/company/mapper/company_mapper.dart';
import 'package:traction_selection_process/app/domain/company/entity/company.dart';

void main() {
  test(
    "Must return a list of companies",
    () {
      final companies = CompanyMapper.fromDataList(_mockCompaniesJSON);
      expect(companies, isA<List<Company>>());
      expect(companies.length, equals(3));
      expect(companies.first.id, equals("662fd100f990557384756e58"));
      expect(companies.first.name, equals("Apex"));
      expect(companies.last.id, equals("662fd0fab3fd5656edb39af5"));
      expect(companies.last.name, equals("Tobias"));
    },
  );
}

const _mockCompaniesJSON = [
  {"id": "662fd100f990557384756e58", "name": "Apex"},
  {"id": "662fd0ee639069143a8fc387", "name": "Jaguar"},
  {"id": "662fd0fab3fd5656edb39af5", "name": "Tobias"},
];
