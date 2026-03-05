import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/graphql/fragments/payout_method.fragment.graphql.mock.dart';
import 'package:admin_frontend/features/parking/parking_payout_session/new_batch_payout_session_dialog/data/graphql/new_batch_payout_session_dialog.graphql.dart';
import 'package:admin_frontend/features/parking/parking_payout_session/new_batch_payout_session_dialog/data/repositories/new_batch_payout_session_dialog_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@dev
@LazySingleton(as: NewBatchPayoutSessionDialogRepository)
class NewBatchPayoutSessionDialogRepositoryMock
    implements NewBatchPayoutSessionDialogRepository {
  @override
  Future<ApiResponse<Query$payoutMethods>> getPayoutMethods() async {
    return ApiResponse.loaded(
      Query$payoutMethods(
        payoutMethods: Query$payoutMethods$payoutMethods(
          nodes: mockPayoutMethods,
        ),
      ),
    );
  }

  @override
  Future<ApiResponse<void>> createBatchPayoutSession({
    required Input$CreatePayoutSessionInput input,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return const ApiResponse.loaded(null);
  }
}
