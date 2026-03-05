import 'package:image_faker/image_faker.dart';

import 'package:admin_frontend/core/graphql/fragments/driver.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/fleet.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/media.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/payment_gateway_compact.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/saved_payment_method.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/session_info.fragment.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/wallet.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

final mockFleetListItem1 = Fragment$fleetListItem(
  id: "1",
  name: "Big Brother",
  isBlocked: false,
  mobileNumber: "16505551234",
  profilePicture: ImageFaker().taxiCompanyLogo.logo1.toMedia,
  wallet: [
    Fragment$fleetListItem$wallet(balance: 100.0, currency: "USD"),
    Fragment$fleetListItem$wallet(balance: 180.0, currency: "ERU"),
    Fragment$fleetListItem$wallet(balance: 50.0, currency: "CAD"),
  ],
  driversAggregate: [
    Fragment$fleetListItem$driversAggregate(
      count: Fragment$fleetListItem$driversAggregate$count(id: 10),
    ),
  ],
);

final mockFleetListItem2 = Fragment$fleetListItem(
  id: "2",
  name: "Small Brother",
  isBlocked: false,
  mobileNumber: "16505551234",
  profilePicture: ImageFaker().taxiCompanyLogo.logo1.toMedia,
  wallet: [
    Fragment$fleetListItem$wallet(balance: 259.0, currency: "ERU"),
    Fragment$fleetListItem$wallet(balance: 200.0, currency: "USD"),
    Fragment$fleetListItem$wallet(balance: 600.0, currency: "CAD"),
  ],
  driversAggregate: [
    Fragment$fleetListItem$driversAggregate(
      count: Fragment$fleetListItem$driversAggregate$count(id: 20),
    ),
  ],
);

final mockFleetList = [mockFleetListItem1, mockFleetListItem2];

final mockFleetDetails = Fragment$fleetDetails(
  id: "1",
  name: "TaxiGo",
  isBlocked: false,
  mobileNumber: "16505551234",
  profilePicture: ImageFaker().taxiCompanyLogo.logo1.toMedia,
  wallet: [mockFleetWallet1],
  phoneNumber: "16505551234",
  commissionShareFlat: 0,
  commissionSharePercent: 10,
  accountNumber: "1234567890",
);

final mockFleetTransaction1 = Fragment$fleetTransaction(
  id: '1',
  fleetId: '1',
  transactionTimestamp: DateTime(2021, 1, 1, 1, 2, 3),
  action: Enum$TransactionAction.Recharge,
  amount: 500,
  currency: 'USD',
  rechargeType: Enum$ProviderRechargeTransactionType.Commission,
  refrenceNumber: '1021123',
  status: Enum$TransactionStatus.Canceled,
);

final mockFleetTransaction2 = Fragment$fleetTransaction(
  id: '2',
  fleetId: '2',
  transactionTimestamp: DateTime(2022, 1, 2, 2, 3, 4),
  action: Enum$TransactionAction.Deduct,
  amount: -80,
  currency: 'USD',
  rechargeType: Enum$ProviderRechargeTransactionType.Commission,
  refrenceNumber: '1021123',
  status: Enum$TransactionStatus.Done,
);

final mockFleetTransaction3 = Fragment$fleetTransaction(
  id: '3',
  fleetId: '3',
  transactionTimestamp: DateTime(2023, 2, 3, 3, 4, 5),
  action: Enum$TransactionAction.$unknown,
  amount: -200,
  currency: 'USD',
  rechargeType: Enum$ProviderRechargeTransactionType.Commission,
  refrenceNumber: '1021123',
  status: Enum$TransactionStatus.Processing,
);

final mockFleetTransaction4 = Fragment$fleetTransaction(
  id: '4',
  fleetId: '4',
  transactionTimestamp: DateTime(2024, 3, 4, 4, 5, 6),
  action: Enum$TransactionAction.Recharge,
  amount: 200,
  currency: 'USD',
  rechargeType: Enum$ProviderRechargeTransactionType.Commission,
  refrenceNumber: '1021123',
  status: Enum$TransactionStatus.Rejected,
);

final mockFleetTransactionList = [
  mockFleetTransaction1,
  mockFleetTransaction2,
  mockFleetTransaction3,
  mockFleetTransaction4,
];

final mockFleetWallet1 = Fragment$fleetWallet(balance: 1, currency: 'USD');
final mockFleetWallet2 = Fragment$fleetWallet(balance: 2, currency: 'EUR');
final mockFleetWallet3 = Fragment$fleetWallet(balance: 3, currency: 'CAD');
final mockFleetWallet4 = Fragment$fleetWallet(balance: 4, currency: 'GBP');

final mockFleetWalletList = [
  mockFleetWallet1,
  mockFleetWallet2,
  mockFleetWallet3,
  mockFleetWallet4,
];

final mockFleetStaff1 = Fragment$fleetStaffs(
  fleetId: '1',
  id: '1',
  mobileNumber: '16505551234',
  registeredAt: DateTime.now().subtract(const Duration(days: 3)),
  firstName: 'John',
  lastName: 'Doe',
  isBlocked: false,
  permissionFinancial: Enum$FleetStaffPermissionOrder.CAN_VIEW,
  password: '1234',
  permissionOrder: Enum$FleetStaffPermissionOrder.CAN_VIEW,
  phoneNumber: '1234567890',
  userName: 'JohnDoe',
  address: '123, 4th Street, New York',
  profileImage: ImageFaker().person.random().toMedia,
);

