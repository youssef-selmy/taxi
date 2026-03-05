part of 'auth.bloc.dart';

@freezed
sealed class AuthState with _$AuthState {
  const factory AuthState({
    String? purchaseCode,
    String? email,
    @Default(ApiResponseInitial())
    ApiResponse<Mutation$updateLicense> activateServerResponse,
    @Default(ApiResponseInitial())
    ApiResponse<Mutation$DisableServer$disablePreviousServer>
    disableServerResponse,
  }) = _AuthState;

  const AuthState._();
}
