import 'package:admin_frontend/logger.dart';
import 'package:api_response/api_response.dart';
import 'package:flutter/foundation.dart';
import 'package:graphql/client.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/core/graphql/documents/config.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/config.fragment.graphql.dart';
import 'package:admin_frontend/core/repositories/config_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@prod
@LazySingleton(as: ConfigRepository)
class LicenseRepositoryProd implements ConfigRepository {
  @override
  Stream<ApiResponse<Fragment$Config>> get configInformation =>
      _configInformation.stream;
  @override
  Stream<ApiResponse<Fragment$license?>> get licenseInformation =>
      _licenseInformation.stream;

  final _configInformation = BehaviorSubject<ApiResponse<Fragment$Config>>();
  final _licenseInformation = BehaviorSubject<ApiResponse<Fragment$license?>>();

  final GraphqlDatasource graphqlDatasource;

  LicenseRepositoryProd(this.graphqlDatasource);

  @override
  Future<ApiResponse<Query$ConfigInformation>> getConfigInformation() async {
    final result = await graphqlDatasource.query(
      Options$Query$ConfigInformation(fetchPolicy: FetchPolicy.noCache),
    );
    Log.i(result);
    _configInformation.add(result.mapData((data) => data.configInformation));
    _licenseInformation.add(result.mapData((data) => data.licenseInformation));
    return result;
  }

  @override
  Future<ApiResponse<void>> updateConfig({
    required Input$UpdateConfigInputV2 input,
  }) async {
    final updateResponse = await graphqlDatasource.mutate(
      Options$Mutation$updateConfig(
        fetchPolicy: FetchPolicy.noCache,
        variables: Variables$Mutation$updateConfig(config: input),
      ),
    );
    Log.i(updateResponse);

    final config = await getConfigInformation();
    if (kDebugMode) {
      print(config);
    }
    return updateResponse.mapData((data) {});
  }

  @override
  Future<ApiResponse<Mutation$updateLicense>> updateLicense({
    required String purchaseCode,
    required String email,
  }) async {
    final updateResponse = await graphqlDatasource.mutate(
      Options$Mutation$updateLicense(
        fetchPolicy: FetchPolicy.noCache,
        variables: Variables$Mutation$updateLicense(
          purchaseCode: purchaseCode,
          email: email,
        ),
      ),
    );
    Log.i(updateResponse);
    getConfigInformation();
    return updateResponse;
  }
}
