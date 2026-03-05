import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/settings/features/settings_sessions/data/graphql/settings_sessions.graphql.dart';
import 'package:admin_frontend/features/settings/features/settings_sessions/data/repositories/settings_sessions_repository.dart';

part 'settings_sessions.state.dart';
part 'settings_sessions.bloc.freezed.dart';

class SettingsSessionsBloc extends Cubit<SettingsSessionsState> {
  final SettingsSessionsRepository _settingsSessionsRepository =
      locator<SettingsSessionsRepository>();

  SettingsSessionsBloc() : super(const SettingsSessionsState());

  void onStarted() {
    _fetchSessions();
  }

  Future<void> _fetchSessions() async {
    emit(state.copyWith(sessionsState: const ApiResponseLoading()));
    final sessionsOrError = await _settingsSessionsRepository.getSessions();
    final sessionsState = sessionsOrError;
    emit(state.copyWith(sessionsState: sessionsState));
  }

  void onTerminateSession(String sessionId) async {
    final terminateOrError = await _settingsSessionsRepository.terminateSession(
      id: sessionId,
    );
    final terminateState = terminateOrError;
    emit(state.copyWith(terminateSessionState: terminateState));
    _fetchSessions();
  }
}
