import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/graphql/fragments/customer_transaction.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/driver_transaction.fragment.graphql.dart';
import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/shop/shop_order/shop_order_detail/presentation/features/shop_order_detail_transactions/data/graphql/shop_order_detail_transactions.graphql.dart';
import 'package:admin_frontend/features/shop/shop_order/shop_order_detail/presentation/features/shop_order_detail_transactions/data/repositories/shop_order_detail_transactions_repository.dart';

part 'shop_order_detail_transactions.state.dart';
part 'shop_order_detail_transactions.cubit.freezed.dart';

class ShopOrderDetailTransactionsBloc
    extends Cubit<ShopOrderDetailTransactionsState> {
  final ShopOrderDetailTransactionsRepository
  _shopOrderDetailTransactionRepository =
      locator<ShopOrderDetailTransactionsRepository>();

  ShopOrderDetailTransactionsBloc() : super(ShopOrderDetailTransactionsState());

  void onStarted(String orderId) {
    _fetchShopOrderDetailTransaction(orderId);
  }

  Future<void> _fetchShopOrderDetailTransaction(String orderId) async {
    emit(state.copyWith(shopOrderTransactions: const ApiResponse.loading()));

    final shopOrderTransactionsOrError =
        await _shopOrderDetailTransactionRepository.getShopOrderTransactions(
          orderId: orderId,
        );

    emit(state.copyWith(shopOrderTransactions: shopOrderTransactionsOrError));
  }
}
