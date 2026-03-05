import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/components/wallet_balance/wallet_balance_item.dart';
import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/core/graphql/fragments/fleet.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/fleet.graphql.extensions.dart';
import 'package:admin_frontend/features/taxi/fleet/data/graphql/fleet.graphql.dart';
import 'package:admin_frontend/features/taxi/fleet/data/repositories/fleet_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@prod
@LazySingleton(as: FleetRepository)
class FleetRepositoryImpl implements FleetRepository {
  final GraphqlDatasource graphQLDatasource;

  FleetRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<Query$fleetsList>> getFleets({
    required Input$OffsetPaging? paging,
    required Input$FleetFilter filter,
    required List<Input$FleetSort> sorting,
  }) async {
    final fleets = await graphQLDatasource.query(
      Options$Query$fleetsList(
        variables: Variables$Query$fleetsList(
          paging: paging,
          filter: filter,
          sorting: sorting,
        ),
      ),
    );
    return fleets;
  }

  @override
  Future<ApiResponse<Fragment$fleetDetails>> create({
    required Input$CreateFleetInput input,
  }) async {
    final fleet = await graphQLDatasource.mutate(
      Options$Mutation$createOneFleet(
        variables: Variables$Mutation$createOneFleet(input: input),
      ),
    );
    return fleet.mapData((f) => f.createOneFleet);
  }

  @override
  Future<ApiResponse<Query$fleetDetails>> getFleetDetails({
    required String id,
  }) async {
    final fleet = await graphQLDatasource.query(
      Options$Query$fleetDetails(
        variables: Variables$Query$fleetDetails(id: id),
      ),
    );
    return fleet;
  }

  @override
  Future<ApiResponse<Fragment$fleetDetails>> update({
    required String id,
    required Input$UpdateFleetInput input,
  }) async {
    final fleet = await graphQLDatasource.mutate(
      Options$Mutation$updateOneFleet(
        variables: Variables$Mutation$updateOneFleet(id: id, input: input),
      ),
    );
    return fleet.mapData((f) => f.updateOneFleet);
  }

  @override
  Future<ApiResponse<Query$fleetTransactions>> getFleetTransactions({
    required Input$OffsetPaging? paging,
    required List<Input$FleetTransactionSort> sorting,
    required Input$FleetTransactionFilter filter,
  }) async {
    final transactions = await graphQLDatasource.query(
      Options$Query$fleetTransactions(
        variables: Variables$Query$fleetTransactions(
          paging: paging,
          sorting: sorting,
          filter: filter,
        ),
      ),
    );
    return transactions;
  }

  @override
  Future<ApiResponse<List<WalletBalanceItem>>> getFleetWallet() async {
    final wallet = await graphQLDatasource.query(Options$Query$fleetWallet());
    return wallet.mapData(
      (wallet) => wallet.fleetWallets.nodes.toWalletBalanceItems(),
    );
  }

  @override
  Future<ApiResponse<void>> deleteFleet({required String id}) {
    final fleet = graphQLDatasource.mutate(
      Options$Mutation$deleteFleet(
        variables: Variables$Mutation$deleteFleet(id: id),
      ),
    );
    return fleet;
  }

  @override
  Future<ApiResponse<String>> exportFleetTransactions({
    required Input$FleetTransactionFilter filter,
    required List<Input$FleetTransactionSort> sorting,
    required Enum$ExportFormat format,
  }) async {
    final exportTransactions = await graphQLDatasource.query(
      Options$Query$exportFleetTransactions(
        variables: Variables$Query$exportFleetTransactions(
          filter: filter,
          sorting: sorting,
          format: format,
        ),
      ),
    );
    return exportTransactions.mapData((data) => data.exportFleetTransactions);
  }
}
