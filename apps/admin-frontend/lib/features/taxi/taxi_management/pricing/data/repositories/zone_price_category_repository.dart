import 'package:api_response/api_response.dart';

import 'package:admin_frontend/core/graphql/fragments/zone_price.graphql.dart';

abstract class ZonePriceCategoryRepository {
  Future<ApiResponse<Fragment$zonePriceCategory>> create({
    required String name,
  });

  Future<ApiResponse<Fragment$zonePriceCategory>> update({
    required String id,
    required String name,
  });

  Future<ApiResponse<String>> delete(String id);

  Future<ApiResponse<List<Fragment$zonePriceCategory>>> getAll();

  Future<ApiResponse<Fragment$zonePriceCategory>> getOne({required String id});
}
