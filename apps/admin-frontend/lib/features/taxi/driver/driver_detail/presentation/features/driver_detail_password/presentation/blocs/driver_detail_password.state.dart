part of 'driver_detail_password.bloc.dart';

@freezed
sealed class DriverDetailPasswordState with _$DriverDetailPasswordState {
  const factory DriverDetailPasswordState({
    @Default(ApiResponse.initial()) ApiResponse<void> updatePasswordState,
    String? password,
    String? confirmPassword,
    String? driverId,
  }) = _DriverDetailPasswordState;
}
