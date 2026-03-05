import 'package:api_response/api_response.dart';

import 'package:admin_frontend/core/graphql/fragments/shop_transaction.fragment.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

abstract class ShopInsertTransactionRepository {
  Future<ApiResponse<Fragment$shopTransaction>> insertTransaction({
    required String shopId,
    required Enum$TransactionType type,
    Enum$ShopTransactionCreditType? creditType,
    Enum$ShopTransactionDebitType? debitType,
    required String currency,
    required double amount,
    required String referenceNumber,
    required String description,
  });
}
