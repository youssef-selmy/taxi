part of 'park_spot_detail_credit_records.cubit.dart';

@freezed
sealed class ParkSpotDetailCreditRecordsState
    with _$ParkSpotDetailCreditRecordsState {
  const factory ParkSpotDetailCreditRecordsState({
    @Default(ApiResponseInitial())
    ApiResponse<Query$parkSpotCreditRecords> creditRecordsState,
    String? parkSpotId,
    String? ownerId,
    Input$OffsetPaging? paging,
    @Default([]) List<Enum$TransactionStatus> statusFilters,
    @Default([]) List<Enum$TransactionType> typeFilters,
    @Default([]) List<Input$ParkingTransactionSort> sorting,
    @Default(ApiResponseInitial())
    ApiResponse<List<WalletBalanceItem>> walletState,
    @Default(ApiResponseInitial()) ApiResponse<String> exportState,
  }) = _ParkSpotDetailCreditRecordsState;

  const ParkSpotDetailCreditRecordsState._();

  Input$ParkingTransactionFilter get filter => Input$ParkingTransactionFilter(
    parkSpotId: Input$IDFilterComparison(eq: parkSpotId),
    status: statusFilters.isEmpty
        ? null
        : Input$TransactionStatusFilterComparison($in: statusFilters),
    type: typeFilters.isEmpty
        ? null
        : Input$TransactionTypeFilterComparison($in: typeFilters),
  );
}
