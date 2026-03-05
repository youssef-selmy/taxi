import 'package:api_response/api_response.dart';

import 'package:admin_frontend/core/graphql/fragments/zone_price.graphql.dart';
import 'package:admin_frontend/features/taxi/taxi_management/pricing/data/graphql/zone_price.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

abstract class ZonePriceRepository {
  Future<ApiResponse<Fragment$zonePrice>> create({
    required Input$ZonePriceInput input,
    required List<String> fleetIds,
    required List<String> serviceIds,
  });

  Future<ApiResponse<Fragment$zonePrice>> update({
    required String id,
    required Input$ZonePriceInput input,
    required List<String> fleetIds,
    required List<String> serviceIds,
  });

  Future<ApiResponse<String>> delete(String id);

  Future<ApiResponse<Query$zonePrices>> getAll({
    required String? categoryId,
    required String? search,
  });

  Future<ApiResponse<Query$zonePrice>> getOne({required String id});

  Future<ApiResponse<Query$zonePriceFieldOptions>> getFieldOptions();
}
