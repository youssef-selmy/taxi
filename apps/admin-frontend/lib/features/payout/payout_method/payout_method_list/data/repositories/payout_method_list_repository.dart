import 'package:api_response/api_response.dart';

import 'package:admin_frontend/features/payout/payout_method/payout_method_list/data/graphql/payout_method_list.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

abstract class PayoutMethodListRepository {
  Future<ApiResponse<Query$payoutMethods$payoutMethods>> getPayoutMethods({
    required Input$OffsetPaging? paging,
    required Input$PayoutMethodFilter filter,
    required List<Input$PayoutMethodSort> sorting,
  });
}
