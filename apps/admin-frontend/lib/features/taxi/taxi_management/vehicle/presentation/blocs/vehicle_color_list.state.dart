part of 'vehicle_color_list.cubit.dart';

@freezed
sealed class VehicleColorListState with _$VehicleColorListState {
  const factory VehicleColorListState({
    @Default(ApiResponseInitial())
    ApiResponse<Query$vehicleColors> networkState,
    String? search,
    Input$OffsetPaging? paging,
  }) = _VehicleColorListState;
}
