part of 'settings_password.bloc.dart';

@freezed
sealed class SettingsPasswordState with _$SettingsPasswordState {
  const factory SettingsPasswordState({
    @Default(ApiResponseInitial()) ApiResponse<void> updatePasswordState,
    String? previousPassword,
    String? password,
    String? confirmPassword,
  }) = _SettingsPasswordState;
}
