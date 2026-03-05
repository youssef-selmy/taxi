part of 'vehicle_model_list.cubit.dart';

@freezed
sealed class VehicleModelListState with _$VehicleModelListState {
  const factory VehicleModelListState({
    @Default(ApiResponseInitial())
    ApiResponse<Query$vehicleModels> networkState,
    String? search,
    Input$OffsetPaging? paging,
  }) = _VehicleModelListState;
}
