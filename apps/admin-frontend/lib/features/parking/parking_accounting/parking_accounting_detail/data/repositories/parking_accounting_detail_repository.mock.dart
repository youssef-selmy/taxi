import 'package:api_response/api_response.dart';
import 'package:image_faker/image_faker.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/graphql/fragments/driver_transaction.fragment.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/media.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/page_info.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/parking_transaction.fragment.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/wallet.graphql.mock.dart';
import 'package:admin_frontend/features/parking/parking_accounting/parking_accounting_detail/data/graphql/parking_accounting_detail.graphql.dart';
import 'package:admin_frontend/features/parking/parking_accounting/parking_accounting_detail/data/repositories/parking_accounting_detail_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@dev
@LazySingleton(as: ParkingAccountingDetailRepository)
class DriverAccountingDetailRepositoryMock
    implements ParkingAccountingDetailRepository {
  @override
  Future<ApiResponse<Query$parkingTransactions>> getParkingTransactions({
    required String currency,
    required List<Enum$TransactionType> typeFilter,
    required List<Enum$TransactionStatus> statusFilter,
    required String parkingId,
    required List<Input$ParkingTransactionSort> sorting,
    required Input$OffsetPaging? paging,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Query$parkingTransactions(
        parkingTransactions: Query$parkingTransactions$parkingTransactions(
          nodes: mockParkingTransactions,
          pageInfo: mockPageInfo,
          totalCount: mockDriverTransactionList.length,
        ),
      ),
    );
  }

  @override
  Future<ApiResponse<Query$parkingWalletDetailSummary>> getWalletDetailSummary({
    required String parkingId,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Query$parkingWalletDetailSummary(
        rider: Query$parkingWalletDetailSummary$rider(
          id: "1",
          firstName: "John Doe",
          media: ImageFaker().person.random().toMedia,
          mobileNumber: "+1234567890",
          parkingWallets: mockParkingWallets,
        ),
      ),
    );
  }
}
