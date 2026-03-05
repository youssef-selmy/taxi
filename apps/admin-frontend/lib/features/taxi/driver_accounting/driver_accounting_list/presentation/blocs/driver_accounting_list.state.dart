part of 'driver_accounting_list.cubit.dart';

@freezed
sealed class DriverAccountingListState with _$DriverAccountingListState {
  const factory DriverAccountingListState({
    @Default(ApiResponseInitial())
    ApiResponse<Query$driverWalletsSummary> walletSummaryState,
    @Default(ApiResponseInitial())
    ApiResponse<Query$driverWallets> walletListState,
    String? selectedCurrency,
    @Default([]) List<Input$DriverWalletSort> walletSortings,
    Input$OffsetPaging? walletPaging,
  }) = _DriverAccountingListState;
}
