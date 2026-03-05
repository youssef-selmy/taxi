part of 'taxi_orders_list.bloc.dart';

@freezed
sealed class TaxiOrdersListEvent with _$TaxiOrdersListEvent {
  const factory TaxiOrdersListEvent.started() = _Started;
  const factory TaxiOrdersListEvent.onOrderSelected({required String orderId}) =
      _OnOrderSelected;
  const factory TaxiOrdersListEvent.pageChanged(Input$OffsetPaging paging) =
      _PageChanged;
  const factory TaxiOrdersListEvent.sortingChanged(
    List<Input$OrderSort> sorting,
  ) = _SortingChanged;
  const factory TaxiOrdersListEvent.selectOrder(String orderId) = _SelectOrder;
  const factory TaxiOrdersListEvent.fleetFilterChanged(
    List<Fragment$fleetListItem> fleetFilter,
  ) = _FleetFilterChanged;
  const factory TaxiOrdersListEvent.statusFilterChanged(
    List<Enum$TaxiOrderStatus> statusFilter,
  ) = _StatusFilterChanged;
  const factory TaxiOrdersListEvent.mapViewControllerChanged(
    MapViewController? mapViewController,
  ) = _MapViewControllerChanged;
}
