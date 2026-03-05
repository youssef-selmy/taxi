import 'package:admin_frontend/config/env.dart';
import 'package:flutter/material.dart';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:generic_map/generic_map.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';

part 'settings.state.dart';
part 'settings.bloc.freezed.dart';

@singleton
class SettingsCubit extends HydratedCubit<SettingsState> {
  SettingsCubit() : super(SettingsState.initial());

  @override
  SettingsState? fromJson(Map<String, dynamic> json) {
    final state = SettingsState.fromJson(json);
    // Normalize locale when loading from storage
    return state.copyWith(locale: normalizeLocale(state.locale));
  }

  @override
  Map<String, dynamic>? toJson(SettingsState state) {
    return state.toJson();
  }

  void changeLanguage(String? locale) {
    // Normalize locale format (replace hyphens with underscores, handle special cases)
    final normalized = normalizeLocale(locale!);
    emit(state.copyWith(locale: normalized));
  }

  /// Normalizes locale strings to use underscores and proper casing
  static String normalizeLocale(String locale) {
    final normalized = locale.replaceAll('-', '_').trim();
    final lowerNormalized = normalized.toLowerCase();

    // Handle special cases
    if (lowerNormalized == 'en_uk' || lowerNormalized == 'en_gb') {
      return 'en_GB';
    }
    if (lowerNormalized == 'zh_cn') {
      return 'zh_CN';
    }
    if (lowerNormalized == 'zh_tw') {
      return 'zh_TW';
    }

    // For other locales with country codes, ensure proper casing
    final parts = normalized.split('_');
    if (parts.length >= 2) {
      return '${parts[0].toLowerCase()}_${parts[1].toUpperCase()}';
    }

    return parts[0].toLowerCase();
  }

  void changeMapProvider(MapProviderEnum mapProvider) {
    emit(state.copyWith(mapProvider: mapProvider));
  }

  void changeThemeMode(ThemeMode themeMode) {
    emit(state.copyWith(themeMode: themeMode));
  }

  void toggleThemeMode(ThemeMode nonSystemThemeMode) {
    changeThemeMode(
      nonSystemThemeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light,
    );
  }
}
