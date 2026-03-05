part of 'regions.cubit.dart';

@freezed
sealed class RegionsState with _$RegionsState {
  const factory RegionsState({
    required ApiResponse<List<Fragment$regionCategory>> regionCategories,
    required ApiResponse<Query$regions> regions,
    String? categoryId,
    String? searchQuery,
    Input$OffsetPaging? paging,
  }) = _RegionsState;
}
