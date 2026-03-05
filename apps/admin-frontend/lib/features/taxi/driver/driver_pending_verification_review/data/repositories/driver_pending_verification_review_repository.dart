import 'package:api_response/api_response.dart';

import 'package:admin_frontend/features/taxi/driver/driver_pending_verification_review/data/graphql/driver_pending_verification_review.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

abstract class DriverPendingVerificationReviewRepository {
  Future<ApiResponse<Query$driverReview>> getDriverReview({
    required String driverId,
  });

  Future<ApiResponse<Query$driverDocuments>> getDriverDocuments({
    required String driverId,
  });

  Future<ApiResponse<Query$services>> getServices();

  Future<ApiResponse<Mutation$driverRejection>> driverRejection({
    required Input$UpdateOneDriverInput inputUpdate,
    required Input$CreateOneDriverNoteInput inputCreate,
  });
  Future<ApiResponse<Mutation$driverApprove>> driverApprove({
    required Input$UpdateOneDriverInput input,
  });

  Future<ApiResponse<Mutation$updateDriverDocument>> updateDriverDocument({
    required Input$UpdateOneDriverToDriverDocumentInput input,
  });

  Future<ApiResponse<Mutation$setEnabledServices>> setEnabledServices({
    required Input$SetActiveServicesOnDriverInput input,
  });
}
