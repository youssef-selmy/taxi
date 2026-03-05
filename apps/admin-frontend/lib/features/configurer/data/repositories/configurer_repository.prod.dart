import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/features/configurer/domain/repositories/configurer_repository.dart';

@prod
@LazySingleton(as: ConfigurerRepository)
class ConfigurerRepositoryImpl implements ConfigurerRepository {
  final GraphqlDatasource graphQLDatasource;

  ConfigurerRepositoryImpl(this.graphQLDatasource);
}
