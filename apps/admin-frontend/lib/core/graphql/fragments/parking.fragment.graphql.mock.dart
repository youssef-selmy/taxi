import 'package:image_faker/image_faker.dart';

import 'package:admin_frontend/core/graphql/fragments/coordinate.fragment.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/customer.fragment.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/media.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/parking.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/rating_aggregate.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/wallet.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/weekday_schedule.fragment.graphql.mock.dart';
import 'package:admin_frontend/schema.graphql.dart';

final mockParkingCompact1 = Fragment$parkingCompact(
  id: "1",
  address: "1234 NW Bobcat Lane, St. Robert, MO 65584-5678",
  mainImage: ImageFaker().parkingLogo.logo1.toMedia,
  phoneNumber: '11234566787',
  type: Enum$ParkSpotType.PERSONAL,
  location: mockCoordinateSanFrancisco,
  carSpaces: 2,
);

final mockParkingCompact2 = Fragment$parkingCompact(
  id: "2",
  name: "Parking 2",
  mainImage: ImageFaker().parkingLogo.logo1.toMedia,
  phoneNumber: '11234566787',
  type: Enum$ParkSpotType.PUBLIC,
  location: mockCoordinateSanFrancisco,
  carSpaces: 3,
);

final mockParkingListItem1 = Fragment$parkingListItem(
  id: "1",
  name: "Parking 1",
  address: "1234 NW Bobcat Lane, St. Robert, MO 65584-5678",
  createdAt: DateTime.now().subtract(const Duration(days: 10, hours: 5)),
  ratingAggregate: mockRatingAggregateHigh,
  status: Enum$ParkSpotStatus.Active,
  type: Enum$ParkSpotType.PERSONAL,
  phoneNumber: "16505551234",
  mainImage: ImageFaker().parkingLogo.logo1.toMedia,
  owner: Fragment$parkingListItem$owner(parkingWallets: mockParkingWallets),
  parkOrders: Fragment$parkingListItem$parkOrders(totalCount: 42),
);

final mockParkingListItem2 = Fragment$parkingListItem(
  id: "2",
  name: "Parking 2",
  address: "1234 NW Bobcat Lane, St. Robert, MO 65584-5678",
  createdAt: DateTime.now().subtract(const Duration(days: 10, hours: 5)),
  ratingAggregate: mockRatingAggregateHigh,
  status: Enum$ParkSpotStatus.Inactive,
  type: Enum$ParkSpotType.PUBLIC,
  phoneNumber: "16505551234",
  mainImage: ImageFaker().parkingLogo.logo1.toMedia,
  owner: Fragment$parkingListItem$owner(parkingWallets: mockParkingWallets),
  parkOrders: Fragment$parkingListItem$parkOrders(totalCount: 31),
);

final mockParkingListItem3 = Fragment$parkingListItem(
  id: "3",
  name: "Parking 3",
  address: "1234 NW Bobcat Lane, St. Robert, MO 65584-5678",
  createdAt: DateTime.now().subtract(const Duration(days: 10, hours: 5)),
  ratingAggregate: mockRatingAggregateHigh,
  status: Enum$ParkSpotStatus.Pending,
  type: Enum$ParkSpotType.PUBLIC,
  phoneNumber: "16505551234",
  mainImage: ImageFaker().parkingLogo.logo1.toMedia,
  owner: Fragment$parkingListItem$owner(parkingWallets: mockParkingWallets),
  parkOrders: Fragment$parkingListItem$parkOrders(totalCount: 12),
);

final mockParkingListItem4 = Fragment$parkingListItem(
  id: "4",
  name: "Parking 4",
  address: "1234 NW Bobcat Lane, St. Robert, MO 65584-5678",
  createdAt: DateTime.now().subtract(const Duration(days: 10, hours: 5)),
  ratingAggregate: mockRatingAggregateHigh,
  status: Enum$ParkSpotStatus.Active,
  type: Enum$ParkSpotType.PERSONAL,
  phoneNumber: "16505551234",
  mainImage: ImageFaker().parkingLogo.logo1.toMedia,
  owner: Fragment$parkingListItem$owner(parkingWallets: mockParkingWallets),
  parkOrders: Fragment$parkingListItem$parkOrders(totalCount: 32),
);

final mockParkingListItems = [
  mockParkingListItem1,
  mockParkingListItem2,
  mockParkingListItem3,
  mockParkingListItem4,
];

final mockParkSpotDetail = Fragment$parkSpotDetail(
  id: "1",
  name: "Parking 1",
  type: Enum$ParkSpotType.PUBLIC,
  status: Enum$ParkSpotStatus.Pending,
  location: mockCoordinateSanFrancisco,
  currency: "EUR",
  ratingAggregate: mockRatingAggregateHigh,
  weeklySchedule: [mockWeekdaySchedule1, mockWeekdaySchedule2],
  email: "john@doe.com",
  phoneNumber: "16505551234",
  owner: mockCustomerDetail,
  createdAt: DateTime.now().subtract(const Duration(days: 10, hours: 5)),
  lastActivityAt: DateTime.now().subtract(const Duration(hours: 2)),
  facilities: [Enum$ParkSpotFacility.CCTV],
  mainImage: ImageFaker().parkingLogo.logo1.toMedia,
  images: [ImageFaker().parkingLogo.logo1.toMedia],
  carSpaces: 5,
  carPrice: 10,
  bikeSpaces: 2,
  bikePrice: 7,
  truckSpaces: 1,
  truckPrice: 15,
  address: "1234 NW Bobcat Lane, St. Robert, MO 65584-5678",
  openHour: "08:00",
  closeHour: "20:00",
);
