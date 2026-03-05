import 'package:admin_frontend/features/shop/vendor/shop_settings/data/graphql/shop_settings.graphql.dart';
import 'package:admin_frontend/features/shop/vendor/shop_settings/data/repositories/shop_settings_repository.dart';
import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/schema.graphql.dart';

@prod
@LazySingleton(as: ShopSettingsRepository)
class ShopSettingsRepositoryImpl implements ShopSettingsRepository {
  final GraphqlDatasource graphQLDatasource;

  ShopSettingsRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<Query$shopDocuments>> getShopDocuments() async {
    final shopDocumentsOrError = await graphQLDatasource.query(
      Options$Query$shopDocuments(),
    );
    return shopDocumentsOrError;
  }

  @override
  Future<ApiResponse<Mutation$shopDocumentCreate>> createShopDocument({
    required Input$CreateManyShopDocumentsInput createShopDocumentInput,
  }) async {
    final createShopDocumentOrError = await graphQLDatasource.mutate(
      Options$Mutation$shopDocumentCreate(
        variables: Variables$Mutation$shopDocumentCreate(
          input: createShopDocumentInput,
        ),
      ),
    );
    return createShopDocumentOrError;
  }

  @override
  Future<ApiResponse<Mutation$shopDocumentDelete>> deleteShopDocument({
    required Input$DeleteManyShopDocumentsInput deleteShopDocumentInput,
  }) async {
    final deleteShopDocumentOrError = await graphQLDatasource.mutate(
      Options$Mutation$shopDocumentDelete(
        variables: Variables$Mutation$shopDocumentDelete(
          input: deleteShopDocumentInput,
        ),
      ),
    );
    return deleteShopDocumentOrError;
  }

  @override
  Future<ApiResponse<Mutation$shopDocumentUpdate>> updateShopDocument({
    required Input$UpdateOneShopDocumentInput updateShopDocumentInput,
  }) async {
    final updateShopDocumentOrError = await graphQLDatasource.mutate(
      Options$Mutation$shopDocumentUpdate(
        variables: Variables$Mutation$shopDocumentUpdate(
          input: updateShopDocumentInput,
        ),
      ),
    );
    return updateShopDocumentOrError;
  }

  @override
  Future<ApiResponse<Mutation$shopDocumentRetentionPolicyCreate>>
  createShopDocumentRetentionPolicy({
    required Input$CreateManyShopDocumentRetentionPoliciesInput
    createShopDocumentRetentionPolicyInput,
  }) async {
    final createShopDocumentRetentionPolicyOrError = await graphQLDatasource
        .mutate(
          Options$Mutation$shopDocumentRetentionPolicyCreate(
            variables: Variables$Mutation$shopDocumentRetentionPolicyCreate(
              input: createShopDocumentRetentionPolicyInput,
            ),
          ),
        );
    return createShopDocumentRetentionPolicyOrError;
  }

  @override
  Future<ApiResponse<Mutation$shopDocumentRetentionPolicyDelete>>
  deleteShopDocumentRetentionPolicy({
    required Input$DeleteManyShopDocumentRetentionPoliciesInput
    deleteShopDocumentRetentionPolicyInput,
  }) async {
    final deleteShopDocumentRetentionPolicyOrError = await graphQLDatasource
        .mutate(
          Options$Mutation$shopDocumentRetentionPolicyDelete(
            variables: Variables$Mutation$shopDocumentRetentionPolicyDelete(
              input: deleteShopDocumentRetentionPolicyInput,
            ),
          ),
        );
    return deleteShopDocumentRetentionPolicyOrError;
  }

  @override
  Future<ApiResponse<Mutation$shopDocumentRetentionPolicyUpdate>>
  updateShopDocumentRetentionPolicy({
    required Input$UpdateOneShopDocumentRetentionPolicyInput
    updateShopDocumentRetentionPolicyInput,
  }) async {
    final updateShopDocumentRetentionPolicyOrError = await graphQLDatasource
        .mutate(
          Options$Mutation$shopDocumentRetentionPolicyUpdate(
            variables: Variables$Mutation$shopDocumentRetentionPolicyUpdate(
              input: updateShopDocumentRetentionPolicyInput,
            ),
          ),
        );
    return updateShopDocumentRetentionPolicyOrError;
  }
}
