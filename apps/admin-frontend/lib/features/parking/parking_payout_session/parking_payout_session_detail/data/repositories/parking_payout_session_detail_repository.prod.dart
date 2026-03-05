import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/core/graphql/fragments/parking_payout.fragment.graphql.dart';
import 'package:admin_frontend/features/parking/parking_payout_session/parking_payout_session_detail/data/graphql/parking_payout_session_detail.graphql.dart';
import 'package:admin_frontend/features/parking/parking_payout_session/parking_payout_session_detail/data/repositories/parking_payout_session_detail_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@prod
@LazySingleton(as: ParkingPayoutSessionDetailRepository)
class ParkingPayoutSessionDetailRepositoryImpl
    implements ParkingPayoutSessionDetailRepository {
  final GraphqlDatasource graphQLDatasource;

  ParkingPayoutSessionDetailRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<Fragment$parkingPayoutSessionDetail>>
  getPayoutSessionDetail({required String id}) async {
    final payoutSessionDetailOrError = await graphQLDatasource.query(
      Options$Query$parkingPayoutSession(
        variables: Variables$Query$parkingPayoutSession(id: id),
      ),
    );
    return payoutSessionDetailOrError.mapData((r) => r.parkingPayoutSession);
  }

  @override
  Future<ApiResponse<Fragment$parkingPayoutSessionDetail>>
  updatePayoutSessionStatus({
    required String id,
    required Enum$PayoutSessionStatus status,
  }) async {
    final updatedPayoutSessionOrError = await graphQLDatasource.mutate(
      Options$Mutation$updateParkingPayoutSessionStatus(
        variables: Variables$Mutation$updateParkingPayoutSessionStatus(
          id: id,
          status: status,
        ),
      ),
    );
    return updatedPayoutSessionOrError.mapData(
      (r) => r.updateOneParkingPayoutSession,
    );
  }

  @override
  Future<ApiResponse<Query$parkingPayoutSessionPayoutMethodParkingTransactions>>
  getParkingTransactions({
    required String payoutSessionPayoutMethodId,
    required Input$OffsetPaging? paging,
  }) async {
    final parkingTransactionsOrError = await graphQLDatasource.query(
      Options$Query$parkingPayoutSessionPayoutMethodParkingTransactions(
        variables:
            Variables$Query$parkingPayoutSessionPayoutMethodParkingTransactions(
              paging: paging,
              payoutSessionPayoutMethodId: payoutSessionPayoutMethodId,
            ),
      ),
    );
    return parkingTransactionsOrError;
  }

  @override
  Future<ApiResponse<String>> exportPayoutToCSV({
    required String payoutSessionId,
    required String payoutMethodId,
  }) async {
    final exportPayoutToCSVOrError = await graphQLDatasource.mutate(
      Options$Mutation$parkingExportPayoutToCSV(
        variables: Variables$Mutation$parkingExportPayoutToCSV(
          payoutSessionId: payoutSessionId,
          payoutMethodId: payoutMethodId,
        ),
      ),
    );
    return exportPayoutToCSVOrError.mapData(
      (r) => r.exportParkingPayoutSessionToCsv,
    );
  }

  @override
  Future<ApiResponse<void>> runAutoPayout({
    required String payoutSessionId,
    required String payoutMethodId,
  }) async {
    final runAutoPayoutOrError = await graphQLDatasource.mutate(
      Options$Mutation$parkingAutomaticPayout(
        variables: Variables$Mutation$parkingAutomaticPayout(
          payoutSessionId: payoutSessionId,
          payoutMethodId: payoutMethodId,
        ),
      ),
    );
    return runAutoPayoutOrError.mapData((r) => r.runParkingAutoPayout);
  }
}
