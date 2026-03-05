import 'package:api_response/api_response.dart';
import 'package:image_faker/image_faker.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/graphql/fragments/driver_transaction.fragment.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/media.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/mobile_number.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/page_info.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/shop_transaction.fragment.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/wallet.graphql.mock.dart';
import 'package:admin_frontend/features/shop/shop_accounting/shop_accounting_detail/data/graphql/shop_accounting_detail.graphql.dart';
import 'package:admin_frontend/features/shop/shop_accounting/shop_accounting_detail/data/repositories/shop_accounting_detail_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@dev
@LazySingleton(as: ShopAccountingDetailRepository)
class DriverAccountingDetailRepositoryMock
    implements ShopAccountingDetailRepository {
  @override
  Future<ApiResponse<Query$shopTransactions>> getShopTransactions({
    required String currency,
    required List<Enum$TransactionType> typeFilter,
    required List<Enum$TransactionStatus> statusFilter,
    required String shopId,
    required List<Input$ShopTransactionSort> sorting,
    required Input$OffsetPaging? paging,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Query$shopTransactions(
        shopTransactions: Query$shopTransactions$shopTransactions(
          nodes: mockShopTransactions,
          pageInfo: mockPageInfo,
          totalCount: mockDriverTransactionList.length,
        ),
      ),
    );
  }

  @override
  Future<ApiResponse<Query$shopWalletDetailSummary>> getWalletDetailSummary({
    required String shopId,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Query$shopWalletDetailSummary(
        shop: Query$shopWalletDetailSummary$shop(
          id: "1",
          name: "Olive Garden",
          mobileNumber: mockMobileNumber,
          image: ImageFaker().shop.logo.masterChef.toMedia,
          wallet: mockShopWallets,
        ),
      ),
    );
  }
}
