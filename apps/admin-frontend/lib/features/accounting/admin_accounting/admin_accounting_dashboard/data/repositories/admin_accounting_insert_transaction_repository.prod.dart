import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/core/graphql/fragments/admin_wallet.graphql.dart';
import 'package:admin_frontend/features/accounting/admin_accounting/admin_accounting_dashboard/data/graphql/admin_accounting_insert_transaction.graphql.dart';
import 'package:admin_frontend/features/accounting/admin_accounting/admin_accounting_dashboard/data/repositories/admin_accounting_insert_transaction_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@prod
@LazySingleton(as: AdminAccountingInsertTransactionRepository)
class AdminAccountingInsertTransactionRepositoryImpl
    implements AdminAccountingInsertTransactionRepository {
  final GraphqlDatasource graphQLDatasource;

  AdminAccountingInsertTransactionRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<Fragment$adminTransactionListItem>> insertTransaction({
    required Input$ProviderTransactionInput input,
  }) async {
    final transactionOrError = await graphQLDatasource.mutate(
      Options$Mutation$insertAdminTransaction(
        variables: Variables$Mutation$insertAdminTransaction(input: input),
      ),
    );
    return transactionOrError.mapData((r) => r.createOneProviderTransaction);
  }
}
