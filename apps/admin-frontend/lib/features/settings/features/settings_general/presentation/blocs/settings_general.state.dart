part of 'settings_general.bloc.dart';

@freezed
sealed class SettingsGeneralState with _$SettingsGeneralState {
  const factory SettingsGeneralState({
    @Default(ApiResponseInitial()) ApiResponse<Fragment$profile> profileState,
    String? firstName,
    String? lastName,
    String? email,
    String? mobileNumber,
    String? userName,
    Fragment$Media? profilePicture,
  }) = _SettingsGeneralState;

  const SettingsGeneralState._();

  Input$UpdateProfileInput get toUpdateProfileInput => Input$UpdateProfileInput(
    firstName: firstName,
    lastName: lastName,
    email: email,
    mobileNumber: mobileNumber,
    userName: userName,
    mediaId: profilePicture?.id,
  );
}
