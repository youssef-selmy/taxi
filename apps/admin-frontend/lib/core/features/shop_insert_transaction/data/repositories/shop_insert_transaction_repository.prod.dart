import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/core/features/shop_insert_transaction/data/graphql/shop_insert_transaction.graphql.dart';
import 'package:admin_frontend/core/features/shop_insert_transaction/data/repositories/shop_insert_transaction_repository.dart';
import 'package:admin_frontend/core/graphql/fragments/shop_transaction.fragment.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

@prod
@LazySingleton(as: ShopInsertTransactionRepository)
class ShopInsertTransactionRepositoryImpl
    implements ShopInsertTransactionRepository {
  final GraphqlDatasource graphQLDatasource;

  ShopInsertTransactionRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<Fragment$shopTransaction>> insertTransaction({
    required String shopId,
    required Enum$TransactionType type,
    Enum$ShopTransactionCreditType? creditType,
    Enum$ShopTransactionDebitType? debitType,
    required String currency,
    required double amount,
    required String referenceNumber,
    required String description,
  }) async {
    final transaction = await graphQLDatasource.mutate(
      Options$Mutation$insertShopTransaction(
        variables: Variables$Mutation$insertShopTransaction(
          input: Input$CreateShopTransactionInput(
            type: type,
            creditType: creditType,
            debitType: debitType,
            amount: amount,
            currency: currency,
            shopId: shopId,
          ),
        ),
      ),
    );
    return transaction.mapData((r) => r.createOneShopTransaction);
  }
}
