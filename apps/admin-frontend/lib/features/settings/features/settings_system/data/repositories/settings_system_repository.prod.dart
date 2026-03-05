import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/core/graphql/fragments/system_configuration.fragment.graphql.dart';
import 'package:admin_frontend/features/settings/features/settings_system/data/graphql/settings_system.graphql.dart';
import 'package:admin_frontend/features/settings/features/settings_system/data/repositories/settings_system_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@prod
@LazySingleton(as: SettingsSystemRepository)
class SettingsSystemRepositoryImpl implements SettingsSystemRepository {
  final GraphqlDatasource graphQLDatasource;

  SettingsSystemRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<Fragment$systemConfiguration>> getSystemSettings() async {
    final settingsOrError = await graphQLDatasource.query(
      Options$Query$systemSettings(),
    );
    return settingsOrError.mapData((r) => r.currentConfiguration);
  }

  @override
  Future<ApiResponse<Fragment$updateConfigResult>> updateSystemSettings({
    required Input$UpdateConfigInputV2 input,
  }) async {
    final settingsOrError = await graphQLDatasource.mutate(
      Options$Mutation$updateSystemSettings(
        variables: Variables$Mutation$updateSystemSettings(input: input),
      ),
    );
    return settingsOrError.mapData((r) => r.updateConfigurations);
  }
}
