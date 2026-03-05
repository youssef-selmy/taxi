import 'package:api_response/api_response.dart';

import 'package:admin_frontend/core/graphql/fragments/notifications.fragment.graphql.dart';

abstract class NotificationsRepository {
  Stream<ApiResponse<List<Fragment$notification>>> get notifications;

  Future<ApiResponse<List<Fragment$notification>>> getNotifications();
}
