import 'package:api_response/api_response.dart';

import 'package:admin_frontend/core/graphql/fragments/system_configuration.fragment.graphql.dart';
import 'package:admin_frontend/features/settings/features/settings_system/data/graphql/settings_system.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

abstract class SettingsSystemRepository {
  Future<ApiResponse<Fragment$systemConfiguration>> getSystemSettings();
  Future<ApiResponse<Fragment$updateConfigResult>> updateSystemSettings({
    required Input$UpdateConfigInputV2 input,
  });
}
