part of 'platform_overview.cubit.dart';

@freezed
sealed class PlatformOverviewState with _$PlatformOverviewState {
  const factory PlatformOverviewState({
    @Default(ApiResponseInitial())
    ApiResponse<Query$orderVolumeTimeSeries> orderVolumeTimeSeries,
    @Default(ApiResponseInitial())
    ApiResponse<Query$pendingSupportRequestsCount> pendingSupportRequests,
    @Default(ApiResponseInitial())
    ApiResponse<Query$pendingOrders> pendingOrders,
    @Default(ApiResponseInitial())
    ApiResponse<Query$platfromOverviewKPIs> overviewKPIs,
    @Default(ApiResponseInitial()) ApiResponse<Query$taxiOrders> taxiOrders,
    @Default(ApiResponseInitial()) ApiResponse<Query$shopOrders> shopOrders,
    @Default(ApiResponseInitial())
    ApiResponse<Query$parkingOrders> parkingOrders,
    Input$PaginationInput? taxiOrdersPaging,
    Input$OffsetPaging? shopOrdersPaging,
    Input$OffsetPaging? parkingOrdersPaging,
    required Input$TaxiOrderSortInput taxiSortFields,
    @Default([]) List<Input$ShopOrderSort> shopSortFields,
    @Default([]) List<Input$ParkOrderSort> parkingSortFields,
    required String currency,
    @Default(Enum$AppType.Taxi) Enum$AppType selectedCategory,
    @Default(Enum$KPIPeriod.Last7Days) Enum$KPIPeriod period,
  }) = _PlatformOverviewState;

  factory PlatformOverviewState.initial() {
    return PlatformOverviewState(
      currency: Env.defaultCurrency,
      taxiSortFields: Input$TaxiOrderSortInput(id: Enum$SortOrder.DESC),
    );
  }
}
