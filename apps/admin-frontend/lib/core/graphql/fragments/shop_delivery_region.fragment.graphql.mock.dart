import 'package:admin_frontend/core/graphql/fragments/coordinate.fragment.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/shop_delivery_region.fragment.graphql.dart';

final mockShopDeliveryRegion1 = Fragment$shopDeliveryRegion(
  id: "1",
  deliveryFee: 5,
  minDeliveryTimeMinutes: 15,
  maxDeliveryTimeMinutes: 24,
  minimumOrderAmount: 20,
  enabled: true,
  location: [
    [mockCoordinateSanFrancisco, mockCoordinateSanJose],
  ],
);

final mockShopDeliveryRegion2 = Fragment$shopDeliveryRegion(
  id: "2",
  deliveryFee: 10,
  minDeliveryTimeMinutes: 20,
  maxDeliveryTimeMinutes: 30,
  minimumOrderAmount: 30,
  enabled: true,
  location: [
    [mockCoordinateSanFrancisco, mockCoordinateSanJose],
  ],
);

final mockShopDeliveryRegion3 = Fragment$shopDeliveryRegion(
  id: "3",
  deliveryFee: 15,
  minDeliveryTimeMinutes: 25,
  maxDeliveryTimeMinutes: 35,
  minimumOrderAmount: 40,
  enabled: true,
  location: [
    [mockCoordinateSanFrancisco, mockCoordinateSanJose],
  ],
);

final mockShopDeliveryRegion4 = Fragment$shopDeliveryRegion(
  id: "4",
  deliveryFee: 20,
  minDeliveryTimeMinutes: 30,
  maxDeliveryTimeMinutes: 40,
  minimumOrderAmount: 50,
  enabled: true,
  location: [
    [mockCoordinateSanFrancisco, mockCoordinateSanJose],
  ],
);

final mockShopDeliveryRegions = [
  mockShopDeliveryRegion1,
  mockShopDeliveryRegion2,
  mockShopDeliveryRegion3,
  mockShopDeliveryRegion4,
];
