import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/features/accounting/customer_accounting/customer_accounting_detail/data/graphql/customer_accounting_detail.graphql.dart';
import 'package:admin_frontend/features/accounting/customer_accounting/customer_accounting_detail/data/repositories/customer_accounting_detail_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@prod
@LazySingleton(as: CustomerAccountingDetailRepository)
class CustomerAccountingDetailRepositoryImpl
    implements CustomerAccountingDetailRepository {
  final GraphqlDatasource graphQLDatasource;

  CustomerAccountingDetailRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<Query$customerTransactions>> getCustomerTransactions({
    required String currency,
    required List<Enum$TransactionAction> actionFilter,
    required List<Enum$TransactionStatus> statusFilter,
    required String riderId,
    required List<Input$RiderTransactionSort> sorting,
    required Input$OffsetPaging? paging,
  }) async {
    final customerTransactionsOrError = await graphQLDatasource.query(
      Options$Query$customerTransactions(
        variables: Variables$Query$customerTransactions(
          filter: Input$RiderTransactionFilter(
            currency: Input$StringFieldComparison(eq: currency),
            riderId: Input$IDFilterComparison(eq: riderId),
            status: statusFilter.isNotEmpty
                ? Input$TransactionStatusFilterComparison($in: statusFilter)
                : null,
            action: actionFilter.isNotEmpty
                ? Input$TransactionActionFilterComparison($in: actionFilter)
                : null,
          ),
          sorting: sorting,
          paging: paging,
        ),
      ),
    );
    return customerTransactionsOrError;
  }

  @override
  Future<ApiResponse<Query$customerWalletDetailSummary>>
  getWalletDetailSummary({required String riderId}) async {
    final walletDetailSummaryOrError = await graphQLDatasource.query(
      Options$Query$customerWalletDetailSummary(
        variables: Variables$Query$customerWalletDetailSummary(
          customerId: riderId,
        ),
      ),
    );
    return walletDetailSummaryOrError;
  }
}
