import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/graphql/fragments/payout_method.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/payout_method.fragment.graphql.mock.dart';
import 'package:admin_frontend/features/payout/payout_method/payout_method_detail/data/repositories/payout_method_detail_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@dev
@LazySingleton(as: PayoutMethodDetailRepository)
class PayoutMethodDetailRepositoryMock implements PayoutMethodDetailRepository {
  @override
  Future<ApiResponse<Fragment$payoutMethodDetail>> createPayoutMethod({
    required Input$CreatePayoutMethodInput input,
  }) async {
    return ApiResponse.loaded(mockPayoutMethodDetail);
  }

  @override
  Future<ApiResponse<void>> deletePayoutMethod({required String id}) async {
    return const ApiResponse.loaded(null);
  }

  @override
  Future<ApiResponse<Fragment$payoutMethodDetail>> getPayoutMethod({
    required String id,
  }) async {
    return ApiResponse.loaded(mockPayoutMethodDetail);
  }

  @override
  Future<ApiResponse<Fragment$payoutMethodDetail>> updatePayoutMethod({
    required String id,
    required Input$CreatePayoutMethodInput update,
  }) async {
    return ApiResponse.loaded(mockPayoutMethodDetail);
  }
}
