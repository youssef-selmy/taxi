import 'package:image_faker/image_faker.dart';

import 'package:admin_frontend/core/graphql/fragments/address.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/customer.fragment.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/media.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/payment_gateway_compact.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/saved_payment_method.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/shop.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/shop_order.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

final mockShopOrderCartItem1 = Fragment$shopOrderCartItem(
  id: '1',
  priceEach: 70,
  quantity: 2,
  itemVariant: Fragment$shopOrderCartItemVariant(
    id: '1',
    name: 'Small',
    price: 20,
    product: Fragment$shopOrderCartItemVariant$product(
      name: 'Pizza',
      image: ImageFaker().food.burgerWithBlueBackground.toMedia,
    ),
  ),
  options: [
    Fragment$shopOrderCartItemOption(
      id: '1',
      name: 'Mozzarella cheese',
      price: 1.65,
    ),
    Fragment$shopOrderCartItemOption(
      id: '1',
      name: 'Mozzarella cheese',
      price: 2.65,
    ),
  ],
);
final mockShopOrderCartItem2 = Fragment$shopOrderCartItem(
  id: '1',
  priceEach: 30,
  quantity: 1,
  itemVariant: Fragment$shopOrderCartItemVariant(
    id: '1',
    name: 'Large',
    price: 15,
    product: Fragment$shopOrderCartItemVariant$product(
      name: 'Pasta',
      image: ImageFaker().food.burgerWithBlueBackground.toMedia,
    ),
  ),
  options: [
    Fragment$shopOrderCartItemOption(
      id: '1',
      name: 'Mozzarella cheese',
      price: 1.65,
    ),
    Fragment$shopOrderCartItemOption(
      id: '1',
      name: 'Mozzarella cheese',
      price: 2.65,
    ),
    Fragment$shopOrderCartItemOption(
      id: '1',
      name: 'Mozzarella cheese',
      price: 3.65,
    ),
  ],
);

final mockStatusHistoriesList = [
  Fragment$orderShopDetail$statusHistories(
    id: '1',
    orderId: '1',
    status: Enum$ShopOrderStatus.New,
    expectedBy: DateTime.now().subtract(const Duration(hours: 3)),
    updatedAt: DateTime.now().subtract(const Duration(hours: 3)),
  ),
  Fragment$orderShopDetail$statusHistories(
    id: '1',
    orderId: '1',
    status: Enum$ShopOrderStatus.Processing,
    expectedBy: DateTime.now().subtract(const Duration(hours: 2)),
    updatedAt: DateTime.now().subtract(const Duration(hours: 2)),
  ),
  Fragment$orderShopDetail$statusHistories(
    id: '1',
    orderId: '1',
    status: Enum$ShopOrderStatus.Completed,
    expectedBy: DateTime.now().subtract(const Duration(hours: 1)),
    updatedAt: DateTime.now().subtract(const Duration(hours: 1)),
  ),
];

final mockOrderShopDetail = Fragment$orderShopDetail(
  estimatedDeliveryTime: DateTime.now().subtract(const Duration(hours: 3)),
  fullfillmentTime: DateTime.now().subtract(const Duration(hours: 6)),
  deliveryMethod: Enum$DeliveryMethod.BATCH,
  deliveryFee: 1.23,
  discount: 1.98,
  serviceFee: 1.23,
  subTotal: 340,
  total: 340,
  tax: 4.77,
  id: "1",
  createdAt: DateTime.now().subtract(const Duration(hours: 3)),
  status: Enum$ShopOrderStatus.Processing,
  deliveryAddress: mockAddressHome2,
  currency: "USD",
  paymentMethod: Enum$PaymentMode.Cash,
  savedPaymentMethod: mockSavedPaymentMethodVisa,
  carts: [
    Fragment$orderShopDetail$carts(
      id: "1",
      shop: mockFragmentShopBasic3,
      products: [mockShopOrderCartItem1, mockShopOrderCartItem2],
    ),
    Fragment$orderShopDetail$carts(
      id: "2",
      shop: mockFragmentShopBasic4,
      products: [mockShopOrderCartItem1],
    ),
  ],
  customer: mockCustomer1,
  paymentGateway: mockPaymentGatewayCompact1,
  statusHistories: mockStatusHistoriesList,
);

