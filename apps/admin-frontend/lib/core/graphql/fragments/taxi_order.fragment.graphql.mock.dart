import 'package:admin_frontend/core/graphql/fragments/coordinate.fragment.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/payment_method.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/staff.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/taxi_order.fragment.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';
import 'package:image_faker/image_faker.dart';
import 'package:time/time.dart';

final mockAddresses = [
  "1600 Amphitheatre Pkwy, Mountain View, CA 94043, USA",
  "1600 Amphitheatre Pkwy, Mountain View, CA 94043, USA",
  "1600 Amphitheatre Pkwy, Mountain View, CA 94043, USA",
];

final mockOrderTaxiListItem1 = Fragment$taxiOrderListItem(
  id: "1",
  createdAt: DateTime.now().subtract(const Duration(hours: 3)),
  driver: null,
  currency: "USD",
  status: Enum$OrderStatus.Requested,
  paymentMethod: mockPaymentMethod,
  rider: Fragment$taxiOrderListItem$rider(
    fullName: "fullName",
    mobileNumber: "mobileNumber",
  ),
  waypoints: [],
  totalCost: 10.5,
);

final mockOrderTaxiListItem2 = Fragment$taxiOrderListItem(
  id: "2",
  createdAt: DateTime.now().subtract(const Duration(hours: 3)),
  driver: null,
  currency: "USD",
  status: Enum$OrderStatus.Requested,
  paymentMethod: mockPaymentMethod,
  rider: Fragment$taxiOrderListItem$rider(
    fullName: "fullName",
    mobileNumber: "mobileNumber",
  ),
  waypoints: [],
  totalCost: 10.5,
);

final mockOrderTaxiListItem3 = Fragment$taxiOrderListItem(
  id: "3",
  createdAt: DateTime.now().subtract(const Duration(hours: 3)),
  driver: null,
  currency: "USD",
  status: Enum$OrderStatus.Requested,
  paymentMethod: mockPaymentMethod,
  rider: Fragment$taxiOrderListItem$rider(
    fullName: "fullName",
    mobileNumber: "mobileNumber",
  ),
  waypoints: [],
  totalCost: 10.5,
);

final mockOrderTaxiListItem4 = Fragment$taxiOrderListItem(
  id: "4",
  createdAt: DateTime.now().subtract(const Duration(hours: 3)),
  driver: null,
  currency: "USD",
  status: Enum$OrderStatus.Requested,
  paymentMethod: mockPaymentMethod,
  rider: Fragment$taxiOrderListItem$rider(
    fullName: "fullName",
    mobileNumber: "mobileNumber",
  ),
  waypoints: [],
  totalCost: 10.5,
);

final mockOrderTaxiListItem5 = Fragment$taxiOrderListItem(
  id: "5",
  createdAt: DateTime.now().subtract(const Duration(hours: 3)),
  driver: null,
  currency: "USD",
  status: Enum$OrderStatus.Requested,
  paymentMethod: mockPaymentMethod,
  rider: Fragment$taxiOrderListItem$rider(
    fullName: "fullName",
    mobileNumber: "mobileNumber",
  ),
  waypoints: [],
  totalCost: 10.5,
);

final mockOrderTaxiListItem6 = Fragment$taxiOrderListItem(
  id: "6",
  createdAt: DateTime.now().subtract(const Duration(hours: 3)),
  driver: null,
  currency: "USD",
  status: Enum$OrderStatus.Requested,
  paymentMethod: mockPaymentMethod,
  rider: Fragment$taxiOrderListItem$rider(
    fullName: "fullName",
    mobileNumber: "mobileNumber",
  ),
  waypoints: [],
  totalCost: 10.5,
);

final mockOrderTaxiListItems = [
  mockOrderTaxiListItem1,
  mockOrderTaxiListItem2,
  mockOrderTaxiListItem3,
  mockOrderTaxiListItem4,
  mockOrderTaxiListItem5,
  mockOrderTaxiListItem6,
];

final mockTaxiOrderActivitiesList = [
  Fragment$taxiOrderActivity(
    id: '1',
    createdAt: 2.hours.ago,
    type: Enum$RequestActivityType.RequestedByRider,
  ),
  Fragment$taxiOrderActivity(
    id: '2',
    createdAt: 54.minutes.ago,
    type: Enum$RequestActivityType.DriverAccepted,
  ),
  Fragment$taxiOrderActivity(
    id: '3',
    createdAt: 45.minutes.ago,
    type: Enum$RequestActivityType.ArrivedToPickupPoint,
  ),
];

final mockOrdersItem1 = Fragment$taxiOrderDetail(
  id: "1",
  options: [],
  activities: [],
  driversSentTo: 4,
  service: Fragment$taxiOrderDetail$service(
    name: "Economy",
    imageUrl: ImageFaker().taxiService.bikeYellow,
  ),
  directions: [mockCoordinateSanFrancisco, mockCoordinateSanJose],

  createdAt: DateTime.now().subtract(const Duration(hours: 3)),
  driver: null,
  currency: "USD",
  status: Enum$OrderStatus.Requested,
  rider: Fragment$taxiOrderDetail$rider(
    fullName: "fullName",
    mobileNumber: "mobileNumber",
  ),
  waypoints: [],
  totalCost: 10.5,
  paymentMethod: mockPaymentMethod,
  chatMessages: [],
);

final mockConversation1 = Fragment$conversation(
  id: '1',
  sentAt: DateTime.now(),
  sentByDriver: true,
  status: Enum$MessageStatus.Seen,
  content:
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
);
final mockConversation2 = Fragment$conversation(
  id: '2',
  sentAt: DateTime.now(),
  sentByDriver: true,
  status: Enum$MessageStatus.Sent,
  content:
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
);
final mockConversation3 = Fragment$conversation(
  id: '3',
  sentAt: DateTime.now(),
  sentByDriver: false,
  status: Enum$MessageStatus.Delivered,
  content:
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
);

final mockListConversations = [
  mockConversation1,
  mockConversation2,
  mockConversation3,
];

final mockNote1 = Fragment$taxiOrderNote(
  id: '1',
  staff: mockStaffDetails,
  createdAt: DateTime.now().subtract(const Duration(hours: 3)),
  note:
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
  orderId: '1',
);
final mockNote2 = Fragment$taxiOrderNote(
  id: '2',
  staff: mockStaffDetails,
  createdAt: DateTime.now().subtract(const Duration(hours: 2, minutes: 30)),
  note:
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
  orderId: '1',
);
final mockNote3 = Fragment$taxiOrderNote(
  id: '3',
  staff: mockStaffDetails,
  createdAt: DateTime.now().subtract(const Duration(hours: 2)),
  note:
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
  orderId: '1',
);

final mockListNote = [mockNote1, mockNote2, mockNote3];
