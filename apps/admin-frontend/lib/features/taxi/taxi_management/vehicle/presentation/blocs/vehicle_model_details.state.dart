part of 'vehicle_model_details.cubit.dart';

@freezed
sealed class VehicleModelDetailsState with _$VehicleModelDetailsState {
  const factory VehicleModelDetailsState({
    String? id,
    String? name,
    @Default(ApiResponseInitial())
    ApiResponse<Fragment$vehicleModel?> vehicleModel,
    @Default(ApiResponseInitial()) ApiResponse<void> networkStateSave,
  }) = _VehicleModelDetailsState;
}
