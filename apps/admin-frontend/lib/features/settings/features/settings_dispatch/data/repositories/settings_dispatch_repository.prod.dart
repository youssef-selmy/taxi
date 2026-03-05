import 'package:admin_frontend/core/graphql/fragments/dispatch_config.fragment.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';
import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';

import 'package:admin_frontend/features/settings/features/settings_dispatch/domain/repositories/settings_dispatch_repository.dart';
import 'package:admin_frontend/features/settings/features/settings_dispatch/data/graphql/settings_dispatch.graphql.dart';

@prod
@LazySingleton(as: SettingsDispatchRepository)
class SettingsDispatchRepositoryImpl implements SettingsDispatchRepository {
  final GraphqlDatasource graphQLDatasource;

  SettingsDispatchRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<Fragment$DispatchConfig>> getDispatchConfig() async {
    final response = await graphQLDatasource.query(
      Options$Query$DispatchConfig(),
    );
    return response.mapData((data) => data.dispatchConfig);
  }

  @override
  Future<ApiResponse<Fragment$DispatchConfig>> updateDispatchConfig(
    Input$DispatchConfigInput input,
  ) async {
    final response = await graphQLDatasource.mutate(
      Options$Mutation$UpdateDispatchConfig(
        variables: Variables$Mutation$UpdateDispatchConfig(input: input),
      ),
    );
    return response.mapData((data) => data.updateDispatchConfig);
  }
}
