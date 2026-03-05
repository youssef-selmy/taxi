import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/graphql/fragments/fleet.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/page_info.mock.dart';
import 'package:admin_frontend/features/taxi/taxi_order/taxi_order_list/data/graphql/taxi_order_list.graphql.dart';
import 'package:admin_frontend/features/taxi/taxi_order/taxi_order_list/data/repositories/taxi_order_list_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@dev
@LazySingleton(as: TaxiOrderListRepository)
class TaxiOrderListRepositoryMock implements TaxiOrderListRepository {
  @override
  Future<ApiResponse<Query$fleets>> getFleets() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Query$fleets(
        fleets: Query$fleets$fleets(
          totalCount: mockFleetList.length,
          pageInfo: mockPageInfo,
          nodes: mockFleetList,
        ),
      ),
    );
  }

  @override
  Future<ApiResponse<Query$getOrdersOverview>> getTaxiOrderStatistics() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Query$getOrdersOverview(
        groupByStatus: [
          Query$getOrdersOverview$groupByStatus(
            count: Query$getOrdersOverview$groupByStatus$count(id: 43),
            groupBy: Query$getOrdersOverview$groupByStatus$groupBy(
              status: Enum$OrderStatus.RiderCanceled,
            ),
          ),
          Query$getOrdersOverview$groupByStatus(
            count: Query$getOrdersOverview$groupByStatus$count(id: 23),
            groupBy: Query$getOrdersOverview$groupByStatus$groupBy(
              status: Enum$OrderStatus.Finished,
            ),
          ),
          Query$getOrdersOverview$groupByStatus(
            count: Query$getOrdersOverview$groupByStatus$count(id: 6),
            groupBy: Query$getOrdersOverview$groupByStatus$groupBy(
              status: Enum$OrderStatus.Booked,
            ),
          ),
        ],
        totalRides: [
          Query$getOrdersOverview$totalRides(
            count: Query$getOrdersOverview$totalRides$count(id: 430),
          ),
        ],
        lastWeekRides: [
          Query$getOrdersOverview$lastWeekRides(
            count: Query$getOrdersOverview$lastWeekRides$count(id: 15),
          ),
        ],
        thisWeekRides: [
          Query$getOrdersOverview$thisWeekRides(
            count: Query$getOrdersOverview$thisWeekRides$count(id: 20),
          ),
        ],
        averageTotalRideCost: [
          Query$getOrdersOverview$averageTotalRideCost(
            avg: Query$getOrdersOverview$averageTotalRideCost$avg(
              costAfterCoupon: 12.5,
            ),
          ),
        ],
        averageLastWeekRideCost: [
          Query$getOrdersOverview$averageLastWeekRideCost(
            avg: Query$getOrdersOverview$averageLastWeekRideCost$avg(
              costAfterCoupon: 10,
            ),
          ),
        ],
        averageThisWeekRideCost: [
          Query$getOrdersOverview$averageThisWeekRideCost(
            avg: Query$getOrdersOverview$averageThisWeekRideCost$avg(
              costAfterCoupon: 13.4,
            ),
          ),
        ],
        averageTotalRideDuration: [
          Query$getOrdersOverview$averageTotalRideDuration(
            avg: Query$getOrdersOverview$averageTotalRideDuration$avg(
              durationBest: 542,
            ),
          ),
        ],
        averageLastWeekRideDuration: [
          Query$getOrdersOverview$averageLastWeekRideDuration(
            avg: Query$getOrdersOverview$averageLastWeekRideDuration$avg(
              durationBest: 500,
            ),
          ),
        ],
        averageThisWeekRideDuration: [
          Query$getOrdersOverview$averageThisWeekRideDuration(
            avg: Query$getOrdersOverview$averageThisWeekRideDuration$avg(
              durationBest: 420,
            ),
          ),
        ],
        totalSuccessRate: 45,
        lastWeekSuccessRate: 42,
        thisWeekSuccessRate: 46,
      ),
    );
  }
}
