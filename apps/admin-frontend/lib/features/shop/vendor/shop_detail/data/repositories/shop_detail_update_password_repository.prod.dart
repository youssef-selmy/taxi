import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/features/shop/vendor/shop_detail/data/graphql/shop_detail_update_password.graphql.dart';
import 'package:admin_frontend/features/shop/vendor/shop_detail/data/repositories/shop_detail_update_password_repository.dart';

@prod
@LazySingleton(as: ShopDetailUpdatePasswordRepository)
class ShopDetailUpdatePasswordRepositoryImpl
    implements ShopDetailUpdatePasswordRepository {
  final GraphqlDatasource graphQLDatasource;

  ShopDetailUpdatePasswordRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<void>> updatePassword({
    required String shopId,
    required String password,
  }) async {
    final updatePasswordOrError = await graphQLDatasource.mutate(
      Options$Mutation$updateShopAppPassword(
        variables: Variables$Mutation$updateShopAppPassword(
          shopId: shopId,
          password: password,
        ),
      ),
    );
    return updatePasswordOrError;
  }
}
