import 'package:admin_frontend/core/graphql/fragments/customer.fragment.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/shop.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/shop_feedback.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/shop_order.graphql.mock.dart';
import 'package:admin_frontend/schema.graphql.dart';

final mockShopFeedback1 = Fragment$shopFeedback(
  id: "1",
  score: 90,
  status: Enum$ReviewStatus.Pending,
  orderCart: Fragment$shopFeedback$orderCart(
    shop: mockFragmentShopBasic1,
    order: Fragment$shopFeedback$orderCart$order(
      id: "1",
      customer: mockCustomerCompact1,
    ),
    products: [mockShopOrderCartItem1, mockShopOrderCartItem2],
  ),
  createdAt: DateTime.now().subtract(const Duration(days: 1)),
  comment:
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
  parameters: [
    mockFeedbackParameterShop1,
    mockFeedbackParameterShop2,
    mockFeedbackParameterShop6,
  ],
);

final mockReviewShop2 = Fragment$shopFeedback(
  id: "2",
  score: 70,
  orderCart: Fragment$shopFeedback$orderCart(
    shop: mockFragmentShopBasic1,
    order: Fragment$shopFeedback$orderCart$order(
      id: "1",
      customer: mockCustomerCompact1,
    ),
    products: [mockShopOrderCartItem1, mockShopOrderCartItem2],
  ),
  status: Enum$ReviewStatus.Approved,
  createdAt: DateTime.now().subtract(const Duration(days: 2)),
  comment:
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
  parameters: [
    mockFeedbackParameterShop4,
    mockFeedbackParameterShop5,
    mockFeedbackParameterShop3,
  ],
);

final mockReviewShop3 = Fragment$shopFeedback(
  id: "3",
  score: 50,
  status: Enum$ReviewStatus.Rejected,
  orderCart: Fragment$shopFeedback$orderCart(
    shop: mockFragmentShopBasic1,
    order: Fragment$shopFeedback$orderCart$order(
      id: "1",
      customer: mockCustomerCompact1,
    ),
    products: [mockShopOrderCartItem1, mockShopOrderCartItem2],
  ),
  createdAt: DateTime.now().subtract(const Duration(days: 3)),
  comment:
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
  parameters: [mockFeedbackParameterShop4],
);

final mockReviewShop4 = Fragment$shopFeedback(
  id: "4",
  score: 80,
  status: Enum$ReviewStatus.Pending,
  orderCart: Fragment$shopFeedback$orderCart(
    products: [mockShopOrderCartItem1, mockShopOrderCartItem2],
    order: Fragment$shopFeedback$orderCart$order(
      id: "1",
      customer: mockCustomerCompact4,
    ),
    shop: mockFragmentShopBasic1,
  ),
  createdAt: DateTime.now().subtract(const Duration(days: 4)),
  comment:
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
  parameters: [mockFeedbackParameterShop5, mockFeedbackParameterShop6],
);

final mockReviewShop5 = Fragment$shopFeedback(
  id: "5",
  score: 60,
  status: Enum$ReviewStatus.Approved,
  orderCart: Fragment$shopFeedback$orderCart(
    order: Fragment$shopFeedback$orderCart$order(
      id: "1",
      customer: mockCustomerCompact1,
    ),
    shop: mockFragmentShopBasic1,
    products: [mockShopOrderCartItem1, mockShopOrderCartItem2],
  ),
  createdAt: DateTime.now().subtract(const Duration(days: 5)),
  comment:
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
  parameters: [mockFeedbackParameterShop1, mockFeedbackParameterShop2],
);

final mockShopReviewsList = [
  mockShopFeedback1,
  mockReviewShop2,
  mockReviewShop3,
  mockReviewShop4,
  mockReviewShop5,
];

final mockFeedbackParameterShop1 = Fragment$shopFeedbackParameter(
  id: "1",
  name: "Good Driving",
  isGood: true,
);

final mockFeedbackParameterShop2 = Fragment$shopFeedbackParameter(
  id: "1",
  name: "Bad Driving",
  isGood: false,
);

final mockFeedbackParameterShop3 = Fragment$shopFeedbackParameter(
  id: "1",
  name: "Good Car",
  isGood: true,
);

final mockFeedbackParameterShop4 = Fragment$shopFeedbackParameter(
  id: "1",
  name: "Bad Car",
  isGood: false,
);

final mockFeedbackParameterShop5 = Fragment$shopFeedbackParameter(
  id: "1",
  name: "Good Service",
  isGood: true,
);

final mockFeedbackParameterShop6 = Fragment$shopFeedbackParameter(
  id: "1",
  name: "Bad Service",
  isGood: false,
);
