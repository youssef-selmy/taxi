part of 'vehicle_color_details.cubit.dart';

@freezed
sealed class VehicleColorDetailsState with _$VehicleColorDetailsState {
  const factory VehicleColorDetailsState({
    String? id,
    String? name,
    @Default(ApiResponseInitial())
    ApiResponse<Fragment$vehicleColor?> vehicleColor,
    @Default(ApiResponseInitial()) ApiResponse<void> networkStateSave,
  }) = _VehicleColorDetailsState;
}
