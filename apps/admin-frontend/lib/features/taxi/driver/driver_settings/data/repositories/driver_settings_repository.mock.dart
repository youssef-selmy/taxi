import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/graphql/fragments/driver_document.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/driver_shift_rule.fragment.graphql.mock.dart';
import 'package:admin_frontend/features/taxi/driver/driver_settings/data/graphql/driver_settings.graphql.dart';
import 'package:admin_frontend/features/taxi/driver/driver_settings/data/repositories/driver_settings_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@dev
@LazySingleton(as: DriverSettingsRepository)
class DriverSettingsRepositoryMock implements DriverSettingsRepository {
  @override
  Future<ApiResponse<Query$driverShiftRules>> getDriverShiftRules() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Query$driverShiftRules(driverShiftRules: mockDriverShiftRuleList),
    );
  }

  @override
  Future<ApiResponse<Query$driverDocuments>> getDriverDocuments() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Query$driverDocuments(driverDocuments: mockDriverDocumentList),
    );
  }

  @override
  Future<ApiResponse<Mutation$driverShiftRuleCreate>> createDriverShiftRule({
    required Input$CreateManyDriverShiftRulesInput createDriverShiftRuleInput,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Mutation$driverShiftRuleCreate(
        createManyDriverShiftRules: mockDriverShiftRuleList,
      ),
    );
  }

  @override
  Future<ApiResponse<Mutation$driverShiftRuleDelete>> deleteDriverShiftRule({
    required Input$DeleteManyDriverShiftRulesInput deleteDriverShiftRuleInput,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Mutation$driverShiftRuleDelete(
        deleteManyDriverShiftRules:
            Mutation$driverShiftRuleDelete$deleteManyDriverShiftRules(
              deletedCount: 2,
            ),
      ),
    );
  }

  @override
  Future<ApiResponse<Mutation$driverShiftRuleUpdate>> updateDriverShiftRule({
    required Input$UpdateOneDriverShiftRuleInput updateDriverShiftRuleInput,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Mutation$driverShiftRuleUpdate(
        updateOneDriverShiftRule: mockDriverShiftRule1,
      ),
    );
  }

  @override
  Future<ApiResponse<Mutation$driverDocumentCreate>> createDriverDocument({
    required Input$CreateManyDriverDocumentsInput createDriverDocumentInput,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Mutation$driverDocumentCreate(
        createManyDriverDocuments: mockDriverDocumentList,
      ),
    );
  }

  @override
  Future<ApiResponse<Mutation$driverDocumentDelete>> deleteDriverDocument({
    required Input$DeleteManyDriverDocumentsInput deleteDriverDocumentInput,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Mutation$driverDocumentDelete(
        deleteManyDriverDocuments:
            Mutation$driverDocumentDelete$deleteManyDriverDocuments(
              deletedCount: 3,
            ),
      ),
    );
  }

  @override
  Future<ApiResponse<Mutation$driverDocumentUpdate>> updateDriverDocument({
    required Input$UpdateOneDriverDocumentInput updateDriverDocumentInput,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Mutation$driverDocumentUpdate(
        updateOneDriverDocument: mockDriverDocument1,
      ),
    );
  }

  @override
  Future<ApiResponse<Mutation$driverDocumentRetentionPolicyCreate>>
  createDriverDocumentRetentionPolicy({
    required Input$CreateManyDriverDocumentRetentionPoliciesInput
    createDriverDocumentRetentionPolicyInput,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Mutation$driverDocumentRetentionPolicyCreate(
        createManyDriverDocumentRetentionPolicies: mockRetentionPolicies,
      ),
    );
  }

  @override
  Future<ApiResponse<Mutation$driverDocumentRetentionPolicyDelete>>
  deleteDriverDocumentRetentionPolicy({
    required Input$DeleteManyDriverDocumentRetentionPoliciesInput
    deleteDriverDocumentRetentionPolicyInput,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Mutation$driverDocumentRetentionPolicyDelete(
        deleteManyDriverDocumentRetentionPolicies:
            Mutation$driverDocumentRetentionPolicyDelete$deleteManyDriverDocumentRetentionPolicies(
              deletedCount: 3,
            ),
      ),
    );
  }

  @override
  Future<ApiResponse<Mutation$driverDocumentRetentionPolicyUpdate>>
  updateDriverDocumentRetentionPolicy({
    required Input$UpdateOneDriverDocumentRetentionPolicyInput
    updateDriverDocumentRetentionPolicyInput,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Mutation$driverDocumentRetentionPolicyUpdate(
        updateOneDriverDocumentRetentionPolicy: mockRetentionPolicies1,
      ),
    );
  }
}
