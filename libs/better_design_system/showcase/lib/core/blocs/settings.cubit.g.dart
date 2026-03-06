// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings.cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SettingsState _$SettingsStateFromJson(Map<String, dynamic> json) =>
    _SettingsState(
      themeMode:
          $enumDecodeNullable(_$ThemeModeEnumMap, json['themeMode']) ??
          ThemeMode.system,
      theme:
          $enumDecodeNullable(_$BetterThemesEnumMap, json['theme']) ??
          BetterThemes.cobalt,
    );

Map<String, dynamic> _$SettingsStateToJson(_SettingsState instance) =>
    <String, dynamic>{
      'themeMode': _$ThemeModeEnumMap[instance.themeMode]!,
      'theme': _$BetterThemesEnumMap[instance.theme]!,
    };

const _$ThemeModeEnumMap = {
  ThemeMode.system: 'system',
  ThemeMode.light: 'light',
  ThemeMode.dark: 'dark',
};

const _$BetterThemesEnumMap = {
  BetterThemes.electricIndigo: 'electricIndigo',
  BetterThemes.cobalt: 'cobalt',
  BetterThemes.coralRed: 'coralRed',
  BetterThemes.earthyGreen: 'earthyGreen',
  BetterThemes.noir: 'noir',
  BetterThemes.hyperPink: 'hyperPink',
  BetterThemes.sunburstYellow: 'sunburstYellow',
  BetterThemes.autumnOrange: 'autumnOrange',
  BetterThemes.hera: 'hera',
};
