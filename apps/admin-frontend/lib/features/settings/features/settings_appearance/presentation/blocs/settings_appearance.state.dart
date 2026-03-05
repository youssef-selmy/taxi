part of 'settings_appearance.bloc.dart';

@freezed
sealed class SettingsAppearanceState with _$SettingsAppearanceState {
  const factory SettingsAppearanceState({
    @Default(true) bool darkModeSystemDefault,
    @Default(false) bool darkModeEnabled,
  }) = _SettingsAppearanceState;
}
