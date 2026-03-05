import 'package:admin_frontend/schema.graphql.dart';
import 'package:api_response/api_response.dart';
import 'package:admin_frontend/core/graphql/fragments/dispatch_config.fragment.graphql.dart';

abstract class SettingsDispatchRepository {
  Future<ApiResponse<Fragment$DispatchConfig>> getDispatchConfig();

  Future<ApiResponse<Fragment$DispatchConfig>> updateDispatchConfig(
    Input$DispatchConfigInput input,
  );
}
