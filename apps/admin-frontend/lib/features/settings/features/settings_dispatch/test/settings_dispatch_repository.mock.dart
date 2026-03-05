import 'package:admin_frontend/core/graphql/fragments/dispatch_config.fragment.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';
import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/features/settings/features/settings_dispatch/domain/repositories/settings_dispatch_repository.dart';

@dev
@LazySingleton(as: SettingsDispatchRepository)
class SettingsDispatchRepositoryMock implements SettingsDispatchRepository {
  @override
  Future<ApiResponse<Fragment$DispatchConfig>> getDispatchConfig() async {
    return ApiResponse.loaded(
      Fragment$DispatchConfig(
        strategy: Enum$DispatchStrategy.Broadcast,
        requestTimeoutSeconds: 30,
        maxSearchRadiusMeters: 100,
        preDispatchBufferMinutes: 30,
      ),
    );
  }

  @override
  Future<ApiResponse<Fragment$DispatchConfig>> updateDispatchConfig(
    Input$DispatchConfigInput input,
  ) async {
    return ApiResponse.loaded(
      Fragment$DispatchConfig(
        strategy: Enum$DispatchStrategy.Broadcast,
        requestTimeoutSeconds: 30,
        maxSearchRadiusMeters: 100,
        preDispatchBufferMinutes: 30,
      ),
    );
  }
}
