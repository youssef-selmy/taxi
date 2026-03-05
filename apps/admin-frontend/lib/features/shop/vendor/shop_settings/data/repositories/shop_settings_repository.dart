import 'package:api_response/api_response.dart';

import 'package:admin_frontend/features/shop/vendor/shop_settings/data/graphql/shop_settings.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

abstract class ShopSettingsRepository {
  Future<ApiResponse<Query$shopDocuments>> getShopDocuments();
  Future<ApiResponse<Mutation$shopDocumentCreate>> createShopDocument({
    required Input$CreateManyShopDocumentsInput createShopDocumentInput,
  });

  Future<ApiResponse<Mutation$shopDocumentDelete>> deleteShopDocument({
    required Input$DeleteManyShopDocumentsInput deleteShopDocumentInput,
  });

  Future<ApiResponse<Mutation$shopDocumentUpdate>> updateShopDocument({
    required Input$UpdateOneShopDocumentInput updateShopDocumentInput,
  });

  Future<ApiResponse<Mutation$shopDocumentRetentionPolicyCreate>>
  createShopDocumentRetentionPolicy({
    required Input$CreateManyShopDocumentRetentionPoliciesInput
    createShopDocumentRetentionPolicyInput,
  });

  Future<ApiResponse<Mutation$shopDocumentRetentionPolicyDelete>>
  deleteShopDocumentRetentionPolicy({
    required Input$DeleteManyShopDocumentRetentionPoliciesInput
    deleteShopDocumentRetentionPolicyInput,
  });

  Future<ApiResponse<Mutation$shopDocumentRetentionPolicyUpdate>>
  updateShopDocumentRetentionPolicy({
    required Input$UpdateOneShopDocumentRetentionPolicyInput
    updateShopDocumentRetentionPolicyInput,
  });
}
