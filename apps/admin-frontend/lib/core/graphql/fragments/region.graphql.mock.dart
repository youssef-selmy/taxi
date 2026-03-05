import 'package:admin_frontend/core/graphql/fragments/coordinate.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/region.graphql.dart';

final mockRegionCategory1 = Fragment$regionCategory(
  id: "1",
  name: "Unites States",
  currency: "USD",
);

final mockRegionCategory2 = Fragment$regionCategory(
  id: "2",
  name: "Europe",
  currency: "EUR",
);

final mockRegionCategories = [mockRegionCategory1, mockRegionCategory2];

final mockRegion1 = Fragment$region(
  id: "1",
  name: "California",
  categoryId: "1",
  currency: "USD",
  enabled: true,
  location: [
    [
      Fragment$Coordinate(lat: 37.0, lng: -122.0),
      Fragment$Coordinate(lat: 37.0, lng: -120.0),
      Fragment$Coordinate(lat: 38.0, lng: -120.0),
      Fragment$Coordinate(lat: 38.0, lng: -122.0),
      Fragment$Coordinate(lat: 37.0, lng: -122.0),
    ],
  ],
);

final mockRegion2 = Fragment$region(
  id: "2",
  name: "New York",
  categoryId: "1",
  currency: "USD",
  enabled: true,
  location: [
    [
      Fragment$Coordinate(lat: 40.0, lng: -74.0),
      Fragment$Coordinate(lat: 40.0, lng: -72.0),
      Fragment$Coordinate(lat: 41.0, lng: -72.0),
      Fragment$Coordinate(lat: 41.0, lng: -74.0),
      Fragment$Coordinate(lat: 40.0, lng: -74.0),
    ],
  ],
);

final mockRegion3 = Fragment$region(
  id: "3",
  name: "Paris",
  categoryId: "2",
  currency: "EUR",
  enabled: true,
  location: [
    [
      Fragment$Coordinate(lat: 48.0, lng: 2.0),
      Fragment$Coordinate(lat: 48.0, lng: 3.0),
      Fragment$Coordinate(lat: 49.0, lng: 3.0),
      Fragment$Coordinate(lat: 49.0, lng: 2.0),
      Fragment$Coordinate(lat: 48.0, lng: 2.0),
    ],
  ],
);

final mockRegion4 = Fragment$region(
  id: "4",
  name: "Berlin",
  categoryId: "2",
  currency: "EUR",
  enabled: true,
  location: [
    [
      Fragment$Coordinate(lat: 52.0, lng: 13.0),
      Fragment$Coordinate(lat: 52.0, lng: 14.0),
      Fragment$Coordinate(lat: 53.0, lng: 14.0),
      Fragment$Coordinate(lat: 53.0, lng: 13.0),
      Fragment$Coordinate(lat: 52.0, lng: 13.0),
    ],
  ],
);

final mockRegionWithCategry1 = Fragment$regionWithCategory(
  id: "2",
  name: "New York",
  categoryId: "1",
  currency: "USD",
  enabled: true,
  location: [
    [
      Fragment$Coordinate(lat: 40.0, lng: -74.0),
      Fragment$Coordinate(lat: 40.0, lng: -72.0),
      Fragment$Coordinate(lat: 41.0, lng: -72.0),
      Fragment$Coordinate(lat: 41.0, lng: -74.0),
      Fragment$Coordinate(lat: 40.0, lng: -74.0),
    ],
  ],
  category: mockRegionCategory1,
);

final mockRegionWithCategry2 = Fragment$regionWithCategory(
  id: "4",
  name: "Berlin",
  categoryId: "2",
  currency: "EUR",
  enabled: true,
  location: [
    [
      Fragment$Coordinate(lat: 52.0, lng: 13.0),
      Fragment$Coordinate(lat: 52.0, lng: 14.0),
      Fragment$Coordinate(lat: 53.0, lng: 14.0),
      Fragment$Coordinate(lat: 53.0, lng: 13.0),
      Fragment$Coordinate(lat: 52.0, lng: 13.0),
    ],
  ],
  category: mockRegionCategory2,
);

final mockRegionWithCategories = [
  mockRegionWithCategry1,
  mockRegionWithCategry2,
];
