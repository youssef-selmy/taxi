import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/features/taxi/driver/create_new_driver/data/graphql/create_new_driver.graphql.dart';
import 'package:admin_frontend/features/taxi/driver/create_new_driver/data/repositories/create_new_driver_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@prod
@LazySingleton(as: CreateNewDriverRepository)
class CreateNewDriverRepositoryImpl implements CreateNewDriverRepository {
  final GraphqlDatasource graphQLDatasource;

  CreateNewDriverRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<Query$driverDetails>> getdriverDetails() async {
    final getdriverDetailsOrError = await graphQLDatasource.query(
      Options$Query$driverDetails(),
    );
    return getdriverDetailsOrError;
  }

  @override
  Future<ApiResponse<Query$driverDocuments>> getDriverDocuments() async {
    final getdriverDocumentsOrError = await graphQLDatasource.query(
      Options$Query$driverDocuments(),
    );
    return getdriverDocumentsOrError;
  }

  @override
  Future<ApiResponse<Query$services>> getServices() async {
    final getServicesOrError = await graphQLDatasource.query(
      Options$Query$services(),
    );
    return getServicesOrError;
  }

  @override
  Future<ApiResponse<Mutation$createDriver>> createDriver({
    required Input$CreateOneDriverInput input,
  }) async {
    final createDriverOrError = await graphQLDatasource.mutate(
      Options$Mutation$createDriver(
        variables: Variables$Mutation$createDriver(input: input),
      ),
    );
    return createDriverOrError;
  }

  @override
  Future<ApiResponse<Mutation$createDriverToDriverDocument>>
  createDriverToDriverDocument({
    required Input$CreateOneDriverToDriverDocumentInput input,
  }) async {
    final createDriverToDriverDocumentOrError = await graphQLDatasource.mutate(
      Options$Mutation$createDriverToDriverDocument(
        variables: Variables$Mutation$createDriverToDriverDocument(
          input: input,
        ),
      ),
    );
    return createDriverToDriverDocumentOrError;
  }

  @override
  Future<ApiResponse<Mutation$setEnabledServices>> setEnabledServices({
    required Input$SetActiveServicesOnDriverInput input,
  }) async {
    final setEnabledServicesOrError = await graphQLDatasource.mutate(
      Options$Mutation$setEnabledServices(
        variables: Variables$Mutation$setEnabledServices(input: input),
      ),
    );
    return setEnabledServicesOrError;
  }
}
