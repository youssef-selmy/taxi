import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/features/settings/features/settings_subscription/data/repositories/settings_subscription_repository.dart';

@prod
@LazySingleton(as: SettingsSubscriptionRepository)
class SettingsSubscriptionRepositoryImpl
    implements SettingsSubscriptionRepository {
  final GraphqlDatasource graphQLDatasource;

  SettingsSubscriptionRepositoryImpl(this.graphQLDatasource);
}
