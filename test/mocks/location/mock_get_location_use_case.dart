import 'package:mocktail/mocktail.dart';
import 'package:traction_selection_process/app/core/utils/result.dart';
import 'package:traction_selection_process/app/domain/locations/entities/location_entity.dart';
import 'package:traction_selection_process/app/domain/locations/entities/sub_location_entity.dart';
import 'package:traction_selection_process/app/domain/locations/use_cases/get_location_use_case.dart';

class MockGetLocationUseCase extends Mock implements GetLocationUseCase {
  @override
  Future<LocationResult> call(String params) async {
    return Result.success(
      [
        LocationEntity(
          id: "123",
          name: "Production Tractian",
          children: [
            SubLocationEntity(id: "0012", name: "Sub Production", parentId: "123"),
            SubLocationEntity(
              id: "002",
              name: "Sub Production2",
              parentId: "123",
              children: [
                SubLocationEntity(
                  id: "004",
                  name: "Sub Production",
                  parentId: "123",
                  children: [
                    SubLocationEntity(
                        id: "007", name: "Sub Production", parentId: "123"),
                    SubLocationEntity(
                        id: "001",
                        name: "Sub Production",
                        parentId: "123",
                        children: [
                          SubLocationEntity(
                              id: "0090",
                              name: "Sub Production",
                              parentId: "123"),
                        ]),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
