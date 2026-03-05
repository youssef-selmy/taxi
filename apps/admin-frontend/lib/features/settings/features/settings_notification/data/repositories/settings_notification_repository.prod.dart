import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/features/settings/features/settings_notification/data/graphql/settings_notification.graphql.dart';
import 'package:admin_frontend/features/settings/features/settings_notification/data/repositories/settings_notification_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@prod
@LazySingleton(as: SettingsNotificationRepository)
class SettingsNotificationRepositoryImpl
    implements SettingsNotificationRepository {
  final GraphqlDatasource graphQLDatasource;

  SettingsNotificationRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<List<Enum$EnabledNotification>>>
  getNotificationSettings() async {
    final notificationSettingsOrError = await graphQLDatasource.query(
      Options$Query$currentUserNotificationSettings(),
    );
    return notificationSettingsOrError.mapData(
      (r) => r.me.enabledNotifications,
    );
  }

  @override
  Future<ApiResponse<List<Enum$EnabledNotification>>>
  updateNotificationSettings({
    required List<Enum$EnabledNotification> enabledNotifications,
  }) async {
    final updatedNotificationSettingsOrError = await graphQLDatasource.mutate(
      Options$Mutation$updateNotificationSettings(
        variables: Variables$Mutation$updateNotificationSettings(
          input: enabledNotifications,
        ),
      ),
    );
    return updatedNotificationSettingsOrError.mapData(
      (r) => r.updateProfile.enabledNotifications,
    );
  }
}
