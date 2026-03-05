import 'package:image_faker/image_faker.dart';

import 'package:admin_frontend/core/graphql/fragments/coordinate.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/coordinate.fragment.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/media.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/mobile_number.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/personal_info.fragment.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/rating_aggregate.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/shop.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/shop_category.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/shop_category.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/wallet.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/weekday_schedule.fragment.graphql.mock.dart';
import 'package:admin_frontend/schema.graphql.dart';

Fragment$DispatcherShop get mockFragmentShop => Fragment$DispatcherShop(
  id: "1",
  name: "Master Chef",
  currency: "USD",
  status: Enum$ShopStatus.Active,
  location: Fragment$Coordinate(lat: 37.234312, lng: -122.4324),
  ratingAggregate: mockRatingAggregateHigh,
  deliveryFee: 5,
  minDeliveryTime: 10,
  maxDeliveryTime: 15,
  minimumOrderAmount: 10,
  image: ImageFaker().shop.logo.masterChef.toMedia,
);

Fragment$shopBasic get mockFragmentShopBasic1 => Fragment$shopBasic(
  id: "1",
  name: "Master Chef",
  image: ImageFaker().shop.logo.masterChef.toMedia,
  categories: [
    Fragment$shopBasic$categories(name: "Restaurant"),
    Fragment$shopBasic$categories(name: "Fast Food"),
  ],
  location: mockCoordinateSanFrancisco,
  currency: 'USD',
  address: 'Bobcat Lane, St. Robert, MO 65584-5678',
  createdAt: DateTime.now().subtract(const Duration(hours: 1)),
  ratingAggregate: mockRatingAggregateHigh,
);

Fragment$shopBasic get mockFragmentShopBasic2 => Fragment$shopBasic(
  id: "2",
  name: "KFC",
  image: ImageFaker().shop.logo.masterChef.toMedia,
  categories: [
    Fragment$shopBasic$categories(name: "Restaurant"),
    Fragment$shopBasic$categories(name: "Fast Food"),
  ],
  location: mockCoordinateSanJose,
  currency: 'USD',
  address: 'Bobcat Lane, St. Robert, MO 65584-5678',
  createdAt: DateTime.now().subtract(const Duration(days: 2)),
  ratingAggregate: mockRatingAggregateHigh,
);

Fragment$shopBasic get mockFragmentShopBasic3 => Fragment$shopBasic(
  id: "1",
  name: "Master Chef",
  image: ImageFaker().shop.logo.masterChef.toMedia,
  categories: [
    Fragment$shopBasic$categories(name: "Restaurant"),
    Fragment$shopBasic$categories(name: "Fast Food"),
  ],
  location: mockCoordinateSeattle1,
  currency: 'USD',
  address: 'Bobcat Lane, St. Robert, MO 65584-5678',
  createdAt: DateTime.now().subtract(const Duration(days: 3)),
  ratingAggregate: mockRatingAggregateHigh,
);

Fragment$shopBasic get mockFragmentShopBasic4 => Fragment$shopBasic(
  id: "2",
  name: "KFC",
  image: ImageFaker().shop.logo.masterChef.toMedia,
  categories: [
    Fragment$shopBasic$categories(name: "Restaurant"),
    Fragment$shopBasic$categories(name: "Fast Food"),
  ],
  location: mockCoordinateSeattle2,
  currency: 'USD',
  address: 'Bobcat Lane, St. Robert, MO 65584-5678',
  createdAt: DateTime.now().subtract(const Duration(days: 6)),
  ratingAggregate: mockRatingAggregateHigh,
);

final mockShopBasicInfo1 = Fragment$shopBasicInfo(
  id: "1",
  name: "Olive Garden",
  mobileNumber: mockMobileNumber,
  image: ImageFaker().shop.logo.masterChef.toMedia,
);

final mockShopBasicInfo2 = Fragment$shopBasicInfo(
  id: "2",
  name: "KFC",
  mobileNumber: mockMobileNumber,
  image: ImageFaker().shop.logo.masterChef.toMedia,
);

