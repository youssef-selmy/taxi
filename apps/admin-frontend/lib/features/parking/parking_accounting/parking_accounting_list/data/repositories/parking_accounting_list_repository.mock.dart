import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/graphql/fragments/customer.fragment.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/page_info.mock.dart';
import 'package:admin_frontend/features/parking/parking_accounting/parking_accounting_list/data/graphql/parking_accounting_list.graphql.dart';
import 'package:admin_frontend/features/parking/parking_accounting/parking_accounting_list/data/repositories/parking_accounting_list_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@dev
@LazySingleton(as: ParkingAccountingListRepository)
class ParkingAccountingListRepositoryMock
    implements ParkingAccountingListRepository {
  @override
  Future<ApiResponse<Query$parkingWallets>> getWalletList({
    required String? currency,
    required List<Input$ParkingWalletSort> sorting,
    required Input$OffsetPaging? paging,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Query$parkingWallets(
        parkingWallets: Query$parkingWallets$parkingWallets(
          nodes: [
            Query$parkingWallets$parkingWallets$nodes(
              currency: currency ?? "USD",
              balance: 43,
              customer: mockCustomerCompact1,
            ),
            Query$parkingWallets$parkingWallets$nodes(
              currency: currency ?? "USD",
              balance: 12,
              customer: mockCustomerCompact1,
            ),
            Query$parkingWallets$parkingWallets$nodes(
              currency: currency ?? "USD",
              balance: 53,
              customer: mockCustomerCompact1,
            ),
            Query$parkingWallets$parkingWallets$nodes(
              currency: currency ?? "USD",
              balance: 65,
              customer: mockCustomerCompact1,
            ),
          ],
          pageInfo: mockPageInfo,
          totalCount: 4,
        ),
      ),
    );
  }

  @override
  Future<ApiResponse<Query$parkingWalletsSummary>> getWalletsSummary({
    required String? currency,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Query$parkingWalletsSummary(
        walletsCount: [
          Query$parkingWalletsSummary$walletsCount(
            count: Query$parkingWalletsSummary$walletsCount$count(id: 54),
          ),
        ],
        totalWalletBalance: [
          Query$parkingWalletsSummary$totalWalletBalance(
            sum: Query$parkingWalletsSummary$totalWalletBalance$sum(
              balance: 5123,
            ),
          ),
        ],
      ),
    );
  }
}
