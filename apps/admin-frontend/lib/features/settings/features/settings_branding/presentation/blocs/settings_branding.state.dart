part of 'settings_branding.bloc.dart';

@freezed
sealed class SettingsBrandingState with _$SettingsBrandingState {
  const factory SettingsBrandingState({
    Fragment$Media? companyLogo,
    String? companyName,
    Fragment$Media? taxiLogo,
    String? taxiName,
    Enum$AppColorScheme? taxiColorPalette,
    Fragment$Media? shopLogo,
    String? shopName,
    Enum$AppColorScheme? shopColorPalette,
    Fragment$Media? parkingLogo,
    String? parkingName,
    Enum$AppColorScheme? parkingColorPalette,
  }) = _SettingsBrandingState;
}
