import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/graphql/fragments/customer.fragment.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/page_info.mock.dart';
import 'package:admin_frontend/features/accounting/customer_accounting/customer_accounting_list/data/graphql/customer_accounting_list.graphql.dart';
import 'package:admin_frontend/features/accounting/customer_accounting/customer_accounting_list/data/repositories/customer_accounting_list_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@dev
@LazySingleton(as: CustomerAccountingListRepository)
class CustomerAccountingListRepositoryMock
    implements CustomerAccountingListRepository {
  @override
  Future<ApiResponse<Query$customerWallets>> getWalletList({
    required String currency,
    required List<Input$RiderWalletSort> sorting,
    required Input$OffsetPaging? paging,
  }) async {
    return ApiResponse.loaded(
      Query$customerWallets(
        riderWallets: Query$customerWallets$riderWallets(
          nodes: [
            Query$customerWallets$riderWallets$nodes(
              currency: currency,
              balance: 43,
              rider: mockCustomerCompact1,
            ),
            Query$customerWallets$riderWallets$nodes(
              currency: currency,
              balance: 12,
              rider: mockCustomerCompact2,
            ),
            Query$customerWallets$riderWallets$nodes(
              currency: currency,
              balance: 53,
              rider: mockCustomerCompact3,
            ),
            Query$customerWallets$riderWallets$nodes(
              currency: currency,
              balance: 65,
              rider: mockCustomerCompact4,
            ),
          ],
          pageInfo: mockPageInfo,
          totalCount: 4,
        ),
      ),
    );
  }

  @override
  Future<ApiResponse<Query$customerWalletsSummary>> getWalletsSummary({
    required String currency,
  }) async {
    return ApiResponse.loaded(
      Query$customerWalletsSummary(
        walletsCount: [
          Query$customerWalletsSummary$walletsCount(
            count: Query$customerWalletsSummary$walletsCount$count(id: 54),
          ),
        ],
        totalWalletBalance: [
          Query$customerWalletsSummary$totalWalletBalance(
            sum: Query$customerWalletsSummary$totalWalletBalance$sum(
              balance: 5123,
            ),
          ),
        ],
      ),
    );
  }
}
