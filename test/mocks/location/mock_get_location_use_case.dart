import 'package:mocktail/mocktail.dart';
import 'package:traction_selection_process/app/core/utils/result.dart';
import 'package:traction_selection_process/app/domain/locations/entities/location.dart';
import 'package:traction_selection_process/app/domain/locations/entities/sub_location.dart';
import 'package:traction_selection_process/app/domain/locations/use_cases/get_location_use_case.dart';

class MockGetLocationUseCase extends Mock implements GetLocationUseCase {
  @override
  Future<LocationResult> call(String params) async {
    return Result.success(
      [
        Location(
          id: "123",
          name: "Production Tractian",
          children: [
            SubLocation(id: "0012", name: "Sub Production", parentId: "123"),
            SubLocation(
              id: "002",
              name: "Sub Production2",
              parentId: "123",
              children: [
                SubLocation(
                  id: "004",
                  name: "Sub Production",
                  parentId: "123",
                  children: [
                    SubLocation(
                        id: "007", name: "Sub Production", parentId: "123"),
                    SubLocation(
                        id: "001",
                        name: "Sub Production",
                        parentId: "123",
                        children: [
                          SubLocation(
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
