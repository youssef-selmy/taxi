import 'package:admin_frontend/core/graphql/fragments/page_info.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/parking_order.fragment.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/shop_order.graphql.mock.dart';
import 'package:admin_frontend/features/platform_overview/data/graphql/platform_overview.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';
import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/features/platform_overview/domain/repositories/platform_overview_repository.dart';

@dev
@LazySingleton(as: PlatformOverviewRepository)
class PlatformOverviewRepositoryMock implements PlatformOverviewRepository {
  @override
  Future<ApiResponse<Query$pendingSupportRequestsCount>>
  getpendingSupportRequestsCount() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Query$pendingSupportRequestsCount(
        taxiSupportRequests:
            Query$pendingSupportRequestsCount$taxiSupportRequests(
              totalCount: 8,
            ),
        shopSupportRequests:
            Query$pendingSupportRequestsCount$shopSupportRequests(
              totalCount: 32,
            ),
        parkingSupportRequests:
            Query$pendingSupportRequestsCount$parkingSupportRequests(
              totalCount: 14,
            ),
      ),
    );
  }

  @override
  Future<ApiResponse<Query$pendingOrders>> getPendingOrders() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Query$pendingOrders(
        taxiOrders: Query$pendingOrders$taxiOrders(totalCount: 9),
        shopOrders: Query$pendingOrders$shopOrders(totalCount: 4),
        parkOrders: Query$pendingOrders$parkOrders(totalCount: 2),
      ),
    );
  }

  @override
  Future<ApiResponse<Query$platfromOverviewKPIs>> getOverviewKPIs({
    required String currency,
    required Enum$KPIPeriod period,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Query$platfromOverviewKPIs(
        platformKPI: Query$platfromOverviewKPIs$platformKPI(
          totalOrders: Fragment$platformKPIItem(
            name: "Total Orders",
            total: 3401,
            change: 8,
            breakdown: [
              Fragment$platformKPIItem$breakdown(
                app: Enum$AppType.Taxi,
                value: 423,
                percentage: 32,
              ),
              Fragment$platformKPIItem$breakdown(
                app: Enum$AppType.Shop,
                value: 1000,
                percentage: 43,
              ),
              Fragment$platformKPIItem$breakdown(
                app: Enum$AppType.Parking,
                value: 400,
                percentage: 25,
              ),
            ],
          ),
          totalRevenue: Fragment$platformKPIItem(
            name: "Total Revenue",
            total: 83,
            change: 5,
            breakdown: [
              Fragment$platformKPIItem$breakdown(
                app: Enum$AppType.Taxi,
                value: 423,
                percentage: 32,
              ),
              Fragment$platformKPIItem$breakdown(
                app: Enum$AppType.Shop,
                value: 1000,
                percentage: 40,
              ),
              Fragment$platformKPIItem$breakdown(
                app: Enum$AppType.Parking,
                value: 400,
                percentage: 28,
              ),
            ],
          ),
          activeCustomers: Fragment$platformKPIItem(
            name: "Active Customers",
            total: 123,
            change: 2,
            breakdown: [
              Fragment$platformKPIItem$breakdown(
                app: Enum$AppType.Taxi,
                value: 423,
                percentage: 32,
              ),
              Fragment$platformKPIItem$breakdown(
                app: Enum$AppType.Shop,
                value: 1000,
                percentage: 40,
              ),
              Fragment$platformKPIItem$breakdown(
                app: Enum$AppType.Parking,
                value: 400,
                percentage: 28,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Future<ApiResponse<Query$parkingOrders>> getParkingOrders({
    required Input$OffsetPaging? paging,
    required Input$ParkOrderFilter filter,
    required List<Input$ParkOrderSort> sorting,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Query$parkingOrders(
        parkOrders: Query$parkingOrders$parkOrders(
          nodes: mockParkingOrderListItems,
          pageInfo: mockPageInfo,
          totalCount: mockParkingOrderListItems.length,
        ),
      ),
    );
  }

  @override
  Future<ApiResponse<Query$shopOrders>> getShopOrders({
    required Input$OffsetPaging? paging,
    required Input$ShopOrderFilter filter,
    required List<Input$ShopOrderSort> sorting,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Query$shopOrders(
        shopOrders: Query$shopOrders$shopOrders(
          nodes: mockShopOrderListItems,
          pageInfo: mockPageInfo,
          totalCount: mockShopOrderListItems.length,
        ),
      ),
    );
  }

  @override
  Future<ApiResponse<Query$orderVolumeTimeSeries>> getOrderVolumeTimeSeries({
    required Enum$KPIPeriod period,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Query$orderVolumeTimeSeries(
        orderVolumeTimeSeries: [
          Query$orderVolumeTimeSeries$orderVolumeTimeSeries(
            app: Enum$AppType.Taxi,
            buckets: [
              Query$orderVolumeTimeSeries$orderVolumeTimeSeries$buckets(
                date: 'Mon',
                orderCount: 534,
              ),
              Query$orderVolumeTimeSeries$orderVolumeTimeSeries$buckets(
                date: 'Tue',
                orderCount: 432,
              ),
              Query$orderVolumeTimeSeries$orderVolumeTimeSeries$buckets(
                date: 'Wed',
                orderCount: 502,
              ),
              Query$orderVolumeTimeSeries$orderVolumeTimeSeries$buckets(
                date: 'Thu',
                orderCount: 742,
              ),
              Query$orderVolumeTimeSeries$orderVolumeTimeSeries$buckets(
                date: 'Fri',
                orderCount: 822,
              ),
              Query$orderVolumeTimeSeries$orderVolumeTimeSeries$buckets(
                date: 'Sat',
                orderCount: 744,
              ),
            ],
          ),
          Query$orderVolumeTimeSeries$orderVolumeTimeSeries(
            app: Enum$AppType.Shop,
            buckets: [
              Query$orderVolumeTimeSeries$orderVolumeTimeSeries$buckets(
                date: 'Mon',
                orderCount: 634,
              ),
              Query$orderVolumeTimeSeries$orderVolumeTimeSeries$buckets(
                date: 'Tue',
                orderCount: 532,
              ),
              Query$orderVolumeTimeSeries$orderVolumeTimeSeries$buckets(
                date: 'Wed',
                orderCount: 402,
              ),
              Query$orderVolumeTimeSeries$orderVolumeTimeSeries$buckets(
                date: 'Thu',
                orderCount: 642,
              ),
              Query$orderVolumeTimeSeries$orderVolumeTimeSeries$buckets(
                date: 'Fri',
                orderCount: 622,
              ),
              Query$orderVolumeTimeSeries$orderVolumeTimeSeries$buckets(
                date: 'Sat',
                orderCount: 844,
              ),
            ],
          ),
          Query$orderVolumeTimeSeries$orderVolumeTimeSeries(
            app: Enum$AppType.Parking,
            buckets: [
              Query$orderVolumeTimeSeries$orderVolumeTimeSeries$buckets(
                date: 'Mon',
                orderCount: 434,
              ),
              Query$orderVolumeTimeSeries$orderVolumeTimeSeries$buckets(
                date: 'Tue',
                orderCount: 332,
              ),
              Query$orderVolumeTimeSeries$orderVolumeTimeSeries$buckets(
                date: 'Wed',
                orderCount: 402,
              ),
              Query$orderVolumeTimeSeries$orderVolumeTimeSeries$buckets(
                date: 'Thu',
                orderCount: 342,
              ),
              Query$orderVolumeTimeSeries$orderVolumeTimeSeries$buckets(
                date: 'Fri',
                orderCount: 222,
              ),
              Query$orderVolumeTimeSeries$orderVolumeTimeSeries$buckets(
                date: 'Sat',
                orderCount: 444,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
