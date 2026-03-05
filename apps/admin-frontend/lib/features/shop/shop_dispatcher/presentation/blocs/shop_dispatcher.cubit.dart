import 'package:admin_frontend/config/env.dart';
import 'package:admin_frontend/core/graphql/fragments/coordinate.fragment.graphql.dart';
import 'package:api_response/api_response.dart';
import 'package:better_design_system/entities/payment_method.entity.dart';
import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'package:admin_frontend/core/graphql/fragments/address.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/customer.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/shop.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/shop_item.fragment.graphql.dart';
import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/core/repositories/customers_repository.dart';
import 'package:admin_frontend/features/shop/shop_dispatcher/data/graphql/create_order.graphql.dart';
import 'package:admin_frontend/features/shop/shop_dispatcher/data/repositories/shop_dispatcher_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

part 'shop_dispatcher.state.dart';
part 'shop_dispatcher.cubit.freezed.dart';

class ShopDispatcherBloc extends Cubit<ShopDispatcherState> {
  final ShopDispatcherRepository _repository =
      locator<ShopDispatcherRepository>();
  final CustomersRepository _customersRepository =
      locator<CustomersRepository>();

  ShopDispatcherBloc() : super(ShopDispatcherState());

  void onSearchLocationChanged(Fragment$Place value) {
    emit(state.copyWith(searchLocation: value));
  }

  void onCustomerSelected(Fragment$CustomerCompact e) async {
    emit(state.copyWith(networkState: const ApiResponse.loading()));
    final result = await _customersRepository.getCustomerAddresses(
      customerId: e.id,
    );
    result.fold(
      (l, {failure}) =>
          emit(state.copyWith(networkState: ApiResponse.error(l.toString()))),
      (r) => emit(
        state.copyWith(
          selectedCustomer: e,
          selectedAddress: r.firstOrNull,
          customerAddresses: r,
          currentStep: 1,
          networkState: const ApiResponse.initial(),
        ),
      ),
    );
  }

  void onAddressSelected(Fragment$Address e) =>
      emit(state.copyWith(selectedAddress: e));

  void onAddressConfirmed() => emit(state.copyWith(currentStep: 2));

  void onItemsConfirmed() async {
    emit(
      state.copyWith(
        currentStep: 3,
        checkoutOptions: const ApiResponse.loading(),
      ),
    );
    final checkoutOptions = await _repository.retrieveCheckoutOptions(
      customerId: state.selectedCustomer!.id,
      calculateFareInput: Input$CalculateDeliveryFeeInput(
        carts: state.carts.map((cart) => cart.toInput()).toList(),
        deliveryAddressId: state.selectedAddress!.id,
      ),
    );
    emit(state.copyWith(checkoutOptions: checkoutOptions));
  }

  void onDeliveryMethodSelected(Enum$DeliveryMethod e) =>
      emit(state.copyWith(deliveryMethod: e));

  void onPaymentMethodSelected(PaymentMethodEntity e) =>
      emit(state.copyWith(paymentMethod: e));

  void goBack() => emit(state.copyWith(currentStep: state.currentStep - 1));

  void onAddToCart({
    required Fragment$DispatcherShop shop,
    required Fragment$shopItemListItem item,
    required Fragment$ItemVariant itemVariant,
    required List<Fragment$ItemOption> itemOptions,
    required int quantity,
  }) {
    final cart = state.carts.firstWhere(
      (element) => element.shop.id == shop.id,
      orElse: () => ShopCart(shop: shop),
    );

    final existingItem = cart.items.firstWhereOrNull(
      (element) => element.item.id == item.id,
    );

    if (existingItem != null) {
      final updatedItem = existingItem.copyWith(
        quantity: existingItem.quantity + quantity,
      );
      final newItems = cart.items
          .map((e) => e.item.id == item.id ? updatedItem : e)
          .toList();
      final updatedCart = cart.copyWith(items: newItems);
      final newCarts = [...state.carts]
        ..removeWhere((element) => element.shop.id == shop.id)
        ..add(updatedCart);
      emit(state.copyWith(carts: newCarts));
    } else {
      final itemCart = ShopCartItem(
        item: item,
        itemVariant: itemVariant,
        itemOptions: itemOptions,
        quantity: quantity,
      );

      final newCart = cart.copyWith(items: [...cart.items, itemCart]);

      final newCarts = [...state.carts]
        ..removeWhere((element) => element.shop.id == shop.id)
        ..add(newCart);

      emit(state.copyWith(carts: newCarts));
    }
  }

  void changeQuantity({
    required ShopCart cart,
    required ShopCartItem item,
    required int quantity,
  }) {
    final shop = state.carts.firstWhere(
      (element) => element.shop.id == cart.shop.id,
    );
    if (quantity == 0) {
      final newItems = shop.items
          .where((e) => e.item.id != item.item.id)
          .toList();
      if (newItems.isNotEmpty) {
        emit(
          state.copyWith(
            carts: [
              ...state.carts.where(
                (element) => element.shop.id != cart.shop.id,
              ),
              shop.copyWith(items: newItems),
            ],
          ),
        );
      } else {
        emit(
          state.copyWith(
            carts: state.carts
                .where((element) => element.shop.id != cart.shop.id)
                .toList(),
          ),
        );
      }
      return;
    }
    final newItems = shop.items.map((e) {
      if (e.item.id == item.item.id) {
        return e.copyWith(quantity: quantity);
      }
      return e;
    }).toList();
    emit(
      state.copyWith(
        carts: [
          ...state.carts.where((element) => element.shop.id != cart.shop.id),
          shop.copyWith(items: newItems),
        ],
      ),
    );
  }

  void onConfirmOrder() async {
    emit(state.copyWith(networkState: const ApiResponse.loading()));
    final input = Input$ShopOrderInput(
      deliveryAddressId: state.selectedAddress!.id,
      deliveryMethod: state.deliveryMethod,
      carts: state.carts.map((e) => e.toInput()).toList(),
    );
    final order = await _repository.createOrder(input: input);
    emit(state.copyWith(networkState: order, isSuccessful: order.isLoaded));
  }

  // @override
  // ShopDispatcherState? fromJson(Map<String, dynamic> json) => ShopDispatcherState.fromJson(json);

  // @override
  // Map<String, dynamic>? toJson(ShopDispatcherState state) => state.toJson();
}
