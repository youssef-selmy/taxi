import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/features/taxi/driver/driver_detail/presentation/features/driver_detail_documents/data/graphql/driver_detail_documents.graphql.dart';
import 'package:admin_frontend/features/taxi/driver/driver_detail/presentation/features/driver_detail_documents/data/repositories/driver_detail_documents_repository.dart';

@prod
@LazySingleton(as: DriverDetailDocumentsRepository)
class DriverDetailDocumentsRepositoryImpl
    implements DriverDetailDocumentsRepository {
  final GraphqlDatasource graphQLDatasource;

  DriverDetailDocumentsRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<Query$driverDocuments>> getDriverDocuments({
    required String id,
  }) async {
    final getDriverDocumentsOrError = await graphQLDatasource.query(
      Options$Query$driverDocuments(
        variables: Variables$Query$driverDocuments(id: id),
      ),
    );
    return getDriverDocumentsOrError;
  }
}
