import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/features/settings/features/settings_branding/data/repositories/settings_branding_repository.dart';

@prod
@LazySingleton(as: SettingsBrandingRepository)
class SettingsBrandingRepositoryImpl implements SettingsBrandingRepository {
  final GraphqlDatasource graphQLDatasource;

  SettingsBrandingRepositoryImpl(this.graphQLDatasource);
}
