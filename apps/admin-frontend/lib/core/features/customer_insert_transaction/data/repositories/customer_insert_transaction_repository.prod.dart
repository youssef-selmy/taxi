import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/core/features/customer_insert_transaction/data/graphql/customer_insert_transaction.graphql.dart';
import 'package:admin_frontend/core/features/customer_insert_transaction/data/repositories/customer_insert_transaction_repository.dart';
import 'package:admin_frontend/core/graphql/fragments/customer_transaction.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

@prod
@LazySingleton(as: CustomerInsertTransactionRepository)
class CustomerInsertTransactionRepositoryImpl
    implements CustomerInsertTransactionRepository {
  final GraphqlDatasource graphQLDatasource;

  CustomerInsertTransactionRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<Fragment$customerTransaction>> insertTransaction({
    required String customerId,
    required Enum$TransactionAction action,
    Enum$RiderRechargeTransactionType? rechargeType,
    Enum$RiderDeductTransactionType? deductType,
    required String currency,
    required double amount,
    required String referenceNumber,
    required String description,
  }) async {
    final transaction = await graphQLDatasource.mutate(
      Options$Mutation$insertCustomerTransaction(
        variables: Variables$Mutation$insertCustomerTransaction(
          input: Input$RiderTransactionInput(
            action: action,
            amount: amount,
            currency: currency,
            riderId: customerId,
          ),
        ),
      ),
    );
    return transaction.mapData((r) => r.createOneRiderTransaction);
  }
}
