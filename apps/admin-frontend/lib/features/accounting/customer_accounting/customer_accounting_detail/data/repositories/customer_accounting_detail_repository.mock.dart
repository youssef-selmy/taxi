import 'package:api_response/api_response.dart';
import 'package:image_faker/image_faker.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/graphql/fragments/customer_transaction.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/media.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/page_info.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/wallet.graphql.mock.dart';
import 'package:admin_frontend/features/accounting/customer_accounting/customer_accounting_detail/data/graphql/customer_accounting_detail.graphql.dart';
import 'package:admin_frontend/features/accounting/customer_accounting/customer_accounting_detail/data/repositories/customer_accounting_detail_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@dev
@LazySingleton(as: CustomerAccountingDetailRepository)
class CustomerAccountingDetailRepositoryMock
    implements CustomerAccountingDetailRepository {
  @override
  Future<ApiResponse<Query$customerTransactions>> getCustomerTransactions({
    required String currency,
    required List<Enum$TransactionAction> actionFilter,
    required List<Enum$TransactionStatus> statusFilter,
    required String riderId,
    required List<Input$RiderTransactionSort> sorting,
    required Input$OffsetPaging? paging,
  }) async {
    await Future.delayed(const Duration(milliseconds: 1000));
    return ApiResponse.loaded(
      Query$customerTransactions(
        riderTransactions: Query$customerTransactions$riderTransactions(
          nodes: mockCustomerTransactions,
          pageInfo: mockPageInfo,
          totalCount: mockCustomerTransactions.length,
        ),
      ),
    );
  }

  @override
  Future<ApiResponse<Query$customerWalletDetailSummary>>
  getWalletDetailSummary({required String riderId}) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Query$customerWalletDetailSummary(
        rider: Query$customerWalletDetailSummary$rider(
          id: "1",
          firstName: "John",
          lastName: "Doe",
          mobileNumber: "16505551234",
          media: ImageFaker().person.random().toMedia,
          wallet: mockCustomerWallets,
        ),
      ),
    );
  }
}
