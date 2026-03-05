part of 'zone_price_details.bloc.dart';

@freezed
sealed class ZonePriceDetailsState with _$ZonePriceDetailsState {
  const factory ZonePriceDetailsState({
    String? zonePriceId,
    String? zonePriceCategoryId,
    String? name,
    @Default(0) double cost,
    @Default([]) List<List<Input$PointInput>> from,
    @Default([]) List<List<Input$PointInput>> to,
    @Default([]) List<String> serviceIds,
    @Default([]) List<String> fleetIds,
    @Default([]) List<Fragment$taxiPricingListItem> services,
    @Default([]) List<Fragment$fleetListItem> fleets,
    @Default([]) List<Fragment$zonePriceCategory> zonePriceCategories,
    @Default([]) List<Input$TimeMultiplierInput> timeMultipliers,
    required ApiResponse<Fragment$zonePrice?> zonePrice,
    required ApiResponse<void> networkStateSave,
  }) = _ZonePriceDetailsState;

  const ZonePriceDetailsState._();

  factory ZonePriceDetailsState.initial() => ZonePriceDetailsState(
    zonePrice: const ApiResponse.initial(),
    networkStateSave: const ApiResponse.initial(),
  );

  Input$ZonePriceInput get toCreateInput => Input$ZonePriceInput(
    name: name!,
    from: from,
    to: to,
    cost: cost,
    timeMultipliers: timeMultipliers,
  );
}
