import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/components/wallet_balance/wallet_balance_item.dart';
import 'package:admin_frontend/core/graphql/fragments/page_info.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/parking_transaction.fragment.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/wallet.graphql.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/wallet.graphql.mock.dart';
import 'package:admin_frontend/features/parking/park_spot/park_spot_detail/data/graphql/park_spot_detail_credit_records.graphql.dart';
import 'package:admin_frontend/features/parking/park_spot/park_spot_detail/data/repositories/park_spot_detail_credit_records_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@dev
@LazySingleton(as: ParkSpotDetailCreditRecordsRepository)
class ParkSpotDetailCreditRecordsRepositoryMock
    implements ParkSpotDetailCreditRecordsRepository {
  @override
  Future<ApiResponse<Query$parkSpotCreditRecords>> getCreditRecords({
    required Input$OffsetPaging? paging,
    required Input$ParkingTransactionFilter filter,
    required List<Input$ParkingTransactionSort> sorting,
  }) async {
    return ApiResponse.loaded(
      Query$parkSpotCreditRecords(
        parkingTransactions: Query$parkSpotCreditRecords$parkingTransactions(
          nodes: mockParkingTransactions,
          pageInfo: mockPageInfo,
          totalCount: mockParkingTransactions.length,
        ),
      ),
    );
  }

  @override
  Future<ApiResponse<List<WalletBalanceItem>>> getWalletBalance({
    required String ownerId,
  }) async {
    return ApiResponse.loaded(
      mockParkingWallets.map((r) => r.toWalletBalanceItem()).toList(),
    );
  }

  @override
  Future<ApiResponse<String>> exportCreditRecords({
    required List<Input$ParkingTransactionSort> sort,
    required Input$ParkingTransactionFilter filter,
    required Enum$ExportFormat format,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      "https://example.com/exported_credit_records.${format.name.toLowerCase()}",
    );
  }
}
