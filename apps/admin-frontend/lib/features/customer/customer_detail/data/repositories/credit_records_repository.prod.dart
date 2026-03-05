import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/components/wallet_balance/wallet_balance_item.dart';
import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/core/graphql/fragments/wallet.graphql.extensions.dart';
import 'package:admin_frontend/features/customer/customer_detail/data/graphql/credit_records.graphql.dart';
import 'package:admin_frontend/features/customer/customer_detail/data/repositories/credit_records_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@prod
@LazySingleton(as: CreditRecordsRepository)
class CreditRecordsRepositoryImpl implements CreditRecordsRepository {
  final GraphqlDatasource graphQLDatasource;

  CreditRecordsRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<Query$customerCreditRecords>> getCreditRecords({
    required String customerId,
    required Input$OffsetPaging? paging,
    required List<Enum$TransactionStatus>? status,
    required List<Enum$TransactionAction>? action,
    required List<Input$RiderTransactionSort>? sort,
  }) async {
    final queryResult = await graphQLDatasource.query(
      Options$Query$customerCreditRecords(
        variables: Variables$Query$customerCreditRecords(
          filter: Input$RiderTransactionFilter(
            riderId: Input$IDFilterComparison(eq: customerId),
            status: status?.isEmpty ?? true
                ? null
                : Input$TransactionStatusFilterComparison($in: status),
            action: status?.isEmpty ?? true
                ? null
                : Input$TransactionActionFilterComparison($in: action),
          ),
          sorting: sort,
          paging: paging,
        ),
      ),
    );
    return queryResult;
  }

  @override
  Future<ApiResponse<List<WalletBalanceItem>>> getWalletBalance({
    required String customerId,
  }) async {
    final walletItems = await graphQLDatasource.query(
      Options$Query$customerWallets(
        variables: Variables$Query$customerWallets(riderId: customerId),
      ),
    );
    return walletItems.mapData(
      (wallet) => wallet.riderWallets.nodes.toWalletBalanceItems(),
    );
  }

  @override
  Future<ApiResponse<String>> exportCreditRecords({
    required List<Input$RiderTransactionSort> sort,
    required Input$RiderTransactionFilter filter,
    required Enum$ExportFormat format,
  }) async {
    final result = await graphQLDatasource.query(
      Options$Query$exportCustomerTransactions(
        variables: Variables$Query$exportCustomerTransactions(
          filter: filter,
          format: format,
          sorting: sort,
        ),
      ),
    );
    return result.mapData((data) => data.exportRiderTransactions);
  }
}
