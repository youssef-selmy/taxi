part of 'shop_overview.bloc.dart';

@freezed
sealed class ShopOverviewState with _$ShopOverviewState {
  const factory ShopOverviewState({
    String? currency,
    @Default(ApiResponseInitial()) ApiResponse<Query$overviewKPIs> kpisState,
    @Default(ApiResponseInitial())
    ApiResponse<Query$activeOrders> activeOrdersState,
    @Default(ApiResponseInitial())
    ApiResponse<Query$pendingShops> pendingShopsState,
    @Default(ApiResponseInitial())
    ApiResponse<Query$pendingSupportRequests> pendingSupportRequestsState,
    @Default(ApiResponseInitial())
    ApiResponse<List<Fragment$leaderboardItem>> topSpendingCustomersState,
    @Default(ApiResponseInitial())
    ApiResponse<List<Fragment$leaderboardItem>> topEarningShopsState,
    Input$OffsetPaging? activeOrdersPaging,
  }) = _ShopOverviewState;

  const ShopOverviewState._();

  bool get isLoading =>
      kpisState.isLoading ||
      activeOrdersState.isLoading ||
      pendingShopsState.isLoading ||
      pendingSupportRequestsState.isLoading ||
      topSpendingCustomersState.isLoading ||
      topEarningShopsState.isLoading;
}
