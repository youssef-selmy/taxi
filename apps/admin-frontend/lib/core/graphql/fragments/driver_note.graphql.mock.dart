import 'package:admin_frontend/core/graphql/fragments/driver_note.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/staff.graphql.mock.dart';

final mockDriverNote1 = Fragment$driverNote(
  id: '1',
  driverId: '1',
  note:
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
  staff: mockStaffListItem1,
  createdAt: DateTime.now().subtract(const Duration(days: 3)),
);

final mockDriverNote2 = Fragment$driverNote(
  id: '2',
  driverId: '2',
  note:
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
  staff: mockStaffListItem2,
  createdAt: DateTime.now().subtract(const Duration(days: 2)),
);

final mockDriverNote3 = Fragment$driverNote(
  id: '3',
  driverId: '3',
  note:
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
  staff: mockStaffListItem3,
  createdAt: DateTime.now().subtract(const Duration(days: 1)),
);

final mockDriverNotesList = [mockDriverNote1, mockDriverNote2, mockDriverNote3];
