import 'package:api_response/api_response.dart';

import 'package:admin_frontend/schema.graphql.dart';

abstract class OrdersTaxiRepository {
  Future<ApiResponse<String>> exportAll({
    required List<Input$OrderSort> sort,
    required Input$OrderFilter filter,
    required Enum$ExportFormat format,
  });
}
