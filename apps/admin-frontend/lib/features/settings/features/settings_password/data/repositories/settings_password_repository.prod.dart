import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/features/settings/features/settings_password/data/graphql/settings_password.graphql.dart';
import 'package:admin_frontend/features/settings/features/settings_password/data/repositories/settings_password_repository.dart';

@prod
@LazySingleton(as: SettingsPasswordRepository)
class SettingsPasswordRepositoryImpl implements SettingsPasswordRepository {
  final GraphqlDatasource graphQLDatasource;

  SettingsPasswordRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<void>> updatePassword({
    required String previousPassword,
    required String newPassword,
  }) async {
    final result = await graphQLDatasource.mutate(
      Options$Mutation$updatePassword(
        variables: Variables$Mutation$updatePassword(
          previousPassword: previousPassword,
          newPassword: newPassword,
        ),
      ),
    );

    return result;
  }
}
