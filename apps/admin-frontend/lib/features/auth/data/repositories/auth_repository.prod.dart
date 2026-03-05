import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/features/auth/data/graphql/auth.graphql.dart';
import 'package:admin_frontend/features/auth/data/repositories/auth_repository.dart';

@prod
@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final GraphqlDatasource graphQLDatasource;

  AuthRepositoryImpl(this.graphQLDatasource);

  // @override
  // Future<ApiResponse<Mutation$ActivateServer>> activateServer({
  //   required String purchaseCode,
  //   required String email,
  // }) {
  //   return graphQLDatasource.mutate(
  //     Options$Mutation$ActivateServer(
  //       variables: Variables$Mutation$ActivateServer(
  //         purchaseCode: purchaseCode,
  //         email: email,
  //       ),
  //     ),
  //   );
  // }

  @override
  Future<ApiResponse<Mutation$DisableServer>> disableServer({
    required String purchaseCode,
    required String ip,
  }) {
    return graphQLDatasource.mutate(
      Options$Mutation$DisableServer(
        variables: Variables$Mutation$DisableServer(ip: ip),
      ),
    );
  }
}
