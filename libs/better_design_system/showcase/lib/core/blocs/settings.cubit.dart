import 'package:better_design_system/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'settings.state.dart';
part 'settings.cubit.freezed.dart';
part 'settings.cubit.g.dart';

class SettingsCubit extends HydratedCubit<SettingsState> {
  SettingsCubit() : super(SettingsState.initial());

  @override
  SettingsState? fromJson(Map<String, dynamic> json) =>
      SettingsState.fromJson(json);

  @override
  Map<String, dynamic>? toJson(SettingsState state) => state.toJson();

  void changeThemeMode(ThemeMode themeMode) =>
      emit(state.copyWith(themeMode: themeMode));

  void changeTheme(BetterThemes p1) => emit(state.copyWith(theme: p1));

  void changeHeaderTab(HeaderTabValues value) {
    emit(state.copyWith(selectedHeaderTab: value));
  }
}
