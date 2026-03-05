part of 'taxi_order_detail.bloc.dart';

@freezed
sealed class TaxiOrderDetailState with _$TaxiOrderDetailState {
  const factory TaxiOrderDetailState({
    @Default(ApiResponseInitial())
    ApiResponse<Fragment$taxiOrderDetail> orderDetailResponse,
  }) = _TaxiActiveOrderDetailState;
}
