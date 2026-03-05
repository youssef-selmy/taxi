part of 'parking_overview.bloc.dart';

@freezed
sealed class ParkingOverviewState with _$ParkingOverviewState {
  const factory ParkingOverviewState({
    String? currency,
    @Default(ApiResponseInitial()) ApiResponse<Query$overviewKPIs> kpisState,
    @Default(ApiResponseInitial())
    ApiResponse<Query$activeOrders> activeOrdersState,
    @Default(ApiResponseInitial())
    ApiResponse<Query$pendingParkings> pendingParkingsState,
    @Default(ApiResponseInitial())
    ApiResponse<Query$pendingSupportRequests> pendingSupportRequestsState,
    @Default(ApiResponseInitial())
    ApiResponse<List<Fragment$leaderboardItem>> topSpendingCustomersState,
    @Default(ApiResponseInitial())
    ApiResponse<List<Fragment$leaderboardItem>> topEarningParkingsState,
    Input$OffsetPaging? activeOrdersPaging,
  }) = _ParkingOverviewState;

  const ParkingOverviewState._();

  bool get isLoading =>
      kpisState.isLoading ||
      activeOrdersState.isLoading ||
      pendingParkingsState.isLoading ||
      pendingSupportRequestsState.isLoading ||
      topSpendingCustomersState.isLoading ||
      topEarningParkingsState.isLoading;
}
