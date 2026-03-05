import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/core/features/driver_insert_transaction/data/graphql/driver_insert_transaction.graphql.dart';
import 'package:admin_frontend/core/features/driver_insert_transaction/data/repositories/driver_insert_transaction_repository.dart';
import 'package:admin_frontend/core/graphql/fragments/driver_transaction.fragment.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

@prod
@LazySingleton(as: DriverInsertTransactionRepository)
class DriverInsertTransactionRepositoryImpl
    implements DriverInsertTransactionRepository {
  final GraphqlDatasource graphQLDatasource;

  DriverInsertTransactionRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<Fragment$driverTransaction>> insertTransaction({
    required String driverId,
    required Enum$TransactionAction action,
    Enum$DriverRechargeTransactionType? rechargeType,
    Enum$DriverDeductTransactionType? deductType,
    required String currency,
    required double amount,
    required String referenceNumber,
    required String description,
  }) async {
    final transaction = await graphQLDatasource.mutate(
      Options$Mutation$insertDriverTransaction(
        variables: Variables$Mutation$insertDriverTransaction(
          input: Input$DriverTransactionInput(
            action: action,
            amount: amount,
            currency: currency,
            driverId: driverId,
          ),
        ),
      ),
    );
    return transaction.mapData((r) => r.createOneDriverTransaction);
  }
}
