import 'package:admin_frontend/core/graphql/fragments/customer.fragment.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/driver.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/staff.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/taxi_support_request.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

final mockcomplaintTaxiListItem1 = Fragment$taxiSupportRequest(
  id: "1",
  subject: "Missed keys",
  inscriptionTimestamp: DateTime.now().subtract(const Duration(hours: 1)),
  status: Enum$ComplaintStatus.Resolved,
  requestId: "1",
  requestedByDriver: false,
  assignedToStaffs: [mockStaffListItem1, mockStaffListItem2],
);

final mockcomplaintTaxiListItem2 = Fragment$taxiSupportRequest(
  id: "2",
  subject: "Late delivery",
  inscriptionTimestamp: DateTime.now().subtract(const Duration(hours: 2)),
  status: Enum$ComplaintStatus.Submitted,
  requestId: "2",
  requestedByDriver: false,
  assignedToStaffs: [mockStaffListItem1],
);

final mockcomplaintTaxiListItem3 = Fragment$taxiSupportRequest(
  id: "3",
  subject: "Wrong order",
  inscriptionTimestamp: DateTime.now().subtract(const Duration(hours: 3)),
  status: Enum$ComplaintStatus.Submitted,
  requestId: "3",
  requestedByDriver: true,
  assignedToStaffs: [],
);

final mockcomplaintTaxiListItem4 = Fragment$taxiSupportRequest(
  id: "4",
  subject: "Bad service",
  inscriptionTimestamp: DateTime.now().subtract(const Duration(hours: 4)),
  status: Enum$ComplaintStatus.Resolved,
  requestId: "4",
  requestedByDriver: true,
  assignedToStaffs: [mockStaffListItem1, mockStaffListItem2],
);

final mockcomplaintTaxiListItem5 = Fragment$taxiSupportRequest(
  id: "5",
  subject: "Wrong order",
  inscriptionTimestamp: DateTime.now().subtract(const Duration(hours: 5)),
  status: Enum$ComplaintStatus.Submitted,
  requestId: "5",
  requestedByDriver: true,
  assignedToStaffs: [mockStaffListItem1, mockStaffListItem2],
);

final mockTaxiSupportRequests = [
  mockcomplaintTaxiListItem1,
  mockcomplaintTaxiListItem2,
  mockcomplaintTaxiListItem3,
  mockcomplaintTaxiListItem4,
  mockcomplaintTaxiListItem5,
];

final mockTaxiSupportRequestDetail = Fragment$taxiSupportRequestDetail(
  assignedToStaffs: [mockStaffListItem1],
  id: "1",
  subject: "Missed keys",
  inscriptionTimestamp: DateTime.now().subtract(const Duration(hours: 1)),
  status: Enum$ComplaintStatus.Resolved,
  request: Fragment$taxiSupportRequestDetail$request(
    id: "1",
    driver: mockDriverName1,
    rider: mockCustomerCompact1,
  ),
  requestedByDriver: false,
  activities: [
    mockTaxiSupportRequestActivity1,
    mockTaxiSupportRequestActivity2,
    mockTaxiSupportRequestActivity3,
  ],
);

final mockTaxiSupportRequestActivity1 = Fragment$taxiSupportRequestActivity(
  unassignedFromStaffs: [mockStaffListItem2],
  createdAt: DateTime.now().subtract(const Duration(hours: 5)),
  id: "1",
  actor: mockStaffListItem1,
  type: Enum$ComplaintActivityType.Create,
  comment:
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
  assignedToStaffs: mockStaffList,
  statusFrom: Enum$ComplaintStatus.UnderInvestigation,
  statusTo: Enum$ComplaintStatus.Resolved,
);

final mockTaxiSupportRequestActivity2 = Fragment$taxiSupportRequestActivity(
  unassignedFromStaffs: [],
  createdAt: DateTime.now().subtract(const Duration(hours: 1)),
  id: "2",
  actor: mockStaffListItem1,
  assignedToStaffs: mockStaffList,
  statusFrom: Enum$ComplaintStatus.UnderInvestigation,
  statusTo: Enum$ComplaintStatus.Resolved,
  type: Enum$ComplaintActivityType.StatusChange,
  comment:
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
);

final mockTaxiSupportRequestActivity3 = Fragment$taxiSupportRequestActivity(
  unassignedFromStaffs: [],
  createdAt: DateTime.now().subtract(const Duration(hours: 1)),
  id: "3",
  actor: mockStaffListItem1,
  assignedToStaffs: mockStaffList,
  statusFrom: Enum$ComplaintStatus.UnderInvestigation,
  statusTo: Enum$ComplaintStatus.Submitted,
  type: Enum$ComplaintActivityType.Comment,
  comment:
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
);
