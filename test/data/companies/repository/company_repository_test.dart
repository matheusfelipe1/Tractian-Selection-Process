import 'package:flutter/material.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:traction_selection_proccess/app/core/utils/result.dart';
import 'package:traction_selection_proccess/app/domain/company/entity/company_entity.dart';
import 'package:traction_selection_proccess/app/data/company/datasource/company_datasource.dart';
import 'package:traction_selection_proccess/app/domain/company/repository/company_repository.dart';
import 'package:traction_selection_proccess/app/data/company/repository/company_repository_impl.dart';

class CompanyDatasourceMock extends Mock implements CompanyDatasource {}

void main() {
  late final CompanyDatasource datasource;
  late final CompanyRepository repository;

  setUp(() {
    datasource = CompanyDatasourceMock();
    repository = CompanyRepositoryImpl(datasource);
  });

  test(
    "Must return a Result<List<CompanyEntity>, Exception>",
    () async {
      when(() => datasource.getCompanies())
          .thenAnswer((_) async => _mockCompaniesJSON);

      final result = await repository.getCompanies();
      expect(result, isA<Result<List<CompanyEntity>, Exception>>());
      expect(result.isSuccess, equals(true));
      result.proccessResult(
        onSuccess: (data) {
          expect(data.length, equals(3));
          expect(data.first.id, equals("662fd100f990557384756e58"));
          expect(data.first.name, equals("Apex"));
          expect(data.last.id, equals("662fd0fab3fd5656edb39af5"));
          expect(data.last.name, equals("Tobias"));
        },
        onFailure: (error) {
          debugPrint("error on $error");
          fail("Should not be called");
        },
      );
    },
  );
}

const _mockCompaniesJSON = [
  {"id": "662fd100f990557384756e58", "name": "Apex"},
  {"id": "662fd0ee639069143a8fc387", "name": "Jaguar"},
  {"id": "662fd0fab3fd5656edb39af5", "name": "Tobias"},
];
