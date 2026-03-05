import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/features/customer/customer_detail/data/repositories/orders_taxi_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@dev
@LazySingleton(as: OrdersTaxiRepository)
class OrdersTaxiRepositoryMock implements OrdersTaxiRepository {
  @override
  Future<ApiResponse<String>> exportAll({
    required List<Input$OrderSort> sort,
    required Input$OrderFilter filter,
    required Enum$ExportFormat format,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      "mocked_csv_data"
      ".${format.name.toLowerCase()}",
    );
  }
}
