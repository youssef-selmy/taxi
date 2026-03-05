import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/features/parking/parking_order/parking_order_detail/presentation/features/parking_order_detail_transactions/data/graphql/parking_order_detail_transactions.graphql.dart';
import 'package:admin_frontend/features/parking/parking_order/parking_order_detail/presentation/features/parking_order_detail_transactions/data/repositories/parking_order_detail_transactions_repository.dart';

@prod
@LazySingleton(as: ParkingOrderDetailTransactionsRepository)
class ParkingOrderDetailTransactionsRepositoryImpl
    implements ParkingOrderDetailTransactionsRepository {
  final GraphqlDatasource graphQLDatasource;

  ParkingOrderDetailTransactionsRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<Query$parkingOrderTransactions>>
  getParkingOrderDetailTransactions({required String parkingOrderId}) async {
    final getParkingOrderDetailTransactions = await graphQLDatasource.query(
      Options$Query$parkingOrderTransactions(
        variables: Variables$Query$parkingOrderTransactions(
          parkingId: parkingOrderId,
        ),
      ),
    );
    return getParkingOrderDetailTransactions;
  }
}
