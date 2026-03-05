import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/components/wallet_balance/wallet_balance_item.dart';
import 'package:admin_frontend/core/graphql/fragments/fleet.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/fleet.graphql.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/fleet.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/page_info.mock.dart';
import 'package:admin_frontend/features/taxi/fleet/data/graphql/fleet.graphql.dart';
import 'package:admin_frontend/features/taxi/fleet/data/repositories/fleet_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@dev
@LazySingleton(as: FleetRepository)
class FleetRepositoryMock implements FleetRepository {
  @override
  Future<ApiResponse<Query$fleetsList>> getFleets({
    required Input$OffsetPaging? paging,
    required Input$FleetFilter filter,
    required List<Input$FleetSort> sorting,
  }) async {
    Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Query$fleetsList(
        fleets: Query$fleetsList$fleets(
          nodes: mockFleetList,
          pageInfo: mockPageInfo,
          totalCount: mockFleetList.length,
        ),
      ),
    );
  }

  @override
  Future<ApiResponse<Fragment$fleetDetails>> create({
    required Input$CreateFleetInput input,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(mockFleetDetails);
  }

  @override
  Future<ApiResponse<Query$fleetDetails>> getFleetDetails({
    required String id,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(Query$fleetDetails(fleet: mockFleetDetails));
  }

  @override
  Future<ApiResponse<Fragment$fleetDetails>> update({
    required String id,
    required Input$UpdateFleetInput input,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(mockFleetDetails);
  }

  @override
  Future<ApiResponse<Query$fleetTransactions>> getFleetTransactions({
    required Input$OffsetPaging? paging,
    required List<Input$FleetTransactionSort> sorting,
    required Input$FleetTransactionFilter filter,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Query$fleetTransactions(
        fleetTransactions: Query$fleetTransactions$fleetTransactions(
          nodes: mockFleetTransactionList,
          pageInfo: mockPageInfo,
          totalCount: mockFleetTransactionList.length,
        ),
      ),
    );
  }

  @override
  Future<ApiResponse<List<WalletBalanceItem>>> getFleetWallet() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(mockFleetWalletList.toWalletBalanceItems());
  }

  @override
  Future<ApiResponse<void>> deleteFleet({required String id}) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(null);
  }

  @override
  Future<ApiResponse<String>> exportFleetTransactions({
    required Input$FleetTransactionFilter filter,
    required List<Input$FleetTransactionSort> sorting,
    required Enum$ExportFormat format,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded("mock_export_url");
  }
}
