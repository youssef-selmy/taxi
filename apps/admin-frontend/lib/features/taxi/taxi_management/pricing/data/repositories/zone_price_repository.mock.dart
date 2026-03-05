import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/graphql/fragments/fleet.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/page_info.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/taxi_pricing.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/zone_price.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/zone_price.graphql.mock.dart';
import 'package:admin_frontend/features/taxi/taxi_management/pricing/data/graphql/zone_price.graphql.dart';
import 'package:admin_frontend/features/taxi/taxi_management/pricing/data/repositories/zone_price_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@dev
@LazySingleton(as: ZonePriceRepository)
class ZonePriceRepositoryMock implements ZonePriceRepository {
  @override
  Future<ApiResponse<Fragment$zonePrice>> create({
    required Input$ZonePriceInput input,
    required List<String> fleetIds,
    required List<String> serviceIds,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(mockZonePrice);
  }

  @override
  Future<ApiResponse<String>> delete(String id) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(id);
  }

  @override
  Future<ApiResponse<Query$zonePrices>> getAll({
    required String? categoryId,
    required String? search,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Query$zonePrices(
        zonePrices: Query$zonePrices$zonePrices(
          nodes: mockZonePriceListItems,
          pageInfo: mockPageInfo,
          totalCount: mockZonePriceListItems.length,
        ),
      ),
    );
  }

  @override
  Future<ApiResponse<Query$zonePrice>> getOne({required String id}) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(Query$zonePrice(zonePrice: mockZonePrice));
  }

  @override
  Future<ApiResponse<Fragment$zonePrice>> update({
    required String id,
    required Input$ZonePriceInput input,
    required List<String> fleetIds,
    required List<String> serviceIds,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(mockZonePrice);
  }

  @override
  Future<ApiResponse<Query$zonePriceFieldOptions>> getFieldOptions() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Query$zonePriceFieldOptions(
        services: [
          mockTaxiPricingListItem1,
          mockTaxiPricingListItem2,
          mockTaxiPricingListItem3,
          mockTaxiPricingListItem4,
        ],
        fleets: Query$zonePriceFieldOptions$fleets(nodes: mockFleetList),
      ),
    );
  }
}
