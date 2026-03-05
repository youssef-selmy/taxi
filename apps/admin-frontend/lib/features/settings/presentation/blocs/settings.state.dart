part of 'settings.bloc.dart';

@freezed
sealed class SettingsState with _$SettingsState {
  const factory SettingsState({PageRouteInfo? selectedRoute}) = _SettingsState;
}
