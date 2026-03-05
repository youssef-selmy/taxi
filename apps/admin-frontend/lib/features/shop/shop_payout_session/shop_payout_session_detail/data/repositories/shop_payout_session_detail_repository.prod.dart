import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/core/graphql/fragments/shop_payout.fragment.graphql.dart';
import 'package:admin_frontend/features/shop/shop_payout_session/shop_payout_session_detail/data/graphql/shop_payout_session_detail.graphql.dart';
import 'package:admin_frontend/features/shop/shop_payout_session/shop_payout_session_detail/data/repositories/shop_payout_session_detail_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@prod
@LazySingleton(as: ShopPayoutSessionDetailRepository)
class ShopPayoutSessionDetailRepositoryImpl
    implements ShopPayoutSessionDetailRepository {
  final GraphqlDatasource graphQLDatasource;

  ShopPayoutSessionDetailRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<Fragment$shopPayoutSessionDetail>> getPayoutSessionDetail({
    required String id,
  }) async {
    final payoutSessionDetailOrError = await graphQLDatasource.query(
      Options$Query$shopPayoutSession(
        variables: Variables$Query$shopPayoutSession(id: id),
      ),
    );
    return payoutSessionDetailOrError.mapData((r) => r.shopPayoutSession);
  }

  @override
  Future<ApiResponse<Fragment$shopPayoutSessionDetail>>
  updatePayoutSessionStatus({
    required String id,
    required Enum$PayoutSessionStatus status,
  }) async {
    final updatedPayoutSessionOrError = await graphQLDatasource.mutate(
      Options$Mutation$updateShopPayoutSessionStatus(
        variables: Variables$Mutation$updateShopPayoutSessionStatus(
          id: id,
          status: status,
        ),
      ),
    );
    return updatedPayoutSessionOrError.mapData(
      (r) => r.updateOneShopPayoutSession,
    );
  }

  @override
  Future<ApiResponse<Query$shopPayoutSessionPayoutMethodShopTransactions>>
  getShopTransactions({
    required String payoutSessionPayoutMethodId,
    required Input$OffsetPaging? paging,
  }) async {
    final shopTransactionsOrError = await graphQLDatasource.query(
      Options$Query$shopPayoutSessionPayoutMethodShopTransactions(
        variables:
            Variables$Query$shopPayoutSessionPayoutMethodShopTransactions(
              paging: paging,
              payoutSessionPayoutMethodId: payoutSessionPayoutMethodId,
            ),
      ),
    );
    return shopTransactionsOrError;
  }

  @override
  Future<ApiResponse<String>> exportPayoutToCSV({
    required String payoutSessionId,
    required String payoutMethodId,
  }) async {
    final exportPayoutToCSVOrError = await graphQLDatasource.mutate(
      Options$Mutation$shopExportPayoutToCSV(
        variables: Variables$Mutation$shopExportPayoutToCSV(
          payoutSessionId: payoutSessionId,
          payoutMethodId: payoutMethodId,
        ),
      ),
    );
    return exportPayoutToCSVOrError.mapData(
      (r) => r.exportShopPayoutSessionToCsv,
    );
  }

  @override
  Future<ApiResponse<void>> runAutoPayout({
    required String payoutSessionId,
    required String payoutMethodId,
  }) async {
    final runAutoPayoutOrError = await graphQLDatasource.mutate(
      Options$Mutation$shopAutomaticPayout(
        variables: Variables$Mutation$shopAutomaticPayout(
          payoutSessionId: payoutSessionId,
          payoutMethodId: payoutMethodId,
        ),
      ),
    );
    return runAutoPayoutOrError.mapData((r) => r.runShopAutoPayout);
  }
}
