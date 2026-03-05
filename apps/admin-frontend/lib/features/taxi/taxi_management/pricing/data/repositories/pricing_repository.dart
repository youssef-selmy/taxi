import 'package:api_response/api_response.dart';

import 'package:admin_frontend/core/graphql/fragments/taxi_pricing.graphql.dart';
import 'package:admin_frontend/features/taxi/taxi_management/pricing/data/graphql/pricing.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

abstract class PricingRepository {
  Future<ApiResponse<List<Fragment$taxiPricingListItem>>> getAll({
    required String? categoryId,
    required String? searchQuery,
    required Input$OffsetPaging? paging,
  });
  Future<ApiResponse<Query$taxiPricing>> getById({required String id});
  Future<ApiResponse<Fragment$taxiPricing>> create({
    required Input$ServiceInput input,
    required List<String> regionIds,
    required List<String> optionIds,
  });
  Future<ApiResponse<Fragment$taxiPricing>> update({
    required String id,
    required Input$ServiceInput input,
    required List<String> regionIds,
    required List<String> optionIds,
  });
  Future<ApiResponse<void>> delete({required String id});

  Future<ApiResponse<Query$taxiPricingFieldOptions>> getFieldOptions();
}
