part of 'parking_order_detail.cubit.dart';

@freezed
sealed class ParkingOrderDetailState with _$ParkingOrderDetailState {
  const factory ParkingOrderDetailState({
    @Default(ApiResponseInitial())
    ApiResponse<Fragment$parkingOrderDetail> parkingOrderDetailState,
    String? parkingOrderId,
  }) = _ParkingOrderDetailState;
}
