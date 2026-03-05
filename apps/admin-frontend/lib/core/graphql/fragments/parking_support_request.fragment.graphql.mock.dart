import 'package:admin_frontend/core/graphql/fragments/customer.fragment.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/parking_support_request.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/staff.graphql.mock.dart';
import 'package:admin_frontend/schema.graphql.dart';

final mockParkingSupportRequest1 = Fragment$parkingSupportRequest(
  id: "1",
  subject: "A box missing from the trunk",
  status: Enum$ComplaintStatus.UnderInvestigation,
  createdAt: DateTime.now().subtract(const Duration(days: 3, hours: 2)),
  parkOrder: Fragment$parkingSupportRequest$parkOrder(
    id: "1",
    carOwner: mockCustomerCompact3,
    spotOwner: mockCustomerCompact7,
  ),
  requestedByOwner: true,
  assignedToStaffs: [mockStaffListItem1, mockStaffListItem2],
);

final mockParkingSupportRequest2 = Fragment$parkingSupportRequest(
  id: "2",
  subject: "A box missing from the trunk",
  status: Enum$ComplaintStatus.UnderInvestigation,
  createdAt: DateTime.now().subtract(const Duration(days: 3, hours: 2)),
  parkOrder: Fragment$parkingSupportRequest$parkOrder(
    id: "1",
    carOwner: mockCustomerCompact3,
    spotOwner: mockCustomerCompact7,
  ),
  requestedByOwner: true,
  assignedToStaffs: [mockStaffListItem1, mockStaffListItem2],
);

final mockParkingSupportRequest3 = Fragment$parkingSupportRequest(
  id: "3",
  subject: "A box missing from the trunk",
  status: Enum$ComplaintStatus.UnderInvestigation,
  createdAt: DateTime.now().subtract(const Duration(days: 3, hours: 2)),
  parkOrder: Fragment$parkingSupportRequest$parkOrder(
    id: "1",
    carOwner: mockCustomerCompact3,
    spotOwner: mockCustomerCompact7,
  ),
  requestedByOwner: true,
  assignedToStaffs: [mockStaffListItem1, mockStaffListItem2],
);

final mockParkingSupportRequest4 = Fragment$parkingSupportRequest(
  id: "4",
  subject: "A box missing from the trunk",
  status: Enum$ComplaintStatus.UnderInvestigation,
  createdAt: DateTime.now().subtract(const Duration(days: 3, hours: 2)),
  parkOrder: Fragment$parkingSupportRequest$parkOrder(
    id: "1",
    carOwner: mockCustomerCompact3,
    spotOwner: mockCustomerCompact7,
  ),
  requestedByOwner: true,
  assignedToStaffs: [mockStaffListItem1, mockStaffListItem2],
);

final mockParkingSupportRequests = [
  mockParkingSupportRequest1,
  mockParkingSupportRequest2,
  mockParkingSupportRequest3,
  mockParkingSupportRequest4,
];

final mockParkingSupportRequestDetail = Fragment$parkingSupportRequestDetail(
  id: "1",
  subject: "A missing box",
  createdAt: DateTime.now().subtract(const Duration(days: 2, hours: 1)),
  status: Enum$ComplaintStatus.UnderInvestigation,
  parkOrderId: "1",
  parkOrder: Fragment$parkingSupportRequestDetail$parkOrder(
    id: "1",
    carOwner: mockCustomerCompact3,
    spotOwner: mockCustomerCompact7,
  ),
  requestedByOwner: true,
  activities: mockParkingSupportRequestActivities,
  assignedToStaffs: [mockStaffListItem1],
);

final mockParkingSupportRequestActivity1 =
    Fragment$parkingSupportRequestActivity(
      id: "1",
      createdAt: DateTime.now().subtract(const Duration(days: 2, hours: 1)),
      comment: "The box was found in the trunk",
      type: Enum$ComplaintActivityType.Comment,
      assignedToStaffs: [],
      unassignedFromStaffs: [],
    );

final mockParkingSupportRequestActivity2 =
    Fragment$parkingSupportRequestActivity(
      id: "2",
      createdAt: DateTime.now().subtract(const Duration(days: 2, hours: 1)),
      type: Enum$ComplaintActivityType.AssignToOperator,
      assignedToStaffs: [mockStaffListItem1],
      unassignedFromStaffs: [],
    );

final mockParkingSupportRequestActivity3 =
    Fragment$parkingSupportRequestActivity(
      id: "3",
      createdAt: DateTime.now().subtract(const Duration(days: 2, hours: 1)),
      type: Enum$ComplaintActivityType.UnassignFromOperators,
      assignedToStaffs: [],
      unassignedFromStaffs: [mockStaffListItem1],
    );

final mockParkingSupportRequestActivities = [
  mockParkingSupportRequestActivity1,
  mockParkingSupportRequestActivity2,
  mockParkingSupportRequestActivity3,
];
