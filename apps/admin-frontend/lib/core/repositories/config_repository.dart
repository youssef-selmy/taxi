import 'package:api_response/api_response.dart';

import 'package:admin_frontend/core/graphql/documents/config.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/config.fragment.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

abstract class ConfigRepository {
  Stream<ApiResponse<Fragment$Config>> get configInformation;
  Stream<ApiResponse<Fragment$license?>> get licenseInformation;

  Future<void> getConfigInformation();

  Future<ApiResponse<Mutation$updateLicense>> updateLicense({
    required String purchaseCode,
    required String email,
  });

  Future<ApiResponse<void>> updateConfig({
    required Input$UpdateConfigInputV2 input,
  });
}
