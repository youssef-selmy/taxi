import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/graphql/fragments/shop_order.graphql.dart';
import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/shop/shop_order/shop_order_detail/data/repositories/shop_order_detail_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

part 'shop_order_detail.state.dart';
part 'shop_order_detail.cubit.freezed.dart';

class ShopOrderDetailBloc extends Cubit<ShopOrderDetailState> {
  final ShopOrderDetailRepository _shopOrderDetailRepository =
      locator<ShopOrderDetailRepository>();

  ShopOrderDetailBloc() : super(ShopOrderDetailState());

  void onStarted(String id) {
    _fetchShopOrderDetail(id);
  }

  Future<void> _fetchShopOrderDetail(String id) async {
    emit(state.copyWith(shopOrderDetailState: const ApiResponse.loading()));

    final shopOrderDetailOrError = await _shopOrderDetailRepository
        .getShopOrderDetail(id: id);

    emit(state.copyWith(shopOrderDetailState: shopOrderDetailOrError));
  }

  Future<void> shopOrderDetailCancelOrder(
    Input$CancelShopOrderCartsInput input,
  ) async {
    var shopOrderDetailCancelOrderOrError = await _shopOrderDetailRepository
        .shopOrderDetailCancelOrder(input: input);
    final shopOrderDetailState = shopOrderDetailCancelOrderOrError;
    emit(state.copyWith(shopOrderDetailState: shopOrderDetailState));
  }

  Future<void> shopOrderDetailRemoveItem(
    Input$RemoveItemFromCartInput input,
  ) async {
    var shopOrderDetailRemoveItemOrError = await _shopOrderDetailRepository
        .shopOrderDetailRemoveItem(input: input);
    final shopOrderDetailState = shopOrderDetailRemoveItemOrError;
    emit(state.copyWith(shopOrderDetailState: shopOrderDetailState));
  }
}
