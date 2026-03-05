import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/core/graphql/fragments/taxi_payout.fragment.graphql.dart';
import 'package:admin_frontend/features/taxi/driver_payout_session/driver_payout_session_detail/data/graphql/driver_payout_session_detail.graphql.dart';
import 'package:admin_frontend/features/taxi/driver_payout_session/driver_payout_session_detail/data/repositories/driver_payout_session_detail_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@prod
@LazySingleton(as: DriverPayoutSessionDetailRepository)
class DriverPayoutSessionDetailRepositoryImpl
    implements DriverPayoutSessionDetailRepository {
  final GraphqlDatasource graphQLDatasource;

  DriverPayoutSessionDetailRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<Fragment$taxiPayoutSessionDetail>> getPayoutSessionDetail({
    required String id,
  }) async {
    final payoutSessionDetailOrError = await graphQLDatasource.query(
      Options$Query$taxiPayoutSession(
        variables: Variables$Query$taxiPayoutSession(id: id),
      ),
    );
    return payoutSessionDetailOrError.mapData((r) => r.taxiPayoutSession);
  }

  @override
  Future<ApiResponse<Fragment$taxiPayoutSessionDetail>>
  updatePayoutSessionStatus({
    required String id,
    required Enum$PayoutSessionStatus status,
  }) async {
    final updatedPayoutSessionOrError = await graphQLDatasource.mutate(
      Options$Mutation$updateTaxiPayoutSessionStatus(
        variables: Variables$Mutation$updateTaxiPayoutSessionStatus(
          id: id,
          status: status,
        ),
      ),
    );
    return updatedPayoutSessionOrError.mapData(
      (r) => r.updateOneTaxiPayoutSession,
    );
  }

  @override
  Future<ApiResponse<Query$payoutSessionPayoutMethodDriverTransactions>>
  getDriverTransactions({
    required String payoutSessionPayoutMethodId,
    required Input$OffsetPaging? paging,
  }) async {
    final driverTransactionsOrError = await graphQLDatasource.query(
      Options$Query$payoutSessionPayoutMethodDriverTransactions(
        variables: Variables$Query$payoutSessionPayoutMethodDriverTransactions(
          paging: paging,
          payoutSessionPayoutMethodId: payoutSessionPayoutMethodId,
        ),
      ),
    );
    return driverTransactionsOrError;
  }

  @override
  Future<ApiResponse<String>> exportPayoutToCSV({
    required String payoutSessionId,
    required String payoutMethodId,
  }) async {
    final exportPayoutToCSVOrError = await graphQLDatasource.mutate(
      Options$Mutation$taxiExportPayoutToCSV(
        variables: Variables$Mutation$taxiExportPayoutToCSV(
          payoutSessionId: payoutSessionId,
          payoutMethodId: payoutMethodId,
        ),
      ),
    );
    return exportPayoutToCSVOrError.mapData(
      (r) => r.exportTaxiPayoutSessionToCsv,
    );
  }

  @override
  Future<ApiResponse<void>> runAutoPayout({
    required String payoutSessionId,
    required String payoutMethodId,
  }) async {
    final runAutoPayoutOrError = await graphQLDatasource.mutate(
      Options$Mutation$taxiAutomaticPayout(
        variables: Variables$Mutation$taxiAutomaticPayout(
          payoutSessionId: payoutSessionId,
          payoutMethodId: payoutMethodId,
        ),
      ),
    );
    return runAutoPayoutOrError.mapData((r) => r.runTaxiAutoPayout);
  }
}
