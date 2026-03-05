import 'package:admin_frontend/core/graphql/fragments/customer.fragment.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/parking.fragment.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/parking_order.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/payment_gateway_compact.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/saved_payment_method.graphql.mock.dart';
import 'package:admin_frontend/schema.graphql.dart';

final mockParkingOrderActivitiesList = [
  Fragment$parkingOrderActivities(
    id: '1',
    status: Enum$ParkOrderStatus.ACCEPTED,
    updatedAt: DateTime.now().subtract(const Duration(days: 3)),
  ),
  Fragment$parkingOrderActivities(
    id: '2',
    status: Enum$ParkOrderStatus.PENDING,
    updatedAt: DateTime.now().subtract(const Duration(days: 2)),
  ),
  Fragment$parkingOrderActivities(
    id: '3',
    status: Enum$ParkOrderStatus.PAID,
    updatedAt: DateTime.now().subtract(const Duration(days: 1)),
  ),
];

// final mockParkingOrderListItem1 = Fragment$parkingOrderListItem(
//   id: "1",
//   createdAt: DateTime.now().subtract(const Duration(hours: 3)),
//   price: 100,
//   currency: "USD",
//   paymentMethod: Enum$PaymentMode.Cash,
//   status: Enum$ParkOrderStatus.ACCEPTED,
//   parkSpot: mockParkingCompact1,
//   carOwner: mockCustomerListItem5,
//   activities: mockParkingOrderActivitiesList,
//   savedPaymentMethod: mockSavedPaymentMethodMasterCard,
//   paymentGateway: mockPaymentGatewayCompact1,
// );

final mockParkingOrderDetail = Fragment$parkingOrderDetail(
  id: '1',
  createdAt: DateTime.now().subtract(const Duration(days: 1)),
  price: 130,
  currency: "USD",
  paymentMode: Enum$PaymentMode.Cash,
  status: Enum$ParkOrderStatus.ACCEPTED,
  parkSpot: mockParkingCompact1,
  carOwner: mockCustomerListItem5,
  activities: mockParkingOrderActivitiesList,
  exitTime: DateTime.now().subtract(const Duration(hours: 3)),
  enterTime: DateTime.now().subtract(const Duration(hours: 6)),
  carSize: Enum$ParkSpotCarSize.LARGE,
  paymentGateway: mockPaymentGatewayCompact1,
  savedPaymentMethod: mockSavedPaymentMethodVisa,
  vehicleType: Enum$ParkSpotVehicleType.Bike,
);

final mockParkingOrderListItem1 = Fragment$parkingOrderListItem(
  id: "1",
  createdAt: DateTime.now().subtract(const Duration(hours: 3)),
  vehicleType: Enum$ParkSpotVehicleType.Car,
  enterTime: DateTime.now().subtract(const Duration(hours: 6)),
  exitTime: DateTime.now().subtract(const Duration(hours: 3)),
  price: 100,
  currency: "USD",
  paymentMode: Enum$PaymentMode.Cash,
  status: Enum$ParkOrderStatus.ACCEPTED,
  parkSpot: mockParkingCompact1,
  carOwner: mockCustomerListItem5,
  paymentGateway: mockPaymentGatewayCompact1,
  savedPaymentMethod: mockSavedPaymentMethodVisa,
);

final mockParkingOrderListItem2 = Fragment$parkingOrderListItem(
  id: "2",
  createdAt: DateTime.now().subtract(const Duration(hours: 2)),
  price: 200,
  vehicleType: Enum$ParkSpotVehicleType.Car,
  enterTime: DateTime.now().subtract(const Duration(hours: 6)),
  exitTime: DateTime.now().subtract(const Duration(hours: 3)),
  currency: "USD",
  paymentMode: Enum$PaymentMode.Cash,
  status: Enum$ParkOrderStatus.CANCELLED,
  parkSpot: mockParkingCompact1,
  carOwner: mockCustomerListItem1,
  paymentGateway: mockPaymentGatewayCompact1,
  savedPaymentMethod: mockSavedPaymentMethodVisa,
);

