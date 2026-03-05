part of 'auth.bloc.dart';

@freezed
sealed class AuthEvent with _$AuthEvent {
  const factory AuthEvent.activateServer() = AuthEventActivateServer;
  const factory AuthEvent.disableServer({
    required String purchaseCode,
    required String ip,
  }) = AuthEventDisableServer;
  const factory AuthEvent.onLicenseKeyChanged(String? p0) =
      AuthEventOnLicenseKeyChanged;
  const factory AuthEvent.onEmailChanged(String? p0) = AuthEventOnEmailChanged;
}
