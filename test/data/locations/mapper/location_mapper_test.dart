import 'package:flutter_test/flutter_test.dart';
import 'package:traction_selection_process/app/data/locations/mappers/location_mapper.dart';
import 'package:traction_selection_process/app/domain/locations/entities/location_entity.dart';

void main() {
  test(
    "Must return list of Locations and SubLocations",
    () {
      final locations = LocationMapper.fromDataList(_mockLocationJSON);
      expect(locations, isA<List<LocationEntity>>());
      expect(locations.length, equals(11));

      for (var location in locations) {
        if (location.children.isNotEmpty) {
          final checkIfIsParentId = location.children.cast().every(
                (item) => item.parentId == location.id,
              );
          expect(checkIfIsParentId, equals(true));
        }
      }
    },
  );
}

const _mockLocationJSON = [
  {
    "id": "6a9b31a1b62cbf0062dd8a89",
    "name": "Processing Unit 1",
    "parentId": "6a944484aac55c0062464050"
  },
  {
    "id": "6a9b4417a2555c0067916bd0",
    "name": "Processing Unit 2",
    "parentId": "6a9b47f2cac55c0062464076"
  },
  {
    "id": "6a9b4770a2555c0067916c24",
    "name": "Processing Unit 7",
    "parentId": "6a9b4711a2555c0067916c27"
  },
  {
    "id": "607a11a07a51520020945cd6",
    "name": "Processing Unit 4",
    "parentId": "607a1184f70f5b001e041ba4"
  },
  {
    "id": "6a9b4712c2555c0067916c25",
    "name": "Production Unit 1",
    "parentId": "6a9b4711a2555c0067916c27"
  },
  {
    "id": "6a9b47a5aac55c006246402d",
    "name": "Vaporization Unit 1",
    "parentId": "6a944484aac55c0062464050"
  },
  {
    "id": "6a9b4914aac55c0062464050",
    "name": "Processing Unit 5",
    "parentId": "6a9b47f2cac55c0062464076"
  },
  {
    "id": "6a9b4171b62cbf0062dd8a67",
    "name": "Corn Cooking Facility",
    "parentId": null
  },
  {
    "id": "6b245a175832e7001ecac62d",
    "name": "Decantation Unit 1",
    "parentId": "6b21f6fa9e497d001e2d4fcf"
  },
  {"id": "6080fa1b2515c0001e62cf87", "name": "Storage", "parentId": null},
  {
    "id": "6a944484aac55c0062464050",
    "name": "Distillery Unit 1",
    "parentId": null
  },
  {"id": "6a9b47f2cac55c0062464076", "name": "Evaporator", "parentId": null},
  {
    "id": "6a9b1722aac55c00624640a0",
    "name": "Extraction Unit 1",
    "parentId": "6a9b4711a2555c0067916c27"
  },
  {
    "id": "6b245caa7696b1001e047bef",
    "name": "Extraction Unit 2",
    "parentId": "6b21f6fa9e497d001e2d4fcf"
  },
  {
    "id": "6a9b477fb62cbf0062dd8aeb",
    "name": "Extraction Unit 7",
    "parentId": "6a9b4711a2555c0067916c27"
  },
  {
    "id": "60a988e24a1ac0001e8009e2",
    "name": "Electric Generator",
    "parentId": "6a98ffb52615e600676e09f7"
  },
  {
    "id": "6a98ffb52615e600676e09f7",
    "name": "Power Generation",
    "parentId": null
  },
  {
    "id": "6a9b4711a2555c0067916c27",
    "name": "St2cm Generation",
    "parentId": null
  },
  {
    "id": "6080fcbe98ac51001e7d440d",
    "name": "Mechanical Unit 1",
    "parentId": "6080fa1b2515c0001e62cf87"
  },
  {
    "id": "60fa15c1111e49001dbd2497",
    "name": "Mechanical Unit 2",
    "parentId": "6a9b4711a2555c0067916c27"
  },
  {
    "id": "6a9b41afa2555c0067916b94",
    "name": "Mixer for Soaking",
    "parentId": "6a9b4171b62cbf0062dd8a67"
  },
  {
    "id": "6a9b45c2cac55c00624640fc",
    "name": "Milling Unit 1",
    "parentId": "6a9b45c2a2555c0067916c62"
  },
  {
    "id": "6a9b4172b62cbf0062dd8a6c",
    "name": "Disk Mill",
    "parentId": "6a9b4171b62cbf0062dd8a67"
  },
  {
    "id": "60e0fca566e01e001fc2c172",
    "name": "Mechanical Assembly Office",
    "parentId": "60e0fbe2d5cef6001d8d165c"
  },
  {
    "id": "6a9b474da2555c0067916c2e",
    "name": "Evaporation Unit 1",
    "parentId": "6a9b4711a2555c0067916c27"
  },
  {
    "id": "6a9b49b0b62cbf0062dd5c46",
    "name": "Evaporation Unit 2",
    "parentId": "6a9b4995a2555c0067916c9c"
  },
  {
    "id": "606975924062a1001e2a70a6",
    "name": "Evaporation Unit 7",
    "parentId": "6a9b4711a2555c0067916c27"
  },
  {"id": "6a9b45c2a2555c0067916c62", "name": "Milling", "parentId": null},
  {
    "id": "6a98fff76117bd0062dcb484",
    "name": "Generator 1 Reducer",
    "parentId": "6a98ffb52615e600676e09f7"
  },
  {
    "id": "6a9901186117bd0062dcbdda",
    "name": "Generator 2 Reducer",
    "parentId": "6a98ffb52615e600676e09f7"
  },
  {"id": "6b21f6fa9e497d001e2d4fcf", "name": "Dryer", "parentId": null},
  {
    "id": "60e0fbe2d5cef6001d8d165c",
    "name": "Industrial Workshop and Maintenance",
    "parentId": null
  },
  {
    "id": "6092c8f567679000665ed5d2",
    "name": "Collector Tank",
    "parentId": "6a9b4171b62cbf0062dd8a67"
  },
  {
    "id": "6080f8526511f8001eb2c722",
    "name": "Soaking Tank",
    "parentId": "6a9b4171b62cbf0062dd8a67"
  },
  {"id": "6a9b4995a2555c0067916c9c", "name": "Water Cooling", "parentId": null},
  {"id": "607a1184f70f5b001e041ba4", "name": "Water Cooling", "parentId": null},
  {
    "id": "6a9b4725c62cbf0062dd8ae4",
    "name": "Extraction Unit 4",
    "parentId": "6a9b4711a2555c0067916c27"
  },
  {
    "id": "6b245cbc89efeb001ef87004",
    "name": "Extraction Unit 5",
    "parentId": "6b21f6fa9e497d001e2d4fcf"
  }
];
