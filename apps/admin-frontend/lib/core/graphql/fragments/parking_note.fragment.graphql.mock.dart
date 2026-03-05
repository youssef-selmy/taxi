import 'package:admin_frontend/core/graphql/fragments/parking_note.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/staff.graphql.mock.dart';

final mockParkingNote1 = Fragment$parkingNote(
  id: "1",
  createdAt: DateTime.now().subtract(const Duration(days: 1, hours: 2)),
  note:
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla nec odio.",
  staff: mockStaffListItem1,
);

final mockParkingNote2 = Fragment$parkingNote(
  id: "2",
  createdAt: DateTime.now().subtract(const Duration(days: 2, hours: 3)),
  note:
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla nec odio.",
  staff: mockStaffListItem2,
);

final mockParkingNote3 = Fragment$parkingNote(
  id: "3",
  createdAt: DateTime.now().subtract(const Duration(days: 3, hours: 4)),
  note:
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla nec odio.",
  staff: mockStaffListItem3,
);

final mockParkingNotes = [mockParkingNote1, mockParkingNote2, mockParkingNote3];
