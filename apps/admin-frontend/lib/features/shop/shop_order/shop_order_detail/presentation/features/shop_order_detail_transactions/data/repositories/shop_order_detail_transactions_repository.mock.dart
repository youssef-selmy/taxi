import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/graphql/fragments/customer_transaction.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/driver_transaction.fragment.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/provider_transaction.fragment.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/shop.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/shop_transaction.fragment.graphql.mock.dart';
import 'package:admin_frontend/features/shop/shop_order/shop_order_detail/presentation/features/shop_order_detail_transactions/data/graphql/shop_order_detail_transactions.graphql.dart';
import 'package:admin_frontend/features/shop/shop_order/shop_order_detail/presentation/features/shop_order_detail_transactions/data/repositories/shop_order_detail_transactions_repository.dart';

@dev
@LazySingleton(as: ShopOrderDetailTransactionsRepository)
class ShopOrderDetailTransactionsRepositoryMock
    implements ShopOrderDetailTransactionsRepository {
  @override
  Future<ApiResponse<Query$getShopOrderTransactions>> getShopOrderTransactions({
    required String orderId,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Query$getShopOrderTransactions(
        shopOrder: Query$getShopOrderTransactions$shopOrder(
          currency: 'USD',
          shopTransactions: [
            Query$getShopOrderTransactions$shopOrder$shopTransactions(
              shop: mockFragmentShopBasic1,
              shopTransactions: mockShopTransactions,
            ),
          ],
          providerTransactions: [
            Query$getShopOrderTransactions$shopOrder$providerTransactions(
              providerTransactions: mockProviderTransactionList,
              shop: mockFragmentShopBasic2,
            ),
          ],
          riderTransactions: mockCustomerTransactions,
          driverTransactions: mockDriverTransactionList,
        ),
      ),
    );
  }
}
