part of 'auth.bloc.dart';

@freezed
sealed class AuthEvent with _$AuthEvent {
  const factory AuthEvent.onStarted() = AuthEvent$OnStarted;
  const factory AuthEvent.login(String email, String password) =
      AuthEvent$Login;
  const factory AuthEvent.tokenRefreshed({required String accessToken}) =
      AuthEvent$TokenRefreshed;
  const factory AuthEvent.logout() = AuthEvent$Logout;
  const factory AuthEvent.refreshProfile() = AuthEvent$RefreshProfile;

  const factory AuthEvent.changeAppType(Enum$AppType? appType) =
      AuthEvent$ChangeAppType;

  const factory AuthEvent.changeCurrency(String currency) =
      AuthEvent$ChangeCurrency;
}
