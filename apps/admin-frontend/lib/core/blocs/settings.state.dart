part of 'settings.bloc.dart';

@freezed
sealed class SettingsState with _$SettingsState {
  const factory SettingsState({
    required String locale,
    required MapProviderEnum mapProvider,
    @Default(ThemeMode.system) ThemeMode themeMode,
  }) = _SettingsState;

  factory SettingsState.initial() => SettingsState(
    locale: Env.defaultLanguage,
    mapProvider: Env.mapProviderPlatformSettings.getProvider,
  );

  // factory SettingsState.fromJson(Map<String, dynamic> json) =>
  //     _$SettingsStateFromJson(json);

  factory SettingsState.fromJson(Map<String, dynamic> json) {
    return SettingsState(
      locale: json['locale'] as String,
      mapProvider: MapProviderEnum.values.firstWhere(
        (e) => e.name == json['mapProvider'],
        orElse: () => MapProviderEnum.mapBox,
      ),
      themeMode: ThemeMode.values.firstWhere(
        (e) => e.name == json['themeMode'],
        orElse: () => ThemeMode.system,
      ),
    );
  }

  // @override
  Map<String, dynamic> toJson() {
    return {
      'locale': locale,
      'mapProvider': mapProvider.name,
      'themeMode': themeMode.name,
    };
  }

  const SettingsState._();
}
