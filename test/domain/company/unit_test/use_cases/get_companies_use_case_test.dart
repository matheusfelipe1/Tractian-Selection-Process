
import 'package:flutter/material.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:traction_selection_proccess/app/core/utils/result.dart';
import 'package:traction_selection_proccess/app/core/use_cases/use_cases.dart';
import 'package:traction_selection_proccess/app/domain/company/entity/company_entity.dart';
import 'package:traction_selection_proccess/app/domain/company/repository/company_repository.dart';
import 'package:traction_selection_proccess/app/domain/company/use_cases/get_companies_use_case.dart';

class CompanyRepositoryMock extends Mock implements CompanyRepository {}

void main() {
  late final CompanyRepository repository;
  late final GetCompaniesUseCase getCompaniesUseCase;

  setUp(() {
    repository = CompanyRepositoryMock();
    getCompaniesUseCase = GetCompaniesUseCase(repository);
  });

  test(
    "Must return a list of companies",
    () async {
      when(() => repository.getCompanies()).thenAnswer(
        (_) async => Result.success(
          [
            const CompanyEntity(id: "123", name: "Tractian: Inovação")
          ]
        ),
      );

      final result = await getCompaniesUseCase(NoParams());

      expect(result, isA<Result<List<CompanyEntity>, Exception>>());
      expect(result.isSuccess, equals(true));
      result.proccessResult(
        onSuccess: (data) {
          expect(data.length, equals(1));
          expect(data.first.id, equals("123"));
          expect(data.first.name, equals("Tractian: Inovação"));
        },
        onFailure: (error) {
          debugPrint("error on $error");
          fail("Should not be called");
        },
      );
    },
  );
}