final mockParkingOrderListItem3 = Fragment$parkingOrderListItem(
  id: "3",
  createdAt: DateTime.now().subtract(const Duration(hours: 1)),
  price: 300,
  currency: "USD",
  vehicleType: Enum$ParkSpotVehicleType.Car,
  enterTime: DateTime.now().subtract(const Duration(hours: 6)),
  exitTime: DateTime.now().subtract(const Duration(hours: 3)),
  paymentMode: Enum$PaymentMode.PaymentGateway,
  status: Enum$ParkOrderStatus.COMPLETED,
  parkSpot: mockParkingCompact2,
  carOwner: mockCustomerListItem2,
  paymentGateway: mockPaymentGatewayCompact1,
  savedPaymentMethod: mockSavedPaymentMethodVisa,
);

final mockParkingOrderListItem4 = Fragment$parkingOrderListItem(
  id: "4",
  createdAt: DateTime.now(),
  price: 400,
  currency: "USD",
  vehicleType: Enum$ParkSpotVehicleType.Car,
  enterTime: DateTime.now().subtract(const Duration(hours: 6)),
  exitTime: DateTime.now().subtract(const Duration(hours: 3)),
  paymentMode: Enum$PaymentMode.SavedPaymentMethod,
  status: Enum$ParkOrderStatus.PAID,
  parkSpot: mockParkingCompact2,
  carOwner: mockCustomerListItem3,
  paymentGateway: mockPaymentGatewayCompact1,
  savedPaymentMethod: mockSavedPaymentMethodVisa,
);

final mockParkingOrderListItem5 = Fragment$parkingOrderListItem(
  id: "5",
  createdAt: DateTime.now().subtract(const Duration(minutes: 30)),
  price: 500,
  currency: "USD",
  vehicleType: Enum$ParkSpotVehicleType.Car,
  enterTime: DateTime.now().subtract(const Duration(hours: 6)),
  exitTime: DateTime.now().subtract(const Duration(hours: 3)),
  paymentMode: Enum$PaymentMode.SavedPaymentMethod,
  status: Enum$ParkOrderStatus.REJECTED,
  parkSpot: mockParkingCompact1,
  carOwner: mockCustomerListItem3,
  paymentGateway: mockPaymentGatewayCompact1,
  savedPaymentMethod: mockSavedPaymentMethodVisa,
);

final mockParkingOrderListItem6 = Fragment$parkingOrderListItem(
  id: "6",
  createdAt: DateTime.now().subtract(const Duration(minutes: 15)),
  price: 600,
  currency: "USD",
  vehicleType: Enum$ParkSpotVehicleType.Car,
  enterTime: DateTime.now().subtract(const Duration(hours: 6)),
  exitTime: DateTime.now().subtract(const Duration(hours: 3)),
  paymentMode: Enum$PaymentMode.SavedPaymentMethod,
  status: Enum$ParkOrderStatus.PENDING,
  parkSpot: mockParkingCompact1,
  carOwner: mockCustomerListItem4,
  paymentGateway: mockPaymentGatewayCompact1,
  savedPaymentMethod: mockSavedPaymentMethodVisa,
);

final mockParkingOrderListItem7 = Fragment$parkingOrderListItem(
  id: "7",
  createdAt: DateTime.now().subtract(const Duration(minutes: 10)),
  price: 700,
  currency: "USD",
  vehicleType: Enum$ParkSpotVehicleType.Car,
  enterTime: DateTime.now().subtract(const Duration(hours: 6)),
  exitTime: DateTime.now().subtract(const Duration(hours: 3)),
  paymentMode: Enum$PaymentMode.Wallet,
  status: Enum$ParkOrderStatus.PENDING,
  parkSpot: mockParkingCompact2,
  carOwner: mockCustomerListItem4,
  paymentGateway: mockPaymentGatewayCompact1,
  savedPaymentMethod: mockSavedPaymentMethodVisa,
);

final mockParkingOrderListItems = [
  mockParkingOrderListItem1,
  mockParkingOrderListItem2,
  mockParkingOrderListItem3,
  mockParkingOrderListItem4,
  mockParkingOrderListItem5,
  mockParkingOrderListItem6,
  mockParkingOrderListItem7,
];
