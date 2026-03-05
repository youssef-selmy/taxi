import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/graphql/fragments/shop_order.graphql.dart';
import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/shop/vendor/shop_detail/data/repositories/shop_detail_orders_repository.dart';

part 'shop_detail_order_detail_dialog.state.dart';
part 'shop_detail_order_detail_dialog.bloc.freezed.dart';

class ShopDetailOrderDetailDialogBloc
    extends Cubit<ShopDetailOrderDetailDialogState> {
  final ShopDetailOrdersRepository _ordersRepository =
      locator<ShopDetailOrdersRepository>();

  ShopDetailOrderDetailDialogBloc() : super(ShopDetailOrderDetailDialogState());

  void onStarted({required String orderId}) {
    emit(state.copyWith(orderId: orderId));
    _fetchOrderDetail();
  }

  @override
  Future<void> close() {
    locator.unregister<ShopDetailOrdersRepository>();
    return super.close();
  }

  void _fetchOrderDetail() async {
    emit(state.copyWith(orderState: const ApiResponse.loading()));
    final orderDetailOrError = await _ordersRepository.getOrderDetail(
      orderId: state.orderId!,
    );
    final orderDetailState = orderDetailOrError;
    emit(state.copyWith(orderState: orderDetailState));
  }
}
