part of 'taxi_overview.bloc.dart';

@freezed
class TaxiOverviewEvent with _$TaxiOverviewEvent {
  const factory TaxiOverviewEvent.started({required String currency}) =
      TaxiOverviewStarted;
  const factory TaxiOverviewEvent.currencyChanged(String currency) =
      TaxiOverviewCurrencyChanged;

  const factory TaxiOverviewEvent.activeOrdersPageChanged(
    Input$OffsetPaging page,
  ) = TaxiOverviewActiveOrdersPageChanged;

  const factory TaxiOverviewEvent.driversInViewPortFetch({
    required Input$BoundsInput bounds,
  }) = TaxiOverviewDriversInViewPortFetch;

  const factory TaxiOverviewEvent.pendingDriversRefresh() =
      TaxiOverviewPendingDriversRefresh;
}
