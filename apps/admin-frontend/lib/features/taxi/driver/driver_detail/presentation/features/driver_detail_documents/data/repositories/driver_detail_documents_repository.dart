import 'package:api_response/api_response.dart';

import 'package:admin_frontend/features/taxi/driver/driver_detail/presentation/features/driver_detail_documents/data/graphql/driver_detail_documents.graphql.dart';

abstract class DriverDetailDocumentsRepository {
  Future<ApiResponse<Query$driverDocuments>> getDriverDocuments({
    required String id,
  });
}
