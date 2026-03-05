import 'package:admin_frontend/core/graphql/fragments/parking_order_note.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/staff.graphql.mock.dart';

final mockParkingOrderNote1 = Fragment$orderParkingNotes(
  id: '1',
  parkOrderId: '1',
  note:
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
  staff: mockStaffListItem1,
  createdAt: DateTime.now().subtract(const Duration(days: 1)),
);
final mockParkingOrderNote2 = Fragment$orderParkingNotes(
  id: '2',
  parkOrderId: '2',
  note:
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
  staff: mockStaffListItem2,
  createdAt: DateTime.now().subtract(const Duration(days: 2)),
);
final mockParkingOrderNote3 = Fragment$orderParkingNotes(
  id: '3',
  parkOrderId: '3',
  note:
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
  staff: mockStaffListItem1,
  createdAt: DateTime.now().subtract(const Duration(days: 3)),
);

final mockParkingOrderList = [
  mockParkingOrderNote1,
  mockParkingOrderNote2,
  mockParkingOrderNote3,
];
