import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/settings/features/settings_notification/data/repositories/settings_notification_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

part 'settings_notification.state.dart';
part 'settings_notification.bloc.freezed.dart';

class SettingsNotificationBloc extends Cubit<SettingsNotificationState> {
  final SettingsNotificationRepository _settingsNotificationRepository =
      locator<SettingsNotificationRepository>();

  SettingsNotificationBloc() : super(const SettingsNotificationState());

  void onStarted() {
    _fetchNotificationSettings();
  }

  Future<void> _fetchNotificationSettings() async {
    emit(state.copyWith(notificationSettingsState: const ApiResponseLoading()));
    final notificationSettingsOrError = await _settingsNotificationRepository
        .getNotificationSettings();
    final notificationSettingsState = notificationSettingsOrError;
    emit(
      state.copyWith(
        notificationSettingsState: notificationSettingsState,
        notificationSettings: notificationSettingsState.data ?? [],
      ),
    );
  }

  void _disableNotification(Enum$EnabledNotification notification) async {
    final updatedNotificationSettings = state.notificationSettings
        .where((n) => n != notification)
        .toList();
    _updateNotificationSettings(updatedNotificationSettings);
  }

  void _enableNotification(Enum$EnabledNotification notification) async {
    final updatedNotificationSettings = [
      ...state.notificationSettings,
      notification,
    ];
    _updateNotificationSettings(updatedNotificationSettings);
  }

  void changeNotificationSetting(
    Enum$EnabledNotification notification,
    bool enabled,
  ) async {
    if (enabled) {
      _enableNotification(notification);
    } else {
      _disableNotification(notification);
    }
  }

  Future<void> _updateNotificationSettings(
    List<Enum$EnabledNotification> updatedNotificationSettings,
  ) async {
    emit(state.copyWith(notificationSettingsState: const ApiResponseLoading()));
    final updatedNotificationSettingsOrError =
        await _settingsNotificationRepository.updateNotificationSettings(
          enabledNotifications: updatedNotificationSettings,
        );
    final updatedNotificationSettingsState = updatedNotificationSettingsOrError;
    emit(
      state.copyWith(
        notificationSettingsState: updatedNotificationSettingsState,
        notificationSettings: updatedNotificationSettingsState.data ?? [],
      ),
    );
  }
}
