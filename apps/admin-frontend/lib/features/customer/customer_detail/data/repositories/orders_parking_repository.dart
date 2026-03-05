import 'package:api_response/api_response.dart';

import 'package:admin_frontend/features/customer/customer_detail/data/graphql/orders_parking.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

abstract class OrdersParkingRepository {
  Future<ApiResponse<Query$customerOrdersParking>> getAll({
    required Input$ParkOrderFilter filter,
    required Input$OffsetPaging? paging,
    required List<Input$ParkOrderSort> sorting,
  });

  Future<ApiResponse<String>> export({
    required List<Input$ParkOrderSort> sort,
    required Input$ParkOrderFilter filter,
    required Enum$ExportFormat format,
  });
}
