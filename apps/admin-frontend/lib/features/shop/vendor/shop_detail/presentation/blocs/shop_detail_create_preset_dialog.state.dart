part of 'shop_detail_create_preset_dialog.bloc.dart';

@freezed
sealed class ShopDetailCreatePresetDialogState
    with _$ShopDetailCreatePresetDialogState {
  const factory ShopDetailCreatePresetDialogState({
    @Default(ApiResponseInitial())
    ApiResponse<Fragment$shopItemPresetDetail?> presetState,
    String? shopId,
    String? presetId,
    String? name,
    @Default([]) List<Input$WeekdayScheduleInput> availabilitySchedule,
    @Default(ApiResponseInitial()) ApiResponse<void> submitState,
  }) = _ShopDetailCreatePresetDialogState;

  const ShopDetailCreatePresetDialogState._();

  Input$CreateShopItemPresetInput get toCreateInput =>
      Input$CreateShopItemPresetInput(
        name: name!,
        weeklySchedule: availabilitySchedule,
        shopId: shopId!,
      );

  Input$UpdateShopItemPresetInput get toUpdateInput =>
      Input$UpdateShopItemPresetInput(
        name: name!,
        weeklySchedule: availabilitySchedule,
      );
}
