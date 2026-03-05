part of 'taxi_overview.bloc.dart';

@freezed
sealed class TaxiOverviewState with _$TaxiOverviewState {
  const factory TaxiOverviewState({
    String? currency,
    Input$BoundsInput? onlineDriverMapBounds,
    @Default(ApiResponseInitial()) ApiResponse<Query$overviewKPIs> kpisState,
    @Default(ApiResponseInitial())
    ApiResponse<Query$taxiOrders> activeOrdersState,
    @Default(ApiResponseInitial())
    ApiResponse<Query$onlineDrivers> onlineDriversState,
    @Default(ApiResponseInitial())
    ApiResponse<List<Fragment$LocationCluster>> onlineDriversClusters,
    @Default(ApiResponseInitial())
    ApiResponse<List<Fragment$LocationWithId>> singleOnlineDrivers,
    @Default(ApiResponseInitial())
    ApiResponse<Query$pendingDrivers> pendingDriversState,
    @Default(ApiResponseInitial())
    ApiResponse<Query$pendingSupportRequests> pendingSupportRequestsState,
    @Default(ApiResponseInitial())
    ApiResponse<List<Fragment$leaderboardItem>> topSpendingCustomersState,
    @Default(ApiResponseInitial())
    ApiResponse<List<Fragment$leaderboardItem>> topEarningDriversState,
    Input$OffsetPaging? activeOrdersPaging,
    required List<Input$OrderSort> activeOrdersSorting,
  }) = _TaxiOverviewState;

  const TaxiOverviewState._();

  factory TaxiOverviewState.initial() => TaxiOverviewState(
    activeOrdersSorting: [
      Input$OrderSort(
        field: Enum$OrderSortFields.id,
        direction: Enum$SortDirection.DESC,
      ),
    ],
  );

  bool get isLoading =>
      kpisState.isLoading ||
      pendingDriversState.isLoading ||
      pendingSupportRequestsState.isLoading ||
      topSpendingCustomersState.isLoading ||
      topEarningDriversState.isLoading;
}
