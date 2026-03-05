import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/features/shop/shop_order/shop_order_detail/presentation/features/shop_order_detail_transactions/data/graphql/shop_order_detail_transactions.graphql.dart';
import 'package:admin_frontend/features/shop/shop_order/shop_order_detail/presentation/features/shop_order_detail_transactions/data/repositories/shop_order_detail_transactions_repository.dart';

@prod
@LazySingleton(as: ShopOrderDetailTransactionsRepository)
class ShopOrderDetailTransactionsRepositoryImpl
    implements ShopOrderDetailTransactionsRepository {
  final GraphqlDatasource graphQLDatasource;

  ShopOrderDetailTransactionsRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<Query$getShopOrderTransactions>> getShopOrderTransactions({
    required String orderId,
  }) async {
    final getTransactions = await graphQLDatasource.query(
      Options$Query$getShopOrderTransactions(
        variables: Variables$Query$getShopOrderTransactions(orderId: orderId),
      ),
    );
    return getTransactions;
  }
}
