import 'package:api_response/api_response.dart';

import 'package:admin_frontend/features/taxi/driver_payout_session/new_batch_payout_session_dialog/data/graphql/new_batch_payout_session_dialog.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

abstract class NewBatchPayoutSessionDialogRepository {
  Future<ApiResponse<Query$payoutMethods>> getPayoutMethods();
  Future<ApiResponse<void>> createBatchPayoutSession({
    required Input$CreatePayoutSessionInput input,
  });
}
