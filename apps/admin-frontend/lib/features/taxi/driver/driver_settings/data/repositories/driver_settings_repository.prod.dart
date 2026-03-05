import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/features/taxi/driver/driver_settings/data/graphql/driver_settings.graphql.dart';
import 'package:admin_frontend/features/taxi/driver/driver_settings/data/repositories/driver_settings_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@prod
@LazySingleton(as: DriverSettingsRepository)
class DriverSettingsRepositoryImpl implements DriverSettingsRepository {
  final GraphqlDatasource graphQLDatasource;

  DriverSettingsRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<Query$driverShiftRules>> getDriverShiftRules() async {
    final driverShiftRulesOrError = await graphQLDatasource.query(
      Options$Query$driverShiftRules(),
    );
    return driverShiftRulesOrError;
  }

  @override
  Future<ApiResponse<Query$driverDocuments>> getDriverDocuments() async {
    final driverDocumentsOrError = await graphQLDatasource.query(
      Options$Query$driverDocuments(),
    );
    return driverDocumentsOrError;
  }

  @override
  Future<ApiResponse<Mutation$driverShiftRuleCreate>> createDriverShiftRule({
    required Input$CreateManyDriverShiftRulesInput createDriverShiftRuleInput,
  }) async {
    final createDriverShiftRuleOrError = await graphQLDatasource.mutate(
      Options$Mutation$driverShiftRuleCreate(
        variables: Variables$Mutation$driverShiftRuleCreate(
          input: createDriverShiftRuleInput,
        ),
      ),
    );
    return createDriverShiftRuleOrError;
  }

  @override
  Future<ApiResponse<Mutation$driverShiftRuleDelete>> deleteDriverShiftRule({
    required Input$DeleteManyDriverShiftRulesInput deleteDriverShiftRuleInput,
  }) async {
    final deleteDriverShiftRuleOrError = await graphQLDatasource.mutate(
      Options$Mutation$driverShiftRuleDelete(
        variables: Variables$Mutation$driverShiftRuleDelete(
          input: deleteDriverShiftRuleInput,
        ),
      ),
    );
    return deleteDriverShiftRuleOrError;
  }

  @override
  Future<ApiResponse<Mutation$driverShiftRuleUpdate>> updateDriverShiftRule({
    required Input$UpdateOneDriverShiftRuleInput updateDriverShiftRuleInput,
  }) async {
    final updateDriverShiftRuleOrError = await graphQLDatasource.mutate(
      Options$Mutation$driverShiftRuleUpdate(
        variables: Variables$Mutation$driverShiftRuleUpdate(
          input: updateDriverShiftRuleInput,
        ),
      ),
    );
    return updateDriverShiftRuleOrError;
  }

  @override
  Future<ApiResponse<Mutation$driverDocumentCreate>> createDriverDocument({
    required Input$CreateManyDriverDocumentsInput createDriverDocumentInput,
  }) async {
    final createDriverDocumentOrError = await graphQLDatasource.mutate(
      Options$Mutation$driverDocumentCreate(
        variables: Variables$Mutation$driverDocumentCreate(
          input: createDriverDocumentInput,
        ),
      ),
    );
    return createDriverDocumentOrError;
  }

  @override
  Future<ApiResponse<Mutation$driverDocumentDelete>> deleteDriverDocument({
    required Input$DeleteManyDriverDocumentsInput deleteDriverDocumentInput,
  }) async {
    final deleteDriverDocumentOrError = await graphQLDatasource.mutate(
      Options$Mutation$driverDocumentDelete(
        variables: Variables$Mutation$driverDocumentDelete(
          input: deleteDriverDocumentInput,
        ),
      ),
    );
    return deleteDriverDocumentOrError;
  }

  @override
  Future<ApiResponse<Mutation$driverDocumentUpdate>> updateDriverDocument({
    required Input$UpdateOneDriverDocumentInput updateDriverDocumentInput,
  }) async {
    final updateDriverDocumentOrError = await graphQLDatasource.mutate(
      Options$Mutation$driverDocumentUpdate(
        variables: Variables$Mutation$driverDocumentUpdate(
          input: updateDriverDocumentInput,
        ),
      ),
    );
    return updateDriverDocumentOrError;
  }

  @override
  Future<ApiResponse<Mutation$driverDocumentRetentionPolicyCreate>>
  createDriverDocumentRetentionPolicy({
    required Input$CreateManyDriverDocumentRetentionPoliciesInput
    createDriverDocumentRetentionPolicyInput,
  }) async {
    final createDriverDocumentRetentionPolicyOrError = await graphQLDatasource
        .mutate(
          Options$Mutation$driverDocumentRetentionPolicyCreate(
            variables: Variables$Mutation$driverDocumentRetentionPolicyCreate(
              input: createDriverDocumentRetentionPolicyInput,
            ),
          ),
        );
    return createDriverDocumentRetentionPolicyOrError;
  }

  @override
  Future<ApiResponse<Mutation$driverDocumentRetentionPolicyDelete>>
  deleteDriverDocumentRetentionPolicy({
    required Input$DeleteManyDriverDocumentRetentionPoliciesInput
    deleteDriverDocumentRetentionPolicyInput,
  }) async {
    final deleteDriverDocumentRetentionPolicyOrError = await graphQLDatasource
        .mutate(
          Options$Mutation$driverDocumentRetentionPolicyDelete(
            variables: Variables$Mutation$driverDocumentRetentionPolicyDelete(
              input: deleteDriverDocumentRetentionPolicyInput,
            ),
          ),
        );
    return deleteDriverDocumentRetentionPolicyOrError;
  }

  @override
  Future<ApiResponse<Mutation$driverDocumentRetentionPolicyUpdate>>
  updateDriverDocumentRetentionPolicy({
    required Input$UpdateOneDriverDocumentRetentionPolicyInput
    updateDriverDocumentRetentionPolicyInput,
  }) async {
    final updateDriverDocumentRetentionPolicyOrError = await graphQLDatasource
        .mutate(
          Options$Mutation$driverDocumentRetentionPolicyUpdate(
            variables: Variables$Mutation$driverDocumentRetentionPolicyUpdate(
              input: updateDriverDocumentRetentionPolicyInput,
            ),
          ),
        );
    return updateDriverDocumentRetentionPolicyOrError;
  }
}
