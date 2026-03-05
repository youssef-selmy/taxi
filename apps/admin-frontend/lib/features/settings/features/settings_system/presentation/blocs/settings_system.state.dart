part of 'settings_system.bloc.dart';

@freezed
sealed class SettingsSystemState with _$SettingsSystemState {
  const factory SettingsSystemState({
    @Default(ApiResponseInitial())
    ApiResponse<Fragment$systemConfiguration> systemSettingsState,
    String? mysqlHost,
    int? mysqlPort,
    String? mysqlDatabase,
    String? mysqlUser,
    String? mysqlPassword,
    String? redisHost,
    int? redisPort,
    String? redisPassword,
    int? redisDb,
    String? backendMapsAPIKey,
    String? firebaseProjectPrivateKey,
    @Default(ApiResponseInitial())
    ApiResponse<Fragment$updateConfigResult> updateSystemSettingsState,
  }) = _SettingsSystemState;

  const SettingsSystemState._();

  Input$UpdateConfigInputV2 get toInput => Input$UpdateConfigInputV2(
    backendMapsAPIKey: backendMapsAPIKey!,
    mysqlHost: mysqlHost!,
    mysqlPort: mysqlPort!,
    mysqlUser: mysqlUser!,
    mysqlPassword: mysqlPassword!,
    mysqlDatabase: mysqlDatabase!,
    redisHost: redisHost!,
    redisPort: redisPort!,
    redisDb: redisDb!,
    redisPassword: redisPassword!,
    firebaseProjectPrivateKey: firebaseProjectPrivateKey!,
  );
}
