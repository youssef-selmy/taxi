import 'package:api_response/api_response.dart';

import 'package:admin_frontend/core/components/wallet_balance/wallet_balance_item.dart';
import 'package:admin_frontend/core/graphql/fragments/fleet.graphql.dart';
import 'package:admin_frontend/features/taxi/fleet/data/graphql/fleet.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

abstract class FleetRepository {
  Future<ApiResponse<Query$fleetsList>> getFleets({
    required Input$OffsetPaging? paging,
    required Input$FleetFilter filter,
    required List<Input$FleetSort> sorting,
  });

  Future<ApiResponse<Query$fleetDetails>> getFleetDetails({required String id});

  Future<ApiResponse<Fragment$fleetDetails>> create({
    required Input$CreateFleetInput input,
  });

  Future<ApiResponse<Fragment$fleetDetails>> update({
    required String id,
    required Input$UpdateFleetInput input,
  });

  Future<ApiResponse<Query$fleetTransactions>> getFleetTransactions({
    required Input$OffsetPaging? paging,
    required List<Input$FleetTransactionSort> sorting,
    required Input$FleetTransactionFilter filter,
  });

  Future<ApiResponse<List<WalletBalanceItem>>> getFleetWallet();

  Future<ApiResponse<void>> deleteFleet({required String id});

  Future<ApiResponse<String>> exportFleetTransactions({
    required Input$FleetTransactionFilter filter,
    required List<Input$FleetTransactionSort> sorting,
    required Enum$ExportFormat format,
  });
}
