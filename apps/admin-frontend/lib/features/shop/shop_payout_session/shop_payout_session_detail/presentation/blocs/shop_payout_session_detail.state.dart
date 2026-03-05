part of 'shop_payout_session_detail.cubit.dart';

@freezed
sealed class ShopPayoutSessionDetailState with _$ShopPayoutSessionDetailState {
  const factory ShopPayoutSessionDetailState({
    @Default(ApiResponseInitial())
    ApiResponse<Fragment$shopPayoutSessionDetail> payoutSessionDetailState,
    @Default(ApiResponseInitial())
    ApiResponse<Query$shopPayoutSessionPayoutMethodShopTransactions>
    shopTransactionsState,
    String? payoutSessionId,
    String? selectedPayoutMethodId,
    Input$OffsetPaging? transactionsPaging,
  }) = _ShopPayoutSessionDetailState;

  const ShopPayoutSessionDetailState._();

  ApiResponse<Fragment$shopPayoutSessionPayoutMethodDetail>
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
