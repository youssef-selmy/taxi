part of 'parking_order_detail_complaints.cubit.dart';

@freezed
sealed class ParkingOrderDetailComplaintsState
    with _$ParkingOrderDetailComplaintsState {
  const factory ParkingOrderDetailComplaintsState({
    @Default(ApiResponseInitial())
    ApiResponse<Query$getParkingOrderSupportRequest>
    parkingOrderComplaintsState,
  }) = _ParkingOrderDetailComplaintsState;
}
