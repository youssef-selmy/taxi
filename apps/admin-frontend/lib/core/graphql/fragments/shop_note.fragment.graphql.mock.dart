import 'package:admin_frontend/core/graphql/fragments/note.fragment.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/shop_note.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/staff.graphql.mock.dart';

final mockShopNote1 = Fragment$shopNote(
  id: '1',
  note: mockNote1,
  staff: mockStaffListItem1,
);

final mockShopNote2 = Fragment$shopNote(
  id: '2',
  note: mockNote2,
  staff: mockStaffListItem2,
);

final mockShopNote3 = Fragment$shopNote(
  id: '3',
  note: mockNote1,
  staff: mockStaffListItem3,
);

final mockShopNotes = [mockShopNote1, mockShopNote2, mockShopNote3];
