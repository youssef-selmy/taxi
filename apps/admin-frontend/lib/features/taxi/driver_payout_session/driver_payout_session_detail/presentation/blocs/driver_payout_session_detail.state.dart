part of 'driver_payout_session_detail.cubit.dart';

@freezed
sealed class DriverPayoutSessionDetailState
    with _$DriverPayoutSessionDetailState {
  const factory DriverPayoutSessionDetailState({
    @Default(ApiResponseInitial())
    ApiResponse<Fragment$taxiPayoutSessionDetail> payoutSessionDetailState,
    @Default(ApiResponseInitial())
    ApiResponse<Query$payoutSessionPayoutMethodDriverTransactions>
    driverTransactionsState,
    String? payoutSessionId,
    String? selectedPayoutMethodId,
    Input$OffsetPaging? transactionsPaging,
  }) = _DriverPayoutSessionDetailState;

  const DriverPayoutSessionDetailState._();

  ApiResponse<Fragment$taxiPayoutSessionPayoutMethodDetail>
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
