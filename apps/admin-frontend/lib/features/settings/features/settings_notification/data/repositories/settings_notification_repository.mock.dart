import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/features/settings/features/settings_notification/data/repositories/settings_notification_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@dev
@LazySingleton(as: SettingsNotificationRepository)
class SettingsNotificationRepositoryMock
    implements SettingsNotificationRepository {
  @override
  Future<ApiResponse<List<Enum$EnabledNotification>>>
  getNotificationSettings() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded([
      Enum$EnabledNotification.SupportRequest,
      Enum$EnabledNotification.SOS,
      Enum$EnabledNotification.UserPendingVerification,
    ]);
  }

  @override
  Future<ApiResponse<List<Enum$EnabledNotification>>>
  updateNotificationSettings({
    required List<Enum$EnabledNotification> enabledNotifications,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(enabledNotifications);
  }
}
