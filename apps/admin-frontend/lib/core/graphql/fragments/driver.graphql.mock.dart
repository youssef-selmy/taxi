import 'package:image_faker/image_faker.dart';

import 'package:admin_frontend/core/graphql/fragments/driver.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/insights.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/media.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/taxi_pricing.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/wallet.graphql.mock.dart';
import 'package:admin_frontend/schema.graphql.dart';

final mockDriverName1 = Fragment$DriverName(
  id: "1",
  firstName: "John",
  lastName: "Doe",
  mobileNumber: "16505551234",
  countryIso: "US",
  media: ImageFaker().person.random().toMedia,
  status: Enum$DriverStatus.Blocked,
  registrationTimestamp: DateTime.now().subtract(const Duration(days: 10)),
  lastSeenTimestamp: DateTime.now().subtract(const Duration(hours: 2)),
  rating: 84,
);

final mockDriverName2 = Fragment$DriverName(
  id: "2",
  firstName: "Jane",
  lastName: "Doe",
  mobileNumber: "16505551234",
  countryIso: "US",
  media: ImageFaker().person.random().toMedia,
  status: Enum$DriverStatus.HardReject,
  registrationTimestamp: DateTime.now().subtract(const Duration(days: 1)),
);

final mockDriverName3 = Fragment$DriverName(
  id: "3",
  firstName: "John",
  lastName: "Doe",
  mobileNumber: "16505551234",
  countryIso: "US",
  media: ImageFaker().person.random().toMedia,
  status: Enum$DriverStatus.Online,
  registrationTimestamp: DateTime.now().subtract(const Duration(days: 1)),
);

final mockDriverName4 = Fragment$DriverName(
  id: "4",
  firstName: "Jane",
  lastName: "Doe",
  mobileNumber: "16505551234",
  countryIso: "US",
  media: ImageFaker().person.random().toMedia,
  status: Enum$DriverStatus.Offline,
  registrationTimestamp: DateTime.now().subtract(const Duration(days: 1)),
);

final mockDriverName5 = Fragment$DriverName(
  id: "5",
  firstName: "John",
  lastName: "Doe",
  mobileNumber: "16505551234",
  countryIso: "US",
  media: ImageFaker().person.random().toMedia,
  status: Enum$DriverStatus.PendingApproval,
  registrationTimestamp: DateTime.now().subtract(const Duration(days: 1)),
);

final mockDriverList = [
  mockDriverName1,
  mockDriverName2,
  mockDriverName3,
  mockDriverName4,
  mockDriverName5,
];

final mockDriverListItem1 = Fragment$driverListItem(
  id: "1",
  firstName: "John",
  lastName: "Doe",
  mobileNumber: "16505551234",
  countryIso: "US",
  registrationTimestamp: DateTime.now().subtract(const Duration(days: 20)),
  status: Enum$DriverStatus.Online,
  wallet: mockDriverWallets,
  orders: Fragment$driverListItem$orders(totalCount: 100),
  media: ImageFaker().person.random().toMedia,
  rating: 63,
  lastSeenTimestamp: DateTime.now(),
);

final mockDriverListItem2 = Fragment$driverListItem(
  id: "2",
  firstName: "Jane",
  lastName: "Doe",
  mobileNumber: "16505551234",
  countryIso: "US",
  registrationTimestamp: DateTime.now().subtract(const Duration(days: 534)),
  status: Enum$DriverStatus.Online,
  wallet: mockDriverWallets,
  orders: Fragment$driverListItem$orders(totalCount: 23),
  media: ImageFaker().person.random().toMedia,
  rating: 85,
  lastSeenTimestamp: DateTime.now().subtract(const Duration(hours: 2)),
);

final mockDriverListItem3 = Fragment$driverListItem(
  id: "3",
  firstName: "Wilson",
  lastName: "Torff",
  mobileNumber: "16505551234",
  countryIso: "US",
  registrationTimestamp: DateTime.now().subtract(const Duration(days: 41)),
  status: Enum$DriverStatus.HardReject,
  wallet: mockDriverWallets,
  orders: Fragment$driverListItem$orders(totalCount: 54),
  media: ImageFaker().person.random().toMedia,
  rating: 67,
  lastSeenTimestamp: DateTime.now().subtract(const Duration(days: 2)),
);

