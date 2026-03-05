import 'package:admin_frontend/core/graphql/fragments/customer.fragment.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/shop.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/shop_support_request.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/staff.graphql.mock.dart';
import 'package:admin_frontend/schema.graphql.dart';

final mockShopSupportRequest1 = Fragment$shopSupportRequest(
  id: "1",
  subject: "Subject 1",
  status: Enum$ComplaintStatus.UnderInvestigation,
  createdAt: DateTime.now().subtract(const Duration(days: 2, hours: 3)),
  orderId: "1",
  requestedByShop: true,
  assignedToStaffs: [mockStaffListItem1, mockStaffListItem2],
  cart: Fragment$shopSupportRequest$cart(shop: mockShopBasicInfo1),
  order: Fragment$shopSupportRequest$order(
    customer: mockCustomerCompact1,
    carts: [Fragment$shopSupportRequest$order$carts(shop: mockShopBasicInfo1)],
  ),
);

final mockShopSupportRequest2 = Fragment$shopSupportRequest(
  id: "2",
  subject: "Subject 2",
  status: Enum$ComplaintStatus.Resolved,
  createdAt: DateTime.now().subtract(const Duration(days: 1, hours: 3)),
  orderId: "2",
  requestedByShop: false,
  assignedToStaffs: [mockStaffListItem2],
  cart: Fragment$shopSupportRequest$cart(shop: mockShopBasicInfo1),
  order: Fragment$shopSupportRequest$order(
    customer: mockCustomerCompact1,
    carts: [Fragment$shopSupportRequest$order$carts(shop: mockShopBasicInfo1)],
  ),
);

final mockShopSupportRequest3 = Fragment$shopSupportRequest(
  id: "3",
  subject: "Subject 3",
  status: Enum$ComplaintStatus.UnderInvestigation,
  createdAt: DateTime.now().subtract(const Duration(days: 1, hours: 3)),
  orderId: "3",
  requestedByShop: true,
  assignedToStaffs: [mockStaffListItem1],
  cart: Fragment$shopSupportRequest$cart(shop: mockShopBasicInfo1),
  order: Fragment$shopSupportRequest$order(
    customer: mockCustomerCompact1,
    carts: [Fragment$shopSupportRequest$order$carts(shop: mockShopBasicInfo1)],
  ),
);

final mockShopSupportRequest4 = Fragment$shopSupportRequest(
  id: "4",
  subject: "Subject 4",
  status: Enum$ComplaintStatus.Resolved,
  createdAt: DateTime.now().subtract(const Duration(days: 1, hours: 3)),
  orderId: "4",
  requestedByShop: false,
  assignedToStaffs: [mockStaffListItem2],
  cart: Fragment$shopSupportRequest$cart(shop: mockShopBasicInfo1),
  order: Fragment$shopSupportRequest$order(
    customer: mockCustomerCompact1,
    carts: [Fragment$shopSupportRequest$order$carts(shop: mockShopBasicInfo1)],
  ),
);

final mockShopSupportRequests = [
  mockShopSupportRequest1,
  mockShopSupportRequest2,
  mockShopSupportRequest3,
  mockShopSupportRequest4,
];

final mockShopSupportRequestDetail = Fragment$shopSupportRequestDetail(
  id: "1",
  subject: "There is a problem with the order",
  status: Enum$ComplaintStatus.Resolved,
  createdAt: DateTime.now().subtract(const Duration(days: 1, hours: 3)),
  cart: Fragment$shopSupportRequestDetail$cart(shop: mockShopBasicInfo1),
  order: Fragment$shopSupportRequestDetail$order(
    id: "1",
    customer: mockCustomerCompact1,
    carts: [
      Fragment$shopSupportRequestDetail$order$carts(shop: mockShopBasicInfo1),
    ],
  ),
  requestedByShop: true,
  activities: mockShopSupportRequestActivities,
  assignedToStaffs: [mockStaffListItem1, mockStaffListItem2],
);

final mockShopSupportRequestActivity1 = Fragment$shopSupportRequestActivity(
  id: "1",
  createdAt: DateTime.now().subtract(const Duration(days: 1, hours: 3)),
  type: Enum$ComplaintActivityType.Comment,
  comment: "This is a comment",
  assignedToStaffs: [],
  unassignedFromStaffs: [],
);

final mockShopSupportRequestActivity2 = Fragment$shopSupportRequestActivity(
  id: "2",
  createdAt: DateTime.now().subtract(const Duration(days: 1, hours: 3)),
  type: Enum$ComplaintActivityType.AssignToOperator,
  comment: "",
  assignedToStaffs: [mockStaffListItem1],
  unassignedFromStaffs: [],
);

final mockShopSupportRequestActivity3 = Fragment$shopSupportRequestActivity(
  id: "3",
  createdAt: DateTime.now().subtract(const Duration(days: 1, hours: 3)),
  type: Enum$ComplaintActivityType.UnassignFromOperators,
  comment: "",
  assignedToStaffs: [],
  unassignedFromStaffs: [mockStaffListItem1],
);

final mockShopSupportRequestActivity4 = Fragment$shopSupportRequestActivity(
  id: "4",
  createdAt: DateTime.now().subtract(const Duration(days: 1, hours: 3)),
  type: Enum$ComplaintActivityType.StatusChange,
  statusFrom: Enum$ComplaintStatus.UnderInvestigation,
  statusTo: Enum$ComplaintStatus.Resolved,
  comment: "",
  assignedToStaffs: [],
  unassignedFromStaffs: [],
);

final mockShopSupportRequestActivities = [
  mockShopSupportRequestActivity1,
  mockShopSupportRequestActivity2,
  mockShopSupportRequestActivity3,
  mockShopSupportRequestActivity4,
];
