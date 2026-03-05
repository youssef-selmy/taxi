part of 'park_spot_detail_order_detail_dialog.bloc.dart';

@freezed
sealed class ParkSpotDetailOrderDetailDialogState
    with _$ParkSpotDetailOrderDetailDialogState {
  const factory ParkSpotDetailOrderDetailDialogState({
    @Default(ApiResponseInitial())
    ApiResponse<Fragment$parkingOrderDetail> orderDetailState,
    @Default(ApiResponseInitial())
    ApiResponse<Fragment$parkSpotDetail> parkSpotDetailState,
    String? orderId,
  }) = _ParkSpotDetailOrderDetailDialogState;
}
