import 'package:api_response/api_response.dart';

import 'package:admin_frontend/core/graphql/fragments/payout_method.fragment.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

abstract class PayoutMethodDetailRepository {
  Future<ApiResponse<Fragment$payoutMethodDetail>> getPayoutMethod({
    required String id,
  });

  Future<ApiResponse<Fragment$payoutMethodDetail>> createPayoutMethod({
    required Input$CreatePayoutMethodInput input,
  });

  Future<ApiResponse<Fragment$payoutMethodDetail>> updatePayoutMethod({
    required String id,
    required Input$CreatePayoutMethodInput update,
  });

  Future<ApiResponse<void>> deletePayoutMethod({required String id});
}
