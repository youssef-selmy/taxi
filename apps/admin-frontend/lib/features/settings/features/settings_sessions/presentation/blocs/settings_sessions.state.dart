part of 'settings_sessions.bloc.dart';

@freezed
sealed class SettingsSessionsState with _$SettingsSessionsState {
  const factory SettingsSessionsState({
    @Default(ApiResponseInitial())
    ApiResponse<Query$currentUserSessions> sessionsState,
    @Default(ApiResponseInitial()) ApiResponse<void> terminateSessionState,
  }) = _SettingsSessionsState;
}
