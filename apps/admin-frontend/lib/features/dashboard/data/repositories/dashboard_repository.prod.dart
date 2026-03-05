import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/features/dashboard/domain/repositories/dashboard_repository.dart';

@prod
@LazySingleton(as: DashboardRepository)
class DashboardRepositoryImpl implements DashboardRepository {
  final GraphqlDatasource graphQLDatasource;

  DashboardRepositoryImpl(this.graphQLDatasource);
}
