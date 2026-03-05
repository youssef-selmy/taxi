import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'settings_appearance.state.dart';
part 'settings_appearance.bloc.freezed.dart';

class SettingsAppearanceBloc extends Cubit<SettingsAppearanceState> {
  SettingsAppearanceBloc() : super(const SettingsAppearanceState());

  void onDarkModeSystemDefaultChange(bool value) {
    emit(state.copyWith(darkModeSystemDefault: value));
  }

  void onChangeDarkMode(bool isDarkMode) {
    emit(
      state.copyWith(darkModeSystemDefault: false, darkModeEnabled: isDarkMode),
    );
  }
}
