part of 'region_category_details.cubit.dart';

@freezed
sealed class RegionCategoryDetailsState with _$RegionCategoryDetailsState {
  const factory RegionCategoryDetailsState({
    String? regionCategoryId,
    String? name,
    required String currency,
    required ApiResponse<Fragment$regionCategory?> regionCategory,
    required ApiResponse<void> networkStateSave,
  }) = _RegionCategoryDetailsState;

  factory RegionCategoryDetailsState.initial() => RegionCategoryDetailsState(
    regionCategory: const ApiResponse.initial(),
    networkStateSave: const ApiResponse.initial(),
    currency: Env.defaultCurrency,
  );
}
