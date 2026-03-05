import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/graphql/fragments/system_configuration.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/system_configuration.mock.dart';
import 'package:admin_frontend/features/settings/features/settings_system/data/graphql/settings_system.graphql.dart';
import 'package:admin_frontend/features/settings/features/settings_system/data/repositories/settings_system_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@dev
@LazySingleton(as: SettingsSystemRepository)
class SettingsSystemRepositoryMock implements SettingsSystemRepository {
  @override
  Future<ApiResponse<Fragment$systemConfiguration>> getSystemSettings() async {
    return ApiResponse.loaded(mockSystemConfiguration);
  }

  @override
  Future<ApiResponse<Fragment$updateConfigResult>> updateSystemSettings({
    required Input$UpdateConfigInputV2 input,
  }) async {
    return ApiResponse.loaded(
      Fragment$updateConfigResult(
        status: Enum$UpdateConfigStatus.OK,
        message: "DONE",
      ),
    );
  }
}
