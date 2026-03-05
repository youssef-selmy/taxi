import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/features/settings/features/settings_general/data/repositories/settings_general_repository.dart';

@prod
@LazySingleton(as: SettingsGeneralRepository)
class SettingsGeneralRepositoryImpl implements SettingsGeneralRepository {
  final GraphqlDatasource graphQLDatasource;

  SettingsGeneralRepositoryImpl(this.graphQLDatasource);
}
