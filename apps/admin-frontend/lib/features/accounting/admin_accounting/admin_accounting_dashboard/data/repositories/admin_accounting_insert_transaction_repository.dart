import 'package:api_response/api_response.dart';

import 'package:admin_frontend/core/graphql/fragments/admin_wallet.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

abstract class AdminAccountingInsertTransactionRepository {
  Future<ApiResponse<Fragment$adminTransactionListItem>> insertTransaction({
    required Input$ProviderTransactionInput input,
  });
}
