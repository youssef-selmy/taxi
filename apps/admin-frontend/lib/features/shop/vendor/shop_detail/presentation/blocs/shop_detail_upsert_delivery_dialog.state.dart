part of 'shop_detail_upsert_delivery_dialog.bloc.dart';

@freezed
sealed class ShopDetailUpsertDeliveryDialogState
    with _$ShopDetailUpsertDeliveryDialogState {
  const factory ShopDetailUpsertDeliveryDialogState({
    @Default(ApiResponseInitial())
    ApiResponse<Fragment$shopDeliveryRegion?> deliveryZoneState,
    String? shopId,
    String? regionId,
    String? name,
    @Default(0) double deliveryFee,
    @Default(0) int minDeliveryTimeMinutes,
    @Default(0) int maxDeliveryTimeMinutes,
    @Default(0) double minimumOrderAmount,
    @Default([]) List<Input$PointInput> location,
    @Default(ApiResponseInitial()) ApiResponse<void> submitState,
  }) = _ShopDetailUpsertDeliveryDialogState;

  const ShopDetailUpsertDeliveryDialogState._();

  Input$CreateShopDeliveryZoneInput get toCreateInput =>
      Input$CreateShopDeliveryZoneInput(
        name: name!,
        shopId: shopId!,
        deliveryFee: deliveryFee,
        minDeliveryTimeMinutes: minDeliveryTimeMinutes,
        maxDeliveryTimeMinutes: maxDeliveryTimeMinutes,
        minimumOrderAmount: minimumOrderAmount,
        location: [location],
      );

  Input$UpdateShopDeliveryZoneInput get toUpdateInput =>
      Input$UpdateShopDeliveryZoneInput(
        name: name!,
        deliveryFee: deliveryFee,
        minDeliveryTimeMinutes: minDeliveryTimeMinutes,
        maxDeliveryTimeMinutes: maxDeliveryTimeMinutes,
        minimumOrderAmount: minimumOrderAmount,
        location: [location],
      );
}
