import 'package:admin_frontend/core/graphql/fragments/note.fragment.graphql.dart';

final mockNote1 = Fragment$note(
  note:
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
  createdAt: DateTime.now().subtract(const Duration(days: 1, hours: 3)),
);

final mockNote2 = Fragment$note(
  note:
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
  createdAt: DateTime.now().subtract(const Duration(days: 2, hours: 3)),
);
