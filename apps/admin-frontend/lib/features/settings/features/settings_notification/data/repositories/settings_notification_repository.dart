import 'package:api_response/api_response.dart';

import 'package:admin_frontend/schema.graphql.dart';

abstract class SettingsNotificationRepository {
  Future<ApiResponse<List<Enum$EnabledNotification>>> getNotificationSettings();

  Future<ApiResponse<List<Enum$EnabledNotification>>>
  updateNotificationSettings({
    required List<Enum$EnabledNotification> enabledNotifications,
  });
}
