import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/graphql/fragments/admin_wallet.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/admin_wallet.graphql.mock.dart';
import 'package:admin_frontend/features/accounting/admin_accounting/admin_accounting_dashboard/data/repositories/admin_accounting_insert_transaction_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@dev
@LazySingleton(as: AdminAccountingInsertTransactionRepository)
class AdminAccountingInsertTransactionRepositoryMock
    implements AdminAccountingInsertTransactionRepository {
  @override
  Future<ApiResponse<Fragment$adminTransactionListItem>> insertTransaction({
    required Input$ProviderTransactionInput input,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(mockAdminTransaction1);
  }
}
