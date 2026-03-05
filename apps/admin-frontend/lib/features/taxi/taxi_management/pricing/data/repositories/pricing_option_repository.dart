import 'package:api_response/api_response.dart';

import 'package:admin_frontend/core/graphql/fragments/taxi_order_option.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

abstract class PricingOptionRepository {
  Future<ApiResponse<List<Fragment$taxiOrderOption>>> getAll();
  Future<ApiResponse<Fragment$taxiOrderOption>> getById({required String id});
  Future<ApiResponse<Fragment$taxiOrderOption>> create({
    required Input$ServiceOptionInput input,
  });
  Future<ApiResponse<Fragment$taxiOrderOption>> update({
    required String id,
    required Input$ServiceOptionInput input,
  });
  Future<ApiResponse<void>> delete({required String id});
}
