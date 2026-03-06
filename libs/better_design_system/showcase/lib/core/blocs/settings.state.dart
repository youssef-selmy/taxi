part of 'settings.cubit.dart';

@freezed
sealed class SettingsState with _$SettingsState {
  const factory SettingsState({
    @Default(ThemeMode.light) ThemeMode themeMode,
    @Default(BetterThemes.cobalt) BetterThemes theme,
    @Default(HeaderTabValues.themes) HeaderTabValues selectedHeaderTab,
  }) = _SettingsState;

  factory SettingsState.fromJson(Map<String, dynamic> json) =>
      _$SettingsStateFromJson(json);

  const SettingsState._();

  // Initial State
  factory SettingsState.initial() => SettingsState();
}

enum HeaderTabValues { themes, templates, blocks, docs }

const supportedThemes = [
  BetterThemes.noir,
  BetterThemes.cobalt,
  BetterThemes.electricIndigo,
  BetterThemes.coralRed,
  BetterThemes.earthyGreen,
  BetterThemes.hyperPink,
  BetterThemes.sunburstYellow,
  BetterThemes.autumnOrange,
];
