part of 'taxi_order_detail_complaints.cubit.dart';

@freezed
sealed class TaxiOrderDetailComplaintsState
    with _$TaxiOrderDetailComplaintsState {
  const factory TaxiOrderDetailComplaintsState({
    @Default(ApiResponseInitial())
    ApiResponse<Query$taxiOrderSupportRequests> complaintState,
  }) = _TaxiOrderDetailComplaintsState;
}
