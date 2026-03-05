import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/features/taxi/taxi_order/taxi_order_detail/presentation/features/taxi_order_detail_transactions/data/graphql/taxi_order_detail_transactions.graphql.dart';
import 'package:admin_frontend/features/taxi/taxi_order/taxi_order_detail/presentation/features/taxi_order_detail_transactions/data/repositories/taxi_order_detail_transactions_repository.dart';

@prod
@LazySingleton(as: TaxiOrderDetailTransactionsRepository)
class TaxiOrderDetailTransactionsRepositoryImpl
    implements TaxiOrderDetailTransactionsRepository {
  final GraphqlDatasource graphQLDatasource;

  TaxiOrderDetailTransactionsRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<Query$getTaxiOrderDetailTransactions>>
  getTaxiOrderTransactions({required String orderId}) async {
    final getTaxiOrderTransaction = await graphQLDatasource.query(
      Options$Query$getTaxiOrderDetailTransactions(
        variables: Variables$Query$getTaxiOrderDetailTransactions(
          orderId: orderId,
        ),
      ),
    );
    return getTaxiOrderTransaction;
  }
}
