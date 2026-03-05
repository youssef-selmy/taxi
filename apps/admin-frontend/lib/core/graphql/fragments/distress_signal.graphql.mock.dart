import 'package:admin_frontend/core/graphql/fragments/customer.fragment.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/distress_signal.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/driver.graphql.mock.dart';
import 'package:admin_frontend/schema.graphql.dart';

final mockDistressSingnalListItem1 = Fragment$DistressSignal(
  id: '1',
  submittedByRider: true,
  createdAt: DateTime.now().add(const Duration(days: 1)),
  status: Enum$SOSStatus.FalseAlarm,
  reason: mockSosReasonDetail1,
  comment:
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
);

final mockDistressSingnalListItem2 = Fragment$DistressSignal(
  id: '2',
  submittedByRider: true,
  createdAt: DateTime.now().add(const Duration(days: 2)),
  status: Enum$SOSStatus.UnderReview,
  reason: mockSosReasonDetail1,
);

final mockDistressSingnalListItem3 = Fragment$DistressSignal(
  id: '3',
  submittedByRider: true,
  createdAt: DateTime.now().add(const Duration(days: 3)),
  status: Enum$SOSStatus.Resolved,
  reason: mockSosReasonDetail1,
  comment:
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
);

final mockDistressSingnalListItem4 = Fragment$DistressSignal(
  id: '4',
  submittedByRider: true,
  createdAt: DateTime.now().add(const Duration(days: 4)),
  status: Enum$SOSStatus.Submitted,
  reason: mockSosReasonDetail1,
  comment:
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
);

final mockDistressSingnalList = [
  mockDistressSingnalListItem1,
  mockDistressSingnalListItem2,
  mockDistressSingnalListItem3,
  mockDistressSingnalListItem4,
];

final mockDistressSingnalDetail = Fragment$distressSignalDetail(
  id: '4',
  submittedByRider: true,
  createdAt: DateTime.now().add(const Duration(days: 1)),
  status: Enum$SOSStatus.Submitted,
  reason: mockSosReasonDetail1,
  comment:
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
  order: Fragment$distressSignalDetail$order(
    id: "1",
    driver: mockDriverName3,
    rider: mockCustomerCompact1,
  ),
);

final mockSosReasonListItem1 = Fragment$SosReassonList(
  id: '1',
  name: 'Abuse',
  isActive: true,
  sos: Fragment$SosReassonList$sos(totalCount: 23),
);

final mockSosReasonListItem2 = Fragment$SosReassonList(
  id: '2',
  name: 'Car Accident',
  isActive: true,
  sos: Fragment$SosReassonList$sos(totalCount: 44),
);

final mockSosReasonListItem3 = Fragment$SosReassonList(
  id: '3',
  name: 'Abuse',
  isActive: true,
  sos: Fragment$SosReassonList$sos(totalCount: 14),
);

final mockSosReasonList = [
  mockSosReasonListItem1,
  mockSosReasonListItem2,
  mockSosReasonListItem3,
];

final mockSosReasonDetail1 = Fragment$SosReassonDetail(
  id: '1',
  name: 'Abuse',
  isActive: true,
);

final mockSosReasonDetail2 = Fragment$SosReassonDetail(
  id: '2',
  name: 'Car Accident',
  isActive: true,
);

final mockSosReasonDetail3 = Fragment$SosReassonDetail(
  id: '3',
  name: 'Abuse',
  isActive: true,
);

final mockSosReasonDetailList = [
  mockSosReasonListItem1,
  mockSosReasonListItem2,
  mockSosReasonListItem3,
];
