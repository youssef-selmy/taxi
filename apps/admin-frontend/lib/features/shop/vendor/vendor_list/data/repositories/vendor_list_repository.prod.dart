import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/features/shop/vendor/vendor_list/data/graphql/vendor_list.graphql.dart';
import 'package:admin_frontend/features/shop/vendor/vendor_list/data/repositories/vendor_list_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@prod
@LazySingleton(as: VendorListRepository)
class VendorListRepositoryImpl implements VendorListRepository {
  final GraphqlDatasource graphQLDatasource;

  VendorListRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<Query$vendors>> getVendors({
    required Input$OffsetPaging? paging,
    required Input$ShopFilter filter,
    required List<Input$ShopSort> sort,
  }) async {
    final vendorsOrError = await graphQLDatasource.query(
      Options$Query$vendors(
        variables: Variables$Query$vendors(
          paging: paging,
          filter: filter,
          sorting: sort,
        ),
      ),
    );
    return vendorsOrError;
  }

  @override
  Future<ApiResponse<Query$vendorCategories>> getVendorCategories() async {
    final shopCategoriesState = await graphQLDatasource.query(
      Options$Query$vendorCategories(),
    );
    return shopCategoriesState;
  }
}
