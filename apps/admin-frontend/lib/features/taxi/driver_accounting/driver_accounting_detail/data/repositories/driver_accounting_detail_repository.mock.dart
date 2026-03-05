import 'package:api_response/api_response.dart';
import 'package:image_faker/image_faker.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/graphql/fragments/driver_transaction.fragment.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/media.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/page_info.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/wallet.graphql.mock.dart';
import 'package:admin_frontend/features/taxi/driver_accounting/driver_accounting_detail/data/graphql/driver_accounting_detail.graphql.dart';
import 'package:admin_frontend/features/taxi/driver_accounting/driver_accounting_detail/data/repositories/driver_accounting_detail_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@dev
@LazySingleton(as: DriverAccountingDetailRepository)
class DriverAccountingDetailRepositoryMock
    implements DriverAccountingDetailRepository {
  @override
  Future<ApiResponse<Query$driverTransactions>> getDriverTransactions({
    required String currency,
    required List<Enum$TransactionAction> actionFilter,
    required List<Enum$TransactionStatus> statusFilter,
    required String driverId,
    required List<Input$DriverTransactionSort> sorting,
    required Input$OffsetPaging? paging,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Query$driverTransactions(
        driverTransactions: Query$driverTransactions$driverTransactions(
          nodes: mockDriverTransactionList,
          pageInfo: mockPageInfo,
          totalCount: mockDriverTransactionList.length,
        ),
      ),
    );
  }

  @override
  Future<ApiResponse<Query$driverWalletDetailSummary>> getWalletDetailSummary({
    required String driverId,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Query$driverWalletDetailSummary(
        driver: Query$driverWalletDetailSummary$driver(
          id: "1",
          firstName: "John",
          lastName: "Doe",
          mobileNumber: "16505551234",
          media: ImageFaker().person.random().toMedia,
          status: Enum$DriverStatus.Online,
          wallet: mockDriverWallets,
          registrationTimestamp: DateTime.now(),
        ),
      ),
    );
  }
}
