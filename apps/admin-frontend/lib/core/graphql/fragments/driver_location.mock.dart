import 'package:admin_frontend/core/graphql/fragments/coordinate.fragment.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/driver_location.fragment.graphql.dart';

final mockDriverLocation1 = Fragment$DriverLocation(
  id: "1",
  firstName: 'John',
  lastName: 'Doe',
  location: mockCoordinateSanFrancisco,
  mobileNumber: '1234567890',
  rating: 92,
  lastUpdatedAt: DateTime.now().subtract(const Duration(minutes: 5)),
);

final mockDriverLocation2 = Fragment$DriverLocation(
  id: "2",
  firstName: 'Jane',
  lastName: 'Doe',
  location: mockCoordinateSanJose,
  mobileNumber: '1234567890',
  rating: 86,
  lastUpdatedAt: DateTime.now().subtract(const Duration(minutes: 5)),
);

final mockDriverLocation3 = Fragment$DriverLocation(
  id: "3",
  firstName: 'John',
  lastName: 'Doe',
  location: mockCoordinateSanFrancisco,
  mobileNumber: '1234567890',
  rating: 74,
  lastUpdatedAt: DateTime.now().subtract(const Duration(minutes: 5)),
);

final mockDriverLocation4 = Fragment$DriverLocation(
  id: "4",
  firstName: 'John',
  lastName: 'Doe',
  location: mockCoordinateSanJose,
  mobileNumber: '1234567890',
  rating: 86,
  lastUpdatedAt: DateTime.now().subtract(const Duration(minutes: 5)),
);

final mockDriverLocations = [
  mockDriverLocation1,
  mockDriverLocation2,
  mockDriverLocation3,
  mockDriverLocation4,
];
