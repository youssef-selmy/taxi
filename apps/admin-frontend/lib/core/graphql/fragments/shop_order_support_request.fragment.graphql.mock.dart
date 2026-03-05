import 'package:admin_frontend/core/graphql/fragments/shop_order.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/shop_order_support_request.fragment.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

final mockShopOrderSupportRequest1 = Fragment$shopOrderSupportRequest(
  id: '1',
  createdAt: DateTime.now().subtract(const Duration(minutes: 10)),
  status: Enum$ComplaintStatus.Submitted,
  order: mockShopOrderListItem1,
  requestedByShop: true,
  content:
      'Customer Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
  subject: 'Bad Driving',
);

final mockShopOrderSupportRequest2 = Fragment$shopOrderSupportRequest(
  id: '2',
  createdAt: DateTime.now().subtract(const Duration(minutes: 20)),
  status: Enum$ComplaintStatus.UnderInvestigation,
  order: mockShopOrderListItem1,
  requestedByShop: false,
  content:
      'Customer Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
  subject: 'Bad Driving',
);

final mockShopOrderSupportRequest3 = Fragment$shopOrderSupportRequest(
  id: '3',
  createdAt: DateTime.now().subtract(const Duration(minutes: 30)),
  status: Enum$ComplaintStatus.Resolved,
  order: mockShopOrderListItem1,
  requestedByShop: false,
  content:
      'Shop Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
  subject: 'Bad Driving',
);

final mockShopOrderSupportRequest4 = Fragment$shopOrderSupportRequest(
  id: '4',
  createdAt: DateTime.now().subtract(const Duration(minutes: 40)),
  status: Enum$ComplaintStatus.UnderInvestigation,
  order: mockShopOrderListItem1,
  requestedByShop: true,
  content:
      'Shop Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
  subject: 'Bad Driving',
);

final mockShopOrderSupportRequests = [
  mockShopOrderSupportRequest1,
  mockShopOrderSupportRequest2,
  mockShopOrderSupportRequest3,
  mockShopOrderSupportRequest4,
];