final mockDriverListItem4 = Fragment$driverListItem(
  id: "3",
  firstName: "John",
  lastName: "Smith",
  mobileNumber: "16505551234",
  countryIso: "US",
  registrationTimestamp: DateTime.now().subtract(const Duration(days: 10)),
  status: Enum$DriverStatus.Offline,
  wallet: mockDriverWallets,
  orders: Fragment$driverListItem$orders(totalCount: 54),
  media: ImageFaker().person.random().toMedia,
  rating: 67,
  lastSeenTimestamp: DateTime.now().subtract(const Duration(hours: 2)),
);

final mockDriverListItem5 = Fragment$driverListItem(
  id: "3",
  firstName: "John",
  lastName: "Smith",
  mobileNumber: "18885431543",
  countryIso: "US",
  registrationTimestamp: DateTime.now().subtract(const Duration(days: 10)),
  status: Enum$DriverStatus.InService,
  wallet: mockDriverWallets,
  orders: Fragment$driverListItem$orders(totalCount: 54),
  media: ImageFaker().person.random().toMedia,
  rating: 67,
  lastSeenTimestamp: DateTime.now().subtract(const Duration(hours: 2)),
);

final mockDriverListItem6 = Fragment$driverListItem(
  id: "3",
  firstName: "Sara",
  lastName: "Johnson",
  mobileNumber: "18885431543",
  countryIso: "US",
  registrationTimestamp: DateTime.now().subtract(const Duration(days: 10)),
  status: Enum$DriverStatus.PendingApproval,
  wallet: mockDriverWallets,
  orders: Fragment$driverListItem$orders(totalCount: 54),
  media: ImageFaker().person.random().toMedia,
  rating: 67,
  lastSeenTimestamp: DateTime.now().subtract(const Duration(hours: 2)),
);

final mockDriverListItem7 = Fragment$driverListItem(
  id: "3",
  firstName: "John",
  lastName: "Smith",
  mobileNumber: "18885431543",
  countryIso: "US",
  registrationTimestamp: DateTime.now().subtract(const Duration(days: 10)),
  status: Enum$DriverStatus.SoftReject,
  wallet: mockDriverWallets,
  orders: Fragment$driverListItem$orders(totalCount: 54),
  media: ImageFaker().person.random().toMedia,
  rating: 67,
  lastSeenTimestamp: DateTime.now().subtract(const Duration(hours: 2)),
);

final mockDriverListItems = [
  mockDriverListItem1,
  mockDriverListItem2,
  mockDriverListItem3,
  mockDriverListItem4,
  mockDriverListItem5,
  mockDriverListItem6,
  mockDriverListItem7,
];

final mockDriverDetail1 = Fragment$driverDetail(
  id: "1",
  firstName: "Jane",
  lastName: "Doe",
  mobileNumber: "16505551234",
  countryIso: "US",
  media: ImageFaker().person.random().toMedia,
  enabledServices: [
    Fragment$driverDetail$enabledServices(
      service: mockTaxiPricing1,
      driverEnabled: true,
    ),
    Fragment$driverDetail$enabledServices(
      service: mockTaxiPricing2,
      driverEnabled: true,
    ),
  ],
  accountNumber: '1021123',
  address: '1234 NW Bobcat Lane, St. Robert, MO 65584-5678',
  bankName: 'American bank',
  email: 'johndoe@adress.com',
  gender: Enum$Gender.Male,
  fleetId: '1',
  carId: '1',
  carColorId: '1',
  carPlate: 'Carplate314',
  bankRoutingNumber: '151352',
  bankSwift: 'AAAABBBCCDD',
  carProductionYear: 2015,
  canDeliver: true,
  maxDeliveryPackageSize: Enum$DeliveryPackageSize.Medium,
  rating: 85,
  lastSeenTimestamp: DateTime.now().subtract(const Duration(hours: 2)),
  registrationTimestamp: DateTime.now().subtract(const Duration(days: 20)),
  status: Enum$DriverStatus.Online,
);

class DriverStatisticsModel {
  List<Fragment$RevenuePerApp> tripsCompleted;
  List<Fragment$RevenuePerApp> rideAcceptance;
  List<Fragment$ActiveInactiveUsers> activeInActive;
  List<Fragment$ActiveInactiveUsers> rideCompletion;
  List<Fragment$driverListItem> performingDriver;
  List<Fragment$driverListItem> earningDriver;
  List<Fragment$CountryDistribution> earningsDistribution;
  List<Fragment$CountryDistribution> earningsOverTime;

  DriverStatisticsModel({
    required this.tripsCompleted,
    required this.rideAcceptance,
    required this.activeInActive,
    required this.rideCompletion,
    required this.performingDriver,
    required this.earningDriver,
    required this.earningsDistribution,
    required this.earningsOverTime,
  });
}
