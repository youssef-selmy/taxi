import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/graphql/fragments/driver.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/page_info.mock.dart';
import 'package:admin_frontend/features/taxi/driver_accounting/driver_accounting_list/data/graphql/driver_accounting_list.graphql.dart';
import 'package:admin_frontend/features/taxi/driver_accounting/driver_accounting_list/data/repositories/driver_accounting_list_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@dev
@LazySingleton(as: DriverAccountingListRepository)
class DriverAccountingListRepositoryMock
    implements DriverAccountingListRepository {
  @override
  Future<ApiResponse<Query$driverWallets>> getWalletList({
    required String? currency,
    required List<Input$DriverWalletSort> sorting,
    required Input$OffsetPaging? paging,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Query$driverWallets(
        driverWallets: Query$driverWallets$driverWallets(
          nodes: [
            Query$driverWallets$driverWallets$nodes(
              currency: currency ?? "USD",
              balance: 43,
              driver: mockDriverName1,
            ),
            Query$driverWallets$driverWallets$nodes(
              currency: currency ?? "USD",
              balance: 12,
              driver: mockDriverName2,
            ),
            Query$driverWallets$driverWallets$nodes(
              currency: currency ?? "USD",
              balance: 53,
              driver: mockDriverName3,
            ),
            Query$driverWallets$driverWallets$nodes(
              currency: currency ?? "USD",
              balance: 65,
              driver: mockDriverName4,
            ),
          ],
          pageInfo: mockPageInfo,
          totalCount: 4,
        ),
      ),
    );
  }

  @override
  Future<ApiResponse<Query$driverWalletsSummary>> getWalletsSummary({
    required String? currency,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Query$driverWalletsSummary(
        walletsCount: [
          Query$driverWalletsSummary$walletsCount(
            count: Query$driverWalletsSummary$walletsCount$count(id: 54),
          ),
        ],
        totalWalletBalance: [
          Query$driverWalletsSummary$totalWalletBalance(
            sum: Query$driverWalletsSummary$totalWalletBalance$sum(
              balance: 5123,
            ),
          ),
        ],
      ),
    );
  }
}