final mockShopListItem1 = Fragment$shopListItem(
  id: "1",
  name: "Olive Garden",
  mobileNumber: mockMobileNumber,
  createdAt: DateTime.now().subtract(Duration(hours: 2)),
  status: Enum$ShopStatus.Active,
  wallet: mockShopWallets,
  orderQueueLevel: Enum$OrderQueueLevel.MEDIUM,
  carts: Fragment$shopListItem$carts(totalCount: 40),
  image: ImageFaker().shop.logo.masterChef.toMedia,
  ratingAggregate: mockRatingAggregateHigh,
  categories: [mockShopCategoryCompact1, mockShopCategoryCompact2],
);

final mockShopListItem2 = Fragment$shopListItem(
  id: "1",
  name: "KFC",
  mobileNumber: mockMobileNumber,
  createdAt: DateTime.now().subtract(Duration(hours: 2)),
  status: Enum$ShopStatus.Blocked,
  wallet: mockShopWallets,
  orderQueueLevel: Enum$OrderQueueLevel.HIGH,
  carts: Fragment$shopListItem$carts(totalCount: 53),
  image: ImageFaker().shop.logo.masterChef.toMedia,
  ratingAggregate: mockRatingAggregateHigh,
  categories: [mockShopCategoryCompact3],
);

final mockShopListItem3 = Fragment$shopListItem(
  id: "1",
  name: "Olive Garden",
  mobileNumber: mockMobileNumber,
  createdAt: DateTime.now().subtract(Duration(hours: 2)),
  wallet: mockShopWallets,
  status: Enum$ShopStatus.Inactive,
  orderQueueLevel: Enum$OrderQueueLevel.HIGH,
  carts: Fragment$shopListItem$carts(totalCount: 40),
  image: ImageFaker().shop.logo.masterChef.toMedia,
  ratingAggregate: mockRatingAggregateHigh,
  categories: [mockShopCategoryCompact1],
);

final mockShopListItem4 = Fragment$shopListItem(
  id: "1",
  name: "KFC",
  mobileNumber: mockMobileNumber,
  createdAt: DateTime.now().subtract(Duration(hours: 2)),
  wallet: mockShopWallets,
  status: Enum$ShopStatus.PendingApproval,
  orderQueueLevel: Enum$OrderQueueLevel.MEDIUM,
  carts: Fragment$shopListItem$carts(totalCount: 53),
  image: ImageFaker().shop.logo.masterChef.toMedia,
  ratingAggregate: mockRatingAggregateHigh,
  categories: [mockShopCategoryCompact1, mockShopCategoryCompact2],
);

final mockShopListItem5 = Fragment$shopListItem(
  id: "1",
  name: "Olive Garden",
  mobileNumber: mockMobileNumber,
  createdAt: DateTime.now().subtract(Duration(hours: 2)),
  wallet: mockShopWallets,
  status: Enum$ShopStatus.Inactive,
  carts: Fragment$shopListItem$carts(totalCount: 40),
  image: ImageFaker().shop.logo.masterChef.toMedia,
  orderQueueLevel: Enum$OrderQueueLevel.LOW,
  ratingAggregate: mockRatingAggregateHigh,
  categories: [mockShopCategoryCompact1, mockShopCategoryCompact2],
);

final mockShopListItems = [
  mockShopListItem1,
  mockShopListItem2,
  mockShopListItem3,
  mockShopListItem4,
  mockShopListItem5,
];

final mockShopDetail = Fragment$shopDetail(
  id: "1",
  status: Enum$ShopStatus.Active,
  createdAt: DateTime.now().subtract(const Duration(days: 3)),
  currency: "EUR",
  orderQueueLevel: Enum$OrderQueueLevel.MEDIUM,
  weeklySchedule: mockWeekdaySchedules,
  name: "Olive Garden",
  mobileNumber: mockMobileNumber,
  categories: [Fragment$shopCategoryCompact(id: "1", name: "Restaurant")],
  address: "Bobcat Lane, St. Robert, MO 65584-5678",
  location: mockCoordinateSanFrancisco,
  ownerInformation: mockPersonalInfo1,
  isExpressDeliveryAvailable: true,
  expressDeliveryShopCommission: 10,
  isShopDeliveryAvailable: true,
  isOnlinePaymentAvailable: false,
  isCashOnDeliveryAvailable: true,
);
