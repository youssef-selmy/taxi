import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/graphql/fragments/page_info.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/payout_method.fragment.graphql.mock.dart';
import 'package:admin_frontend/features/payout/payout_method/payout_method_list/data/graphql/payout_method_list.graphql.dart';
import 'package:admin_frontend/features/payout/payout_method/payout_method_list/data/repositories/payout_method_list_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@dev
@LazySingleton(as: PayoutMethodListRepository)
class PayoutMethodListRepositoryMock implements PayoutMethodListRepository {
  @override
  Future<ApiResponse<Query$payoutMethods$payoutMethods>> getPayoutMethods({
    required Input$OffsetPaging? paging,
    required Input$PayoutMethodFilter filter,
    required List<Input$PayoutMethodSort> sorting,
  }) async {
    return ApiResponse.loaded(
      Query$payoutMethods$payoutMethods(
        nodes: mockPayoutMethodListItems,
        pageInfo: mockPageInfo,
        totalCount: mockPayoutMethodListItems.length,
      ),
    );
  }
}
