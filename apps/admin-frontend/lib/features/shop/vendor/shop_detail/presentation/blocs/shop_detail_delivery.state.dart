part of 'shop_detail_delivery.bloc.dart';

@freezed
sealed class ShopDetailDeliveryState with _$ShopDetailDeliveryState {
  const factory ShopDetailDeliveryState({
    @Default(ApiResponseInitial())
    ApiResponse<Query$shopDeliveryZones> deliveryRegionsState,
    String? shopId,
    @Default(false) bool isExpressDeliveryAvailable,
    @Default(0) int expressDeliveryShopCommission,
    @Default(false) bool isShopDeliveryAvailable,
    Input$OffsetPaging? deliveryRegionsPaging,
    String? deliveryRegionsSearchQuery,
    @Default(ApiResponseInitial()) ApiResponse<void> deleteDeliveryRegionState,
  }) = _ShopDetailDeliveryState;
}
