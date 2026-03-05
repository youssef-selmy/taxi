import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/core/features/parking_insert_transaction/data/graphql/parking_insert_transaction.graphql.dart';
import 'package:admin_frontend/core/features/parking_insert_transaction/data/repositories/parking_insert_transaction_repository.dart';
import 'package:admin_frontend/core/graphql/fragments/parking_transaction.fragment.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

@prod
@LazySingleton(as: ParkingInsertTransactionRepository)
class ParkingInsertTransactionRepositoryImpl
    implements ParkingInsertTransactionRepository {
  final GraphqlDatasource graphQLDatasource;

  ParkingInsertTransactionRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<Fragment$parkingTransaction>> insertTransaction({
    required String parkingId,
    required Enum$TransactionType type,
    Enum$ParkingTransactionCreditType? creditType,
    Enum$ParkingTransactionDebitType? debitType,
    required String currency,
    required double amount,
    required String referenceNumber,
    required String description,
  }) async {
    final transaction = await graphQLDatasource.mutate(
      Options$Mutation$insertParkingTransaction(
        variables: Variables$Mutation$insertParkingTransaction(
          input: Input$CreateParkingTransactionInput(
            type: type,
            creditType: creditType,
            debitType: debitType,
            amount: amount,
            currency: currency,
            customerId: parkingId,
          ),
        ),
      ),
    );
    return transaction.mapData((r) => r.createOneParkingTransaction);
  }
}
