import 'package:admin_frontend/core/graphql/fragments/shop_document.mock.dart';
import 'package:admin_frontend/features/shop/vendor/shop_settings/data/graphql/shop_settings.graphql.dart';
import 'package:admin_frontend/features/shop/vendor/shop_settings/data/repositories/shop_settings_repository.dart';
import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/schema.graphql.dart';

@dev
@LazySingleton(as: ShopSettingsRepository)
class ShopSettingsRepositoryMock implements ShopSettingsRepository {
  @override
  Future<ApiResponse<Query$shopDocuments>> getShopDocuments() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Query$shopDocuments(shopDocuments: mockShopDocumentList),
    );
  }

  @override
  Future<ApiResponse<Mutation$shopDocumentCreate>> createShopDocument({
    required Input$CreateManyShopDocumentsInput createShopDocumentInput,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Mutation$shopDocumentCreate(
        createManyShopDocuments: mockShopDocumentList,
      ),
    );
  }

  @override
  Future<ApiResponse<Mutation$shopDocumentDelete>> deleteShopDocument({
    required Input$DeleteManyShopDocumentsInput deleteShopDocumentInput,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Mutation$shopDocumentDelete(
        deleteManyShopDocuments:
            Mutation$shopDocumentDelete$deleteManyShopDocuments(
              deletedCount: 3,
            ),
      ),
    );
  }

  @override
  Future<ApiResponse<Mutation$shopDocumentUpdate>> updateShopDocument({
    required Input$UpdateOneShopDocumentInput updateShopDocumentInput,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Mutation$shopDocumentUpdate(updateOneShopDocument: mockShopDocument1),
    );
  }

  @override
  Future<ApiResponse<Mutation$shopDocumentRetentionPolicyCreate>>
  createShopDocumentRetentionPolicy({
    required Input$CreateManyShopDocumentRetentionPoliciesInput
    createShopDocumentRetentionPolicyInput,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Mutation$shopDocumentRetentionPolicyCreate(
        createManyShopDocumentRetentionPolicies: mockRetentionPolicies,
      ),
    );
  }

  @override
  Future<ApiResponse<Mutation$shopDocumentRetentionPolicyDelete>>
  deleteShopDocumentRetentionPolicy({
    required Input$DeleteManyShopDocumentRetentionPoliciesInput
    deleteShopDocumentRetentionPolicyInput,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Mutation$shopDocumentRetentionPolicyDelete(
        deleteManyShopDocumentRetentionPolicies:
            Mutation$shopDocumentRetentionPolicyDelete$deleteManyShopDocumentRetentionPolicies(
              deletedCount: 3,
            ),
      ),
    );
  }

  @override
  Future<ApiResponse<Mutation$shopDocumentRetentionPolicyUpdate>>
  updateShopDocumentRetentionPolicy({
    required Input$UpdateOneShopDocumentRetentionPolicyInput
    updateShopDocumentRetentionPolicyInput,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Mutation$shopDocumentRetentionPolicyUpdate(
        updateOneShopDocumentRetentionPolicy: mockRetentionPolicies1,
      ),
    );
  }
}
