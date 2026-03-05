import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/features/shop/shop_payout_session/shop_payout_session_list/data/graphql/shop_payout_session_list.graphql.dart';
import 'package:admin_frontend/features/shop/shop_payout_session/shop_payout_session_list/data/repositories/shop_payout_session_list_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@prod
@LazySingleton(as: ShopPayoutSessionListRepository)
class ShopPayoutSessionListRepositoryImpl
    implements ShopPayoutSessionListRepository {
  final GraphqlDatasource graphQLDatasource;

  ShopPayoutSessionListRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<Query$shopsPayoutTransactions>>
  getShopsPayoutTransactions({
    required Input$OffsetPaging? paging,
    required List<Input$ShopTransactionSort> sorting,
    required Input$ShopTransactionFilter filter,
  }) async {
    final transactionsOrError = await graphQLDatasource.query(
      Options$Query$shopsPayoutTransactions(
        variables: Variables$Query$shopsPayoutTransactions(
          paging: paging,
          filter: filter,
          sorting: sorting,
        ),
      ),
    );
    return transactionsOrError;
  }

  @override
  Future<ApiResponse<Query$shopsPayoutSessions>> getShopsPayoutSessions({
    required Input$OffsetPaging? paging,
    required List<Input$ShopPayoutSessionSort> sorting,
    required Input$ShopPayoutSessionFilter filter,
  }) async {
    final sessionsOrError = await graphQLDatasource.query(
      Options$Query$shopsPayoutSessions(
        variables: Variables$Query$shopsPayoutSessions(
          paging: paging,
          sorting: sorting,
          filter: filter,
        ),
      ),
    );
    return sessionsOrError;
  }

  @override
  Future<ApiResponse<Query$shopsPendingPayoutSessions>>
  getShopsPendingPayoutSessions() async {
    final pendingSessionsOrError = await graphQLDatasource.query(
      Options$Query$shopsPendingPayoutSessions(),
    );
    return pendingSessionsOrError;
  }
}