final mockShopOrderListItem1 = Fragment$shopOrderListItem(
  deliveryAddress: mockAddressHome,
  paymentMethod: Enum$PaymentMode.Cash,
  savedPaymentMethod: mockSavedPaymentMethodVisa,
  id: "1",
  createdAt: DateTime.now().subtract(const Duration(hours: 3)),
  status: Enum$ShopOrderStatus.Processing,
  total: 4.6,
  currency: "USD",
  carts: [
    Fragment$shopOrderListItem$carts(
      shop: mockFragmentShopBasic1,
      products: [mockShopOrderCartItem1, mockShopOrderCartItem2],
    ),
  ],
  customer: mockCustomer2,
);

final mockShopOrderListItem2 = Fragment$shopOrderListItem(
  deliveryAddress: mockAddressHome,
  paymentMethod: Enum$PaymentMode.Cash,
  savedPaymentMethod: mockSavedPaymentMethodVisa,
  id: "1",
  createdAt: DateTime.now().subtract(const Duration(hours: 3)),
  status: Enum$ShopOrderStatus.New,
  total: 10.2,
  currency: "USD",
  carts: [
    Fragment$shopOrderListItem$carts(
      shop: mockFragmentShopBasic1,
      products: [mockShopOrderCartItem1, mockShopOrderCartItem2],
    ),
  ],
  customer: mockCustomer3,
);
final mockShopOrderListItem3 = Fragment$shopOrderListItem(
  deliveryAddress: mockAddressHome,
  paymentMethod: Enum$PaymentMode.Cash,
  savedPaymentMethod: mockSavedPaymentMethodVisa,
  id: "1",
  createdAt: DateTime.now().subtract(const Duration(hours: 3)),
  status: Enum$ShopOrderStatus.OnHold,
  total: 73,
  currency: "USD",
  carts: [
    Fragment$shopOrderListItem$carts(
      shop: mockFragmentShopBasic1,
      products: [mockShopOrderCartItem1, mockShopOrderCartItem2],
    ),
  ],
  customer: mockCustomer4,
);

final mockShopOrderListItem4 = Fragment$shopOrderListItem(
  deliveryAddress: mockAddressHome,
  paymentMethod: Enum$PaymentMode.Cash,
  savedPaymentMethod: mockSavedPaymentMethodVisa,
  id: "1",
  createdAt: DateTime.now().subtract(const Duration(hours: 3)),
  status: Enum$ShopOrderStatus.Completed,
  total: 42.4,
  currency: "USD",
  carts: [
    Fragment$shopOrderListItem$carts(
      shop: mockFragmentShopBasic1,
      products: [mockShopOrderCartItem1, mockShopOrderCartItem2],
    ),
  ],
  customer: mockCustomer1,
);

final mockShopOrderListItem5 = Fragment$shopOrderListItem(
  deliveryAddress: mockAddressHome,
  paymentMethod: Enum$PaymentMode.Cash,
  savedPaymentMethod: mockSavedPaymentMethodVisa,
  id: "1",
  createdAt: DateTime.now().subtract(const Duration(hours: 3)),
  status: Enum$ShopOrderStatus.Returned,
  total: 16.1,
  currency: "USD",
  carts: [
    Fragment$shopOrderListItem$carts(
      shop: mockFragmentShopBasic1,
      products: [mockShopOrderCartItem1, mockShopOrderCartItem2],
    ),
  ],
  customer: mockCustomer2,
);

final mockShopOrderListItems = [
  mockShopOrderListItem1,
  mockShopOrderListItem2,
  mockShopOrderListItem3,
  mockShopOrderListItem4,
  mockShopOrderListItem5,
];
