part of 'shop_accounting_list.cubit.dart';

@freezed
sealed class ShopAccountingListState with _$ShopAccountingListState {
  const factory ShopAccountingListState({
    @Default(ApiResponseInitial())
    ApiResponse<Query$shopWalletsSummary> walletSummaryState,
    @Default(ApiResponseInitial())
    ApiResponse<Query$shopWallets> walletListState,
    String? selectedCurrency,
    @Default([]) List<Input$ShopWalletSort> walletSortings,
    Input$OffsetPaging? walletPaging,
  }) = _ShopAccountingListState;
}
