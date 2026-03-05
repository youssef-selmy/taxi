part of 'settings_notification.bloc.dart';

@freezed
sealed class SettingsNotificationState with _$SettingsNotificationState {
  const factory SettingsNotificationState({
    @Default(ApiResponseInitial())
    ApiResponse<List<Enum$EnabledNotification>> notificationSettingsState,
    @Default([]) List<Enum$EnabledNotification> notificationSettings,
  }) = _SettingsNotificationState;

  const SettingsNotificationState._();

  bool isNotificationEnabled(Enum$EnabledNotification notification) {
    return notificationSettings.contains(notification);
  }
}
