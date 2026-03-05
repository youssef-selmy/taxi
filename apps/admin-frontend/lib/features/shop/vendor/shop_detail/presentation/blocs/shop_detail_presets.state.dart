part of 'shop_detail_presets.cubit.dart';

@freezed
sealed class ShopDetailPresetsState with _$ShopDetailPresetsState {
  const factory ShopDetailPresetsState({
    @Default(ApiResponseInitial()) ApiResponse<Query$shopPresets> presetsState,
    String? shopId,
    String? searchQuery,
    Input$OffsetPaging? paging,
  }) = _ShopDetailPresetsState;
}
