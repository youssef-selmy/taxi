import 'package:admin_frontend/core/graphql/fragments/customer_note.graphql.dart';

final mockCustomerNote1 = Fragment$customerNote(
  id: "1",
  createdAt: DateTime.now().subtract(const Duration(days: 1)),
  note: "Note 1",
  createdBy: Fragment$customerNote$createdBy(
    id: "1",
    firstName: "John",
    lastName: "Doe",
  ),
);

final mockCustomerNote2 = Fragment$customerNote(
  id: "2",
  createdAt: DateTime.now().subtract(const Duration(days: 2)),
  note: "Note 2",
  createdBy: Fragment$customerNote$createdBy(
    id: "2",
    firstName: "Jane",
    lastName: "Doe",
  ),
);

final mockCustomerNote3 = Fragment$customerNote(
  id: "3",
  createdAt: DateTime.now().subtract(const Duration(days: 3)),
  note: "Note 3",
  createdBy: Fragment$customerNote$createdBy(
    id: "3",
    firstName: "John",
    lastName: "Smith",
  ),
);

extension CustomerNoteFragmentX on Fragment$customerNote {}
