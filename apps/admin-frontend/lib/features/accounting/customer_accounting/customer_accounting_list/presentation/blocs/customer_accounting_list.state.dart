part of 'customer_accounting_list.bloc.dart';

@freezed
sealed class CustomerAccountingListState with _$CustomerAccountingListState {
  const factory CustomerAccountingListState({
    @Default(ApiResponseInitial())
    ApiResponse<Query$customerWalletsSummary> walletSummaryState,
    @Default(ApiResponseInitial())
    ApiResponse<Query$customerWallets> walletListState,
    String? selectedCurrency,
    @Default([]) List<Input$RiderWalletSort> walletSortings,
    Input$OffsetPaging? walletPaging,
  }) = _CustomerAccountingListState;
}
