part of 'parking_accounting_list.cubit.dart';

@freezed
sealed class ParkingAccountingListState with _$ParkingAccountingListState {
  const factory ParkingAccountingListState({
    @Default(ApiResponseInitial())
    ApiResponse<Query$parkingWalletsSummary> walletSummaryState,
    @Default(ApiResponseInitial())
    ApiResponse<Query$parkingWallets> walletListState,
    String? selectedCurrency,
    @Default([]) List<Input$ParkingWalletSort> walletSortings,
    Input$OffsetPaging? walletPaging,
  }) = _ParkingAccountingListState;
}
