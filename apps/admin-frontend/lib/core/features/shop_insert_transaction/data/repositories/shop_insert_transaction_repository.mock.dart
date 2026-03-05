import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/features/shop_insert_transaction/data/repositories/shop_insert_transaction_repository.dart';
import 'package:admin_frontend/core/graphql/fragments/shop_transaction.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/shop_transaction.fragment.graphql.mock.dart';
import 'package:admin_frontend/schema.graphql.dart';

@dev
@LazySingleton(as: ShopInsertTransactionRepository)
class ShopInsertTransactionRepositoryMock
    implements ShopInsertTransactionRepository {
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
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(mockShopTransaction1);
  }
}
