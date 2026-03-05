import 'package:api_response/api_response.dart';

import 'package:admin_frontend/features/taxi/driver/create_new_driver/data/graphql/create_new_driver.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

abstract class CreateNewDriverRepository {
  Future<ApiResponse<Query$driverDetails>> getdriverDetails();

  Future<ApiResponse<Query$driverDocuments>> getDriverDocuments();

  Future<ApiResponse<Query$services>> getServices();

  Future<ApiResponse<Mutation$createDriver>> createDriver({
    required Input$CreateOneDriverInput input,
  });

  Future<ApiResponse<Mutation$createDriverToDriverDocument>>
  createDriverToDriverDocument({
    required Input$CreateOneDriverToDriverDocumentInput input,
  });

  Future<ApiResponse<Mutation$setEnabledServices>> setEnabledServices({
    required Input$SetActiveServicesOnDriverInput input,
  });
}
