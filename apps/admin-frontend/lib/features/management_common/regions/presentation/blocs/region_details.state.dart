part of 'region_details.cubit.dart';

@freezed
sealed class RegionDetailsState with _$RegionDetailsState {
  const factory RegionDetailsState({
    String? regionId,
    String? regionCategoryId,
    String? name,
    required String currency,
    @Default(true) bool enabled,
    @Default([]) List<List<Input$PointInput>> location,
    @Default([]) List<Fragment$regionCategory> regionCategories,
    required ApiResponse<Fragment$region?> region,
    required ApiResponse<void> networkStateSave,
  }) = _RegionDetailsState;

  const RegionDetailsState._();

  // initial state
  factory RegionDetailsState.initial() => RegionDetailsState(
    region: const ApiResponse.initial(),
    networkStateSave: const ApiResponse.initial(),
    currency: Env.defaultCurrency,
  );

  Input$CreateRegionInput get toCreateInput => Input$CreateRegionInput(
    name: name!,
    currency: currency,
    enabled: enabled,
    location: location,
    categoryId: regionCategoryId,
  );

  Input$UpdateRegionInput get toUpdateInput => Input$UpdateRegionInput(
    name: name!,
    currency: currency,
    enabled: enabled,
    location: location,
    categoryId: regionCategoryId,
  );
}
