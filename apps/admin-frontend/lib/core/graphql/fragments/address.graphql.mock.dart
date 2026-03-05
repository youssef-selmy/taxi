import 'package:admin_frontend/core/graphql/fragments/address.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/coordinate.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/coordinate.fragment.graphql.mock.dart';
import 'package:admin_frontend/schema.graphql.dart';

final mockAddressHome = Fragment$Address(
  id: "1",
  title: "Home",
  details: "1234 NW Bobcat Lane, St. Robert, MO 65584-5678",
  type: Enum$RiderAddressType.Home,
  location: Fragment$Coordinate(lat: 37.8283, lng: -92.145),
);
final mockAddressHome2 = Fragment$Address(
  id: "2",
  title: "Home",
  details: "1234 NW Bobcat Lane, St. Robert, MO 65584-5678",
  type: Enum$RiderAddressType.Home,
  location: mockCoordinateSeattle3,
);

final mockAddressWork = Fragment$Address(
  id: "2",
  title: "Work",
  details: "1234 NW Bobcat Lane, St. Robert, MO 65584-5678",
  type: Enum$RiderAddressType.Work,
  location: Fragment$Coordinate(lat: 37.8283, lng: -92.145),
);

final mockAddressPartner = Fragment$Address(
  id: "3",
  title: "Partner",
  details: "1234 NW Bobcat Lane, St. Robert, MO 65584-5678",
  type: Enum$RiderAddressType.Partner,
  location: Fragment$Coordinate(lat: 37.8283, lng: -92.145),
);

final mockAddressGym = Fragment$Address(
  id: "4",
  title: "Gym",
  details: "1234 NW Bobcat Lane, St. Robert, MO 65584-5678",
  type: Enum$RiderAddressType.Gym,
  location: Fragment$Coordinate(lat: 37.8283, lng: -92.145),
);

final mockAddressParent = Fragment$Address(
  id: "5",
  title: "Parent",
  details: "1234 NW Bobcat Lane, St. Robert, MO 65584-5678",
  type: Enum$RiderAddressType.Parent,
  location: Fragment$Coordinate(lat: 37.8283, lng: -92.145),
);

final mockAddressCafe = Fragment$Address(
  id: "6",
  title: "Cafe",
  details: "1234 NW Bobcat Lane, St. Robert, MO 65584-5678",
  type: Enum$RiderAddressType.Cafe,
  location: Fragment$Coordinate(lat: 37.8283, lng: -92.145),
);

final mockAddressPark = Fragment$Address(
  id: "7",
  title: "Park",
  details: "1234 NW Bobcat Lane, St. Robert, MO 65584-5678",
  type: Enum$RiderAddressType.Park,
  location: Fragment$Coordinate(lat: 37.8283, lng: -92.145),
);

final mockAddressOther = Fragment$Address(
  id: "8",
  title: "Other",
  details: "1234 NW Bobcat Lane, St. Robert, MO 65584-5678",
  type: Enum$RiderAddressType.Other,
  location: Fragment$Coordinate(lat: 37.8283, lng: -92.145),
);

final mockAddresses = [
  mockAddressHome,
  mockAddressWork,
  mockAddressPartner,
  mockAddressGym,
  mockAddressParent,
  mockAddressCafe,
  mockAddressPark,
  mockAddressOther,
];
