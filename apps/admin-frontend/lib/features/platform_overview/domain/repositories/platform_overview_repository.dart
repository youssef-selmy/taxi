import 'package:admin_frontend/schema.graphql.dart';
import 'package:api_response/api_response.dart';
import 'package:admin_frontend/features/platform_overview/data/graphql/platform_overview.graphql.dart';

abstract class PlatformOverviewRepository {
  Future<ApiResponse<Query$pendingSupportRequestsCount>>
  getpendingSupportRequestsCount();

  Future<ApiResponse<Query$pendingOrders>> getPendingOrders();

  Future<ApiResponse<Query$shopOrders>> getShopOrders({
    required Input$OffsetPaging? paging,
    required Input$ShopOrderFilter filter,
    required List<Input$ShopOrderSort> sorting,
  });

  Future<ApiResponse<Query$parkingOrders>> getParkingOrders({
    required Input$OffsetPaging? paging,
    required Input$ParkOrderFilter filter,
    required List<Input$ParkOrderSort> sorting,
  });

  Future<ApiResponse<Query$platfromOverviewKPIs>> getOverviewKPIs({
    required String currency,
    required Enum$KPIPeriod period,
  });

  Future<ApiResponse<Query$orderVolumeTimeSeries>> getOrderVolumeTimeSeries({
    required Enum$KPIPeriod period,
  });
}
