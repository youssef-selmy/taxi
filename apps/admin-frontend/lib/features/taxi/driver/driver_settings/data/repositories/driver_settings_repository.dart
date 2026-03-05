import 'package:api_response/api_response.dart';

import 'package:admin_frontend/features/taxi/driver/driver_settings/data/graphql/driver_settings.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

abstract class DriverSettingsRepository {
  Future<ApiResponse<Query$driverShiftRules>> getDriverShiftRules();

  Future<ApiResponse<Query$driverDocuments>> getDriverDocuments();

  Future<ApiResponse<Mutation$driverShiftRuleCreate>> createDriverShiftRule({
    required Input$CreateManyDriverShiftRulesInput createDriverShiftRuleInput,
  });

  Future<ApiResponse<Mutation$driverShiftRuleDelete>> deleteDriverShiftRule({
    required Input$DeleteManyDriverShiftRulesInput deleteDriverShiftRuleInput,
  });

  Future<ApiResponse<Mutation$driverShiftRuleUpdate>> updateDriverShiftRule({
    required Input$UpdateOneDriverShiftRuleInput updateDriverShiftRuleInput,
  });

  Future<ApiResponse<Mutation$driverDocumentCreate>> createDriverDocument({
    required Input$CreateManyDriverDocumentsInput createDriverDocumentInput,
  });

  Future<ApiResponse<Mutation$driverDocumentDelete>> deleteDriverDocument({
    required Input$DeleteManyDriverDocumentsInput deleteDriverDocumentInput,
  });

  Future<ApiResponse<Mutation$driverDocumentUpdate>> updateDriverDocument({
    required Input$UpdateOneDriverDocumentInput updateDriverDocumentInput,
  });

  Future<ApiResponse<Mutation$driverDocumentRetentionPolicyCreate>>
  createDriverDocumentRetentionPolicy({
    required Input$CreateManyDriverDocumentRetentionPoliciesInput
    createDriverDocumentRetentionPolicyInput,
  });

  Future<ApiResponse<Mutation$driverDocumentRetentionPolicyDelete>>
  deleteDriverDocumentRetentionPolicy({
    required Input$DeleteManyDriverDocumentRetentionPoliciesInput
    deleteDriverDocumentRetentionPolicyInput,
  });

  Future<ApiResponse<Mutation$driverDocumentRetentionPolicyUpdate>>
  updateDriverDocumentRetentionPolicy({
    required Input$UpdateOneDriverDocumentRetentionPolicyInput
    updateDriverDocumentRetentionPolicyInput,
  });
}
