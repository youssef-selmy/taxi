part of 'parking_payout_session_detail.cubit.dart';

@freezed
sealed class ParkingPayoutSessionDetailState
    with _$ParkingPayoutSessionDetailState {
  const factory ParkingPayoutSessionDetailState({
    @Default(ApiResponseInitial())
    ApiResponse<Fragment$parkingPayoutSessionDetail> payoutSessionDetailState,
    @Default(ApiResponseInitial())
    ApiResponse<Query$parkingPayoutSessionPayoutMethodParkingTransactions>
    parkingTransactionsState,
    String? payoutSessionId,
    String? selectedPayoutMethodId,
    Input$OffsetPaging? transactionsPaging,
  }) = _ParkingPayoutSessionDetailState;

  const ParkingPayoutSessionDetailState._();

  ApiResponse<Fragment$parkingPayoutSessionPayoutMethodDetail>
  get selectedPayoutMethodState => payoutSessionDetailState.mapData(
    (data) => data.payoutMethodDetails.firstWhere(
      (t) => t.id == selectedPayoutMethodId,
      orElse: () => throw Exception('Payout method not found'),
    ),
  );

  bool get isFundsSufficient =>
      selectedPayoutMethodState.data?.payoutMethod.type.isAutomatic == false ||
      (selectedPayoutMethodState.data?.payoutMethod.balance ?? 0) >=
          (selectedPayoutMethodState.data?.totalAmount ?? 0);
}
