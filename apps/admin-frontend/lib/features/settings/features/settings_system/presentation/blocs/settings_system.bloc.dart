import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/graphql/fragments/system_configuration.fragment.graphql.dart';
import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/settings/features/settings_system/data/graphql/settings_system.graphql.dart';
import 'package:admin_frontend/features/settings/features/settings_system/data/repositories/settings_system_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

part 'settings_system.state.dart';
part 'settings_system.bloc.freezed.dart';

class SettingsSystemBloc extends Cubit<SettingsSystemState> {
  final SettingsSystemRepository _settingsSystemRepository =
      locator<SettingsSystemRepository>();

  SettingsSystemBloc() : super(const SettingsSystemState());

  void onStarted() {
    _fetchSystemSettings();
  }

  Future<void> _fetchSystemSettings() async {
    emit(state.copyWith(systemSettingsState: const ApiResponseLoading()));
    final systemSettingsOrError = await _settingsSystemRepository
        .getSystemSettings();
    final systemSettingsState = systemSettingsOrError;
    emit(
      state.copyWith(
        systemSettingsState: systemSettingsState,
        backendMapsAPIKey: systemSettingsState.data?.backendMapsAPIKey,
        mysqlHost: systemSettingsState.data?.mysqlHost,
        mysqlPort: systemSettingsState.data?.mysqlPort,
        mysqlDatabase: systemSettingsState.data?.mysqlDatabase,
        mysqlUser: systemSettingsState.data?.mysqlUser,
        mysqlPassword: systemSettingsState.data?.mysqlPassword,
        redisHost: systemSettingsState.data?.redisHost,
        redisPort: systemSettingsState.data?.redisPort,
        redisPassword: systemSettingsState.data?.redisPassword,
        redisDb: systemSettingsState.data?.redisDb,
        firebaseProjectPrivateKey:
            systemSettingsState.data?.firebaseProjectPrivateKey,
      ),
    );
  }

  Future<void> onSubmit() async {
    emit(state.copyWith(systemSettingsState: const ApiResponseLoading()));
    final updatedSystemSettingsOrError = await _settingsSystemRepository
        .updateSystemSettings(input: state.toInput);
    final updatedSystemSettingsState = updatedSystemSettingsOrError;
    emit(state.copyWith(updateSystemSettingsState: updatedSystemSettingsState));
  }

  void onMapsAPIKeyChanged(String p1) =>
      emit(state.copyWith(backendMapsAPIKey: p1));

  void onMySQLHostChanged(String p1) => emit(state.copyWith(mysqlHost: p1));

  void onMySQLPortChanged(String p1) =>
      emit(state.copyWith(mysqlPort: int.parse(p1)));

  void onMySQLDatabaseChanged(String p1) =>
      emit(state.copyWith(mysqlDatabase: p1));

  void onMySQLUsernameChanged(String p1) => emit(state.copyWith(mysqlUser: p1));

  void onMySQLPasswordChanged(String p1) =>
      emit(state.copyWith(mysqlPassword: p1));

  void onRedisHostChanged(String p1) => emit(state.copyWith(redisHost: p1));

  void onRedisPortChanged(String p1) =>
      emit(state.copyWith(redisPort: int.parse(p1)));

  void onRedisPasswordChanged(String p1) =>
      emit(state.copyWith(redisPassword: p1));

  void onRedisDbChanged(String p1) =>
      emit(state.copyWith(redisDb: int.parse(p1)));

  void onFirebasePrivateKeyChanged(String url) =>
      emit(state.copyWith(firebaseProjectPrivateKey: url));
}
