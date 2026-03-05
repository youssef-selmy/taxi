import 'package:admin_frontend/core/graphql/fragments/insights.fragment.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

final mockActiveInactiveUsers = [
  Fragment$ActiveInactiveUsers(
    activityLevel: Enum$UserActivityLevel.Active,
    count: 5334,
    date: DateTime.now(),
  ),
  Fragment$ActiveInactiveUsers(
    activityLevel: Enum$UserActivityLevel.Inactive,
    count: 3241,
    date: DateTime.now(),
  ),
];