final mockFleetStaff2 = Fragment$fleetStaffs(
  fleetId: '1',
  id: '1',
  mobileNumber: '16505551234',
  registeredAt: DateTime.now().subtract(const Duration(days: 3)),
  firstName: 'Wilson',
  lastName: 'Torff',
  isBlocked: false,
  permissionFinancial: Enum$FleetStaffPermissionOrder.$unknown,
  password: '1234',
  permissionOrder: Enum$FleetStaffPermissionOrder.$unknown,
  phoneNumber: '16505551234',
  userName: 'WilsonTorff',
  address: '123, 4th Street, New York',
  profileImage: ImageFaker().person.random().toMedia,
);

final mockFleetStaff3 = Fragment$fleetStaffs(
  fleetId: '1',
  id: '1',
  registeredAt: DateTime.now().subtract(const Duration(days: 3)),
  mobileNumber: '16505551234',
  firstName: 'Carter',
  lastName: 'Workman',
  isBlocked: true,
  permissionFinancial: Enum$FleetStaffPermissionOrder.CAN_EDIT,
  password: '1234',
  permissionOrder: Enum$FleetStaffPermissionOrder.CAN_EDIT,
  phoneNumber: '1234567890',
  userName: 'CarterWorkman',
  address: '123, 4th Street, New York',
  profileImage: ImageFaker().person.random().toMedia,
);

final mockFLeetStaffsList = [mockFleetStaff1, mockFleetStaff2, mockFleetStaff3];

final mockStaffSession1 = Fragment$fleetStaffSessions(
  id: "1",
  sessionInfo: mockSessionInfo1,
);

final mockStaffSession2 = Fragment$fleetStaffSessions(
  id: "2",
  sessionInfo: mockSessionInfo2,
);

final mockFleetStaffSessionList = [mockStaffSession1, mockStaffSession2];

final mockFleetOrderListItem1 = Fragment$fleetOrderListItem(
  id: "1",
  createdOn: DateTime.now().subtract(const Duration(hours: 3)),
  expectedTimestamp: DateTime.now().add(const Duration(hours: 1)),
  paymentMode: Enum$PaymentMode.Wallet,
  paymentGateway: mockPaymentGatewayCompact1,
  driver: mockDriverName1,
  addresses: ['1234 NW Bobcat Lane, St. Robert, MO 65584-5678'],
  costAfterCoupon: 100,
  currency: "USD",
  status: Enum$OrderStatus.RiderCanceled,
);

final mockFleetOrderListItem2 = Fragment$fleetOrderListItem(
  id: "2",
  createdOn: DateTime.now().subtract(const Duration(hours: 3)),
  expectedTimestamp: DateTime.now().add(const Duration(hours: 1)),
  paymentMode: Enum$PaymentMode.$unknown,
  savedPaymentMethod: mockSavedPaymentMethodVisa,
  driver: mockDriverName1,
  addresses: ['1234 NW Bobcat Lane, St. Robert, MO 65584-5678'],
  costAfterCoupon: 100,
  currency: "USD",
  status: Enum$OrderStatus.Finished,
);

final mockFleetOrderListItem3 = Fragment$fleetOrderListItem(
  id: "3",
  createdOn: DateTime.now().subtract(const Duration(hours: 3)),
  expectedTimestamp: DateTime.now().add(const Duration(hours: 1)),
  paymentMode: Enum$PaymentMode.Wallet,
  driver: mockDriverName2,
  addresses: ['1234 NW Bobcat Lane, St. Robert, MO 65584-5678'],
  costAfterCoupon: 100,
  currency: "USD",
  status: Enum$OrderStatus.DriverAccepted,
);
final mockFleetOrderListItem4 = Fragment$fleetOrderListItem(
  id: "4",
  createdOn: DateTime.now().subtract(const Duration(hours: 3)),
  expectedTimestamp: DateTime.now().add(const Duration(hours: 1)),
  paymentMode: Enum$PaymentMode.PaymentGateway,
  paymentGateway: mockPaymentGatewayCompact2,
  driver: mockDriverName3,
  addresses: ['1234 NW Bobcat Lane, St. Robert, MO 65584-5678'],
  costAfterCoupon: 100,
  currency: "USD",
  status: Enum$OrderStatus.Arrived,
);
final mockFleetOrderListItem5 = Fragment$fleetOrderListItem(
  id: "5",
  createdOn: DateTime.now().subtract(const Duration(hours: 3)),
  expectedTimestamp: DateTime.now().add(const Duration(hours: 1)),
  paymentMode: Enum$PaymentMode.SavedPaymentMethod,
  savedPaymentMethod: mockSavedPaymentMethodMasterCard,
  driver: mockDriverName4,
  addresses: ['1234 NW Bobcat Lane, St. Robert, MO 65584-5678'],
  costAfterCoupon: 100,
  currency: "USD",
  status: Enum$OrderStatus.DriverCanceled,
);

final mockFleetOrderListItems = [
  mockFleetOrderListItem1,
  mockFleetOrderListItem2,
  mockFleetOrderListItem3,
  mockFleetOrderListItem4,
  mockFleetOrderListItem5,
];
