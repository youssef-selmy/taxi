part of 'driver_detail_active_devices.bloc.dart';

@freezed
sealed class DriverDetailActiveDevicesState
    with _$DriverDetailActiveDevicesState {
  const factory DriverDetailActiveDevicesState({
    @Default(ApiResponse.initial())
    ApiResponse<Query$driverActiveDevices> driverActiveDevicesState,
    @Default(ApiResponse.initial())
    ApiResponse<Mutation$deleteDriverActiveDevice>
    deleteDriverActiveDeviceState,
    String? driverId,
  }) = _DriverDetailActiveDevicesState;
}
