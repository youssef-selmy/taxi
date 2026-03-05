import 'package:admin_frontend/core/graphql/fragments/coordinate.fragment.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/taxi_pricing.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/zone_price.graphql.dart';

final mockZonePriceCategory1 = Fragment$zonePriceCategory(
  id: "1",
  name: "Californa",
);

final mockZonePriceCategory2 = Fragment$zonePriceCategory(
  id: "2",
  name: "New York",
);

final mockZonePriceCategory3 = Fragment$zonePriceCategory(
  id: "3",
  name: "Nevada",
);

final mockZonePriceCategory4 = Fragment$zonePriceCategory(
  id: "4",
  name: "Texas",
);

final mockZonePriceCategoies = [
  mockZonePriceCategory1,
  mockZonePriceCategory2,
  mockZonePriceCategory3,
  mockZonePriceCategory4,
];

final mockZonePriceListItem1 = Fragment$zonePriceListItem(
  id: "1",
  name: "Los Banos Municipal Airport to San Francisco International Airport",
);

final mockZonePriceListItem2 = Fragment$zonePriceListItem(
  id: "2",
  name: "Los Banos Municipal Airport to San Jose International Airport",
);

final mockZonePriceListItem3 = Fragment$zonePriceListItem(
  id: "3",
  name: "Los Banos Municipal Airport to Oakland International Airport",
);

final mockZonePriceListItem4 = Fragment$zonePriceListItem(
  id: "4",
  name: "Los Banos Municipal Airport to Sacramento International Airport",
);

final mockZonePriceListItems = [
  mockZonePriceListItem1,
  mockZonePriceListItem2,
  mockZonePriceListItem3,
  mockZonePriceListItem4,
];

final mockZonePrice = Fragment$zonePrice(
  id: "1",
  name: "Los Banos Municipal Airport to San Francisco International Airport",
  cost: 12,
  from: [
    [mockCoordinateSanJose],
    [mockCoordinateSanFrancisco],
  ],
  to: [
    [mockCoordinateSanFrancisco],
    [mockCoordinateSanJose],
  ],
  fleets: [],
  services: [],
  timeMultipliers: [mockTimeMultiplier1],
);
