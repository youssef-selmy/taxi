import 'package:admin_frontend/core/graphql/fragments/note.fragment.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/shop_order_note.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/staff.graphql.mock.dart';

final mockShopOrderNote1 = Fragment$shopOrderNote(
  id: '1',
  note: mockNote1,
  staff: mockStaffListItem1,
);
final mockShopOrderNote2 = Fragment$shopOrderNote(
  note: mockNote2,
  staff: mockStaffListItem2,
  id: '1',
);
final mockShopOrderNote3 = Fragment$shopOrderNote(
  id: '1',
  note: mockNote1,
  staff: mockStaffListItem1,
);

final mockShopOrderListNotes = [
  mockShopOrderNote1,
  mockShopOrderNote2,
  mockShopOrderNote3,
];
