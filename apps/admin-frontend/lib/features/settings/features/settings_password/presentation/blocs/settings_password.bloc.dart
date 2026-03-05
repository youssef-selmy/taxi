import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/settings/features/settings_password/data/repositories/settings_password_repository.dart';

part 'settings_password.state.dart';
part 'settings_password.bloc.freezed.dart';

class SettingsPasswordBloc extends Cubit<SettingsPasswordState> {
  final SettingsPasswordRepository _settingsPasswordRepository =
      locator<SettingsPasswordRepository>();

  SettingsPasswordBloc() : super(const SettingsPasswordState());

  void onStarted() {}

  void onPasswordChanged(String password) =>
      emit(state.copyWith(password: password));

  void onConfirmPasswordChanged(String confirmPassword) =>
      emit(state.copyWith(confirmPassword: confirmPassword));

  void onUpdatePassword() async {
    emit(state.copyWith(updatePasswordState: ApiResponse.loading()));
    final updatePasswordOrError = await _settingsPasswordRepository
        .updatePassword(
          previousPassword: state.previousPassword!,
          newPassword: state.password!,
        );
    final updatePasswordState = updatePasswordOrError;
    emit(state.copyWith(updatePasswordState: updatePasswordState));
  }

  void onPreviousPasswordChanged(String p1) {
    emit(state.copyWith(previousPassword: p1));
  }
}
