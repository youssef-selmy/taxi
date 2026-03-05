part of 'shop_dispatcher.cubit.dart';

@freezed
sealed class ShopDispatcherState with _$ShopDispatcherState {
  const factory ShopDispatcherState({
    @Default(ApiResponse.initial())
    ApiResponse<Mutation$createShopOrder> networkState,
    @Default(0) int currentStep,
    @Default([]) List<Fragment$Address> customerAddresses,
    Fragment$CustomerCompact? selectedCustomer,
    Fragment$Address? selectedAddress,
    @Default([]) List<ShopCart> carts,
    @Default(ApiResponse.initial())
    ApiResponse<Query$retrieveCheckoutOptions> checkoutOptions,
    @Default(Enum$DeliveryMethod.BATCH) Enum$DeliveryMethod deliveryMethod,
    PaymentMethodEntity? paymentMethod,
    @Default(false) bool isSuccessful,
    Fragment$Place? searchLocation,
  }) = _ShopDispatcherState;

  const ShopDispatcherState._();

  // fromJson method
  // factory ShopDispatcherState.fromJson(Map<String, dynamic> json) => _$ShopDispatcherStateFromJson(json);

  String get currency =>
      carts.firstOrNull?.shop.currency ?? Env.defaultCurrency;

  double get deliveryFee {
    final fee = checkoutOptions.data?.calculateDeliveryFee;
    switch (deliveryMethod) {
      case Enum$DeliveryMethod.BATCH:
        return fee?.batchDeliveryFee ?? 0;
      case Enum$DeliveryMethod.SPLIT:
        return fee?.splitDeliveryFee ?? 0;
      case Enum$DeliveryMethod.SCHEDULED:
        return fee?.batchDeliveryFee ?? 0;
      default:
        return 0;
    }
  }

  double get subtotal {
    return carts.fold<double>(
      0,
      (previousValue, element) => previousValue + element.total,
    );
  }

  double get total {
    return subtotal + deliveryFee;
  }
}

@freezed
sealed class ShopCart with _$ShopCart {
  const factory ShopCart({
    required Fragment$DispatcherShop shop,
    @Default([]) List<ShopCartItem> items,
  }) = _ShopCart;

  const ShopCart._();

  // fromJson method
  // factory ShopCart.fromJson(Map<String, dynamic> json) => _$ShopCartFromJson(json);

  num get total => items.fold<num>(
    0,
    (previousValue, element) => previousValue + element.total,
  );

  Input$ShopOrderCartInput toInput() {
    return Input$ShopOrderCartInput(
      shopId: shop.id,
      items: items.map((e) => e.toInput()).toList(),
    );
  }
}

@freezed
sealed class ShopCartItem with _$ShopCartItem {
  const factory ShopCartItem({
    required Fragment$shopItemListItem item,
    required Fragment$ItemVariant itemVariant,
    required List<Fragment$ItemOption> itemOptions,
    required int quantity,
  }) = _ShopCartItem;

  // fromJson method
  // factory ShopCartItem.fromJson(Map<String, dynamic> json) => _$ShopCartItemFromJson(json);

  const ShopCartItem._();

  double get total {
    final itemPrice = itemVariant.price;
    final optionsPrice = itemOptions.fold<double>(
      0,
      (previousValue, element) => previousValue + element.price,
    );
    return (itemPrice + optionsPrice) * quantity;
  }

  Input$ShopOrderCartItemInput toInput() {
    return Input$ShopOrderCartItemInput(
      itemVariantId: itemVariant.id,
      productId: item.id,
      itemOptionIds: itemOptions.map((e) => e.id).toList(),
      quantity: quantity,
    );
  }
}
